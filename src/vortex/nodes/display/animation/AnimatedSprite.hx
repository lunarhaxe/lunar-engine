package vortex.nodes.display.animation;

import vortex.servers.RenderingServer;
import glad.Glad;

import vortex.backend.Application;

import vortex.servers.rendering.OpenGLBackend;

import vortex.resources.Shader;
import vortex.resources.SpriteFrames;

import vortex.utils.math.Vector2;
import vortex.utils.math.Vector3;
import vortex.utils.math.Vector4;
import vortex.utils.math.Rectangle;
import vortex.utils.math.Matrix4x4;

/**
 * A basic sprite class that can render animations.
 */
class AnimatedSprite extends Node2D {
	/**
	 * The resource containing the texture this sprite
	 * draws along with animation data for proper rendering.
	 */
	public var frames(default, set):SpriteFrames;

	/**
	 * The object responsible for playing animations on this sprite.
	 */
	public var animation(default, null):AnimationPlayer;

	/**
	 * The rendered portion of the texture.
	 * 
	 * Set to `null` to render the whole texture.
	 */
	public var clipRect:Rectangle;

	/**
	 * The width and height from the first frame
	 * of the currently playing animation.
	 */
	public var size(get, never):Vector2;

	/**
	 * Makes a new `AnimatedSprite`.
	 */
	public function new() {
		super();
		animation = new AnimationPlayer(this);
	}

	/**
	 * Called when this node is ticking/updating internally.
	 * 
	 * Update your own stuff in here if you need to,
	 * just make sure to call `super.tick(delta)` before-hand!
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	override function tick(delta:Float) {
		animation.tick(delta);
	}

	/**
	 * Called when this sprite is drawing internally.
	 * 
	 * Draw your own stuff in here if you need to,
	 * just make sure to call `super.draw()` before-hand!
	 */
	override function draw() {
		if(animation.curAnim == null)
			return;

		final shader:Shader = this.shader ?? RenderingServer.backend.defaultShader;

		@:privateAccess {
			shader.useProgram();
			RenderingServer.backend.quadRenderer.texture = frames.texture.textureData;
		}

		// not the cleanest code ever, but it does the job -cube
		final fram = animation.curAnim.frames[animation.frame];
		final sourceWidth = (clipRect == null) ? fram.size.x : clipRect.width;
		final sourceHeight = (clipRect == null) ? fram.size.y : clipRect.height;
		_clipRectUVCoords.set(
			(fram.position.x + (clipRect?.x ?? 0)) / frames.texture.size.x,
			(fram.position.y + (clipRect?.y ?? 0)) / frames.texture.size.y,
			(fram.position.x + (clipRect?.x ?? 0) + sourceWidth) / frames.texture.size.x,
			(fram.position.y + (clipRect?.y ?? 0) + sourceHeight) / frames.texture.size.y, 
		);

		RenderingServer.backend.quadRenderer.drawFrame(position, fram, frames.texture.size, scale, modulate, _clipRectUVCoords, origin, angle);
	}

	/**
	 * Disposes of this sprite and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			if(frames != null)
				frames.unreference();
			
			_clipRectUVCoords = null;
		}
		super.dispose();
	}

	// -------- //
	// Privates //
	// -------- //
	private var _clipRectUVCoords:Vector4 = new Vector4(0.0, 0.0, 1.0, 1.0);
	
	private static var _trans = new Matrix4x4();
    private static var _vec2 = new Vector2();
    private static var _vec3 = new Vector3();

    private function prepareShaderVars(shader:Shader, fram:AnimationFrame) {
        _trans.reset(1.0);
        
        _vec2.set((_clipRectUVCoords.z - _clipRectUVCoords.x) * frames.texture.size.x, (_clipRectUVCoords.w - _clipRectUVCoords.y) * frames.texture.size.y);
        _trans.scale(_vec3.set(_vec2.x, _vec2.y, 1.0));
        
        if (fram.angle != 0.0) {
			_trans.rotate270Z(); // TODO: work on all angles
            _trans.translate(_vec3.set(0, fram.size.x, 0));
        }
		_trans.scale(_vec3.set(scale.x, scale.y, 1.0));
        
		_vec2.set(fram.marginSize.x * scale.x, fram.marginSize.y * scale.y);
		_trans.translate(_vec3.set(fram.offset.x * scale.x, fram.offset.y * scale.y, 0.0));
        if (angle != 0.0) {
            _trans.translate(_vec3.set(-origin.x * _vec2.x, -origin.y * _vec2.y, 0.0));
            _trans.radRotate(angle, _vec3.set(0, 0, 1)); // preventing memory from exploding
            _trans.translate(_vec3.set(origin.x * _vec2.x, origin.y * _vec2.y, 0.0));
        }
		
        _trans.translate(_vec3.set(position.x, position.y, 0.0));
        _trans.translate(_vec3.set(-origin.x * _vec2.x, -origin.y * _vec2.y, 0.0));

        shader.setUniformMat4x4("TRANSFORM", _trans);
        shader.setUniformColor("MODULATE", modulate);
        shader.setUniformVec4("SOURCE", _clipRectUVCoords);
    }

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function get_size():Vector2 {
		if(animation.curAnim != null)
			return animation.curAnim.frames[0].size;

		return Vector2.ZERO;
	}

	@:noCompletion
	private inline function set_frames(newFrames:SpriteFrames):SpriteFrames {
		if(frames != null)
			frames.unreference();

		if(newFrames != null)
			newFrames.reference();

		frames = newFrames;
		return newFrames;
	}
}
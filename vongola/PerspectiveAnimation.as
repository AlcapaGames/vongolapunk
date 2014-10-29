package vongola {
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.PerspectiveSpritemap;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Stefano Musumeci
	 */
	public class PerspectiveAnimation {
		private var leftAnim : Anim;
		private var rightAnim : Anim;
		private var upAnim : Anim;
		private var downAnim : Anim;
		private var spriteMap : PerspectiveSpritemap;
		
		private var hasObliqueAnim : Boolean = false;
		private var animName : String;
		
		private var upHorizontalAnim : Anim = null;
		private var downHorizontalAnim : Anim = null;
		
		public function PerspectiveAnimation(spriteMap : PerspectiveSpritemap, animName : String, frameRate : Number, loops : Boolean, downFrames : Array, upFrames : Array, rightAnim : Array, leftAnim : Array = null) {
			this.rightAnim = spriteMap.add(animName + "r", rightAnim, frameRate, loops);
			if (leftAnim != null)
				this.leftAnim = spriteMap.add(animName + "l", leftAnim, frameRate, loops);
			upAnim = spriteMap.add(animName + "u", upFrames, frameRate, loops);
			downAnim = spriteMap.add(animName + "d", downFrames, frameRate, loops);
			this.animName = animName;
			this.spriteMap = spriteMap;
		}
		
		public function addObliqueAnimations(upHorizontal : Array, downHorizontal : Array) : void
		{
			hasObliqueAnim = true;
			upHorizontalAnim = spriteMap.add( animName + "us", upHorizontal, upAnim.frameRate, upAnim.loop);
			downHorizontalAnim = spriteMap.add( animName + "ds", downHorizontal, upAnim.frameRate, upAnim.loop);
		}
		
		public static function CreateSimplePerspectiveAnimation(spriteMap : PerspectiveSpritemap, animName : String, frames : Array, frameRate : Number, loops : Boolean = true) : PerspectiveAnimation
		{
			return new PerspectiveAnimation(spriteMap, animName, frameRate, loops, frames, frames, frames, null);
		}
		
		public function getAnimation() : Anim 
		{
			var dir : int = spriteMap.Direction;
			if ( hasObliqueAnim )
			{
				if ( (dir & AnimationDirection.Up) != 0 )
				{
					if ( dir == AnimationDirection.Up )
						return upAnim;
					else
						return upHorizontalAnim;
				}
				else if ( (dir & AnimationDirection.Down) != 0 )
				{
					if ( dir == AnimationDirection.Down )
						return downAnim;
					else
						return downHorizontalAnim;
				}
				else if ( dir & AnimationDirection.Right )
				{
					return rightAnim;
				}
				else if ( dir & AnimationDirection.Left )
				{
					if ( leftAnim == null )
						return rightAnim;
					else 
						return leftAnim;
				}
			}
			else
			{
				if (dir == AnimationDirection.Up)
				{
					return upAnim;
				}
				else if (dir == AnimationDirection.Down) 
				{
					return downAnim;
				} 
				else if ( dir == AnimationDirection.Right )
				{
					return rightAnim;
				}
				else if ( leftAnim == null )
					return rightAnim;
				else 
					return leftAnim;
			}
			return null;
		}
		
		public function hasFinished() : Boolean
		{
			var playingAnim : Anim = getAnimation();
			return spriteMap.frame == playingAnim.frames[playingAnim.frames.length - 1];
		}
		
		public function setFrame(frameTarget : int) : void 
		{
			var dir : int = spriteMap.Direction;
			var playingAnim : Anim = getAnimation();
			spriteMap.frame = playingAnim.frames[frameTarget];
			if( dir & AnimationDirection.Right && leftAnim == null )
				spriteMap.flipped = (dir & AnimationDirection.Right) != 0;
			else
				spriteMap.flipped = false;
		}
		
		public function playAnimation(reset : Boolean = false, frameTarget : int = -1) : void 
		{
			var dir : int = spriteMap.Direction;
			
			if (spriteMap.currentAnim.substr(0, animName.length) == animName && reset == false)
				return;
			
			var playingAnim : Anim = getAnimation();
			playingAnim.play(reset);
				
			if (frameTarget != -1)
				spriteMap.play(playingAnim.name, true, frameTarget);
			
			if( dir & AnimationDirection.Right && leftAnim == null )
				spriteMap.flipped = (dir & AnimationDirection.Right) != 0;
			else
				spriteMap.flipped = false;
			
			spriteMap.currentAnimation = this;
		}
	
	}

}
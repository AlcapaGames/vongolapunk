package net.flashpunk.graphics 
{
	import vongola.PerspectiveAnimation;
	/**
	 * ...
	 * @author Stefano Musumeci
	 */
	public class PerspectiveSpritemap extends Spritemap
	{
		private var direction : int = 0;
		
		public function get Direction() : int
		{
			return direction;
		}
		
		public function set Direction( val : int) : void
		{
			if ( direction != val )
			{
				this.direction = val;
				if ( currentAnimation != null )
				{
					currentAnimation.playAnimation(true);
				}
			}
		}
		
		public var currentAnimation : PerspectiveAnimation;
		
		public function PerspectiveSpritemap(source : *, frameWidth : uint = 0, frameHeight : uint = 0, callback : Function = null) 
		{
			super(source, frameWidth, frameHeight, callback);
		}
		
	}

}
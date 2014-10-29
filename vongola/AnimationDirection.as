package vongola
{
	/**
	 * ...
	 * @author Stefano Musumeci
	 */
	public class AnimationDirection 
	{
		
		public static const Up : int = 1 << 0;
		public static const Right : int = 1 << 1;
		public static const Left : int = 1 << 2;
		public static const Down : int = 1 << 3;
		
		public static function Opposite( dir : int ) : int
		{
			switch(dir)
			{
				case AnimationDirection.Right:
					return AnimationDirection.Left;
				case AnimationDirection.Up:
					return AnimationDirection.Down;
				case AnimationDirection.Left:
					return AnimationDirection.Right;
				case AnimationDirection.Down:
					return AnimationDirection.Up;
			}
			return 0;
		}
		
	}

}
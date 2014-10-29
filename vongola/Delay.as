package vongola 
{
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author ...
	 */
	public class Delay 
	{
		private var duration : Number;
		private var timer : Number;
		
		public function Delay(duration : Number) 
		{
			this.duration = duration;
			this.timer = 0;
		}
		
		public function update() : void
		{
			if (timer < duration)
				timer += FP.elapsed;
			else
				timer = duration;
		}
		
		public function setDuration( duration : Number ) : void
		{
			this.duration = duration;
		}
		
		public function start(duration : Number = -1) : void
		{
			if (duration != -1)
			{
				this.duration = duration;
			}
			timer = 0;
		}
		
		public function hasPassed() : Boolean
		{
			return timer >= duration;
		}
		
		public function reset() : void
		{
			this.timer = 0;
		}
		
		public function force() : void
		{
			this.timer = duration;
		}
		
		public function get Duration() : Number
		{
			return duration;
		}
		
		public function get Elapsed() : Number
		{
			return timer;
		}
		
		public function get progress() : Number
		{
			return FP.clamp(timer / duration, 0, 1.0);
		}
		
		public function get inverseProgress() : Number
		{
			return 1 - FP.clamp(timer / duration, 0, 1.0);
		}
		
	}

}
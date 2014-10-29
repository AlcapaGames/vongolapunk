package vongola 
{
	import adobe.utils.CustomActions;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author ...
	 */
	public class IndicatorBar extends Entity
	{
		private var fullBar : Image;
		private var currentProgress : Number = 0.0;
		private var targetProgress : Number = 0.0;
		private var previousProgress : Number = 0.0;
		
		private var differenceTimer : Number = 0;
		private var differenceTime : Number = 0;
		
		public var isHorizontal : Boolean = true;
		
		public var fillSpeed : Number = 2.5;
		
		public function IndicatorBar(x : int, y : int, emptyBar : Class, fullBar : Class) 
		{
			super(x, y, null, null);
			var img : Graphic = addGraphic(new Image(emptyBar));
			img.scrollX = img.scrollY = 0;
			this.fullBar = addGraphic(new Image(fullBar)) as Image;
			this.fullBar.scrollX = this.fullBar.scrollY = 0;
			this.fullBar.drawMask = new BitmapData(this.fullBar.width, this.fullBar.height, true, 0);
			
			layer = -int.MAX_VALUE + 6;
		}
		
		public function set Progress( progress : Number ) : void
		{
			progress = FP.clamp(progress, 0, 1);
			if (progress != targetProgress)
			{
				currentProgress = targetProgress;
				targetProgress = progress;
				differenceTime = Math.abs(currentProgress - targetProgress) * fillSpeed;
				differenceTimer = 0;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if ( currentProgress != targetProgress )
			{
				differenceTimer += FP.elapsed;
				if ( differenceTimer >= differenceTime )
				{
					differenceTimer = differenceTime;
					currentProgress = targetProgress;
					differenceTimer = 0;
				}
				var t : Number = differenceTimer / differenceTime;
				var diffVal : Number = (targetProgress - currentProgress) * t;
				
				if ( isHorizontal )
				{
					if ( targetProgress >= currentProgress )
					{
						fullBar.drawMask.lock();
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height), 0);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width * targetProgress, fullBar.height), 0xAAAAAAAA);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width * (currentProgress + diffVal), fullBar.height), 0xFFFFFFFF);
						fullBar.drawMask.unlock();
						fullBar.updateBuffer();
					}
					else
					{
						fullBar.drawMask.lock();
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height), 0);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width * (currentProgress + diffVal), fullBar.height), 0xAAAAAAAA);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width * targetProgress, fullBar.height), 0xFFFFFFFF);
						fullBar.drawMask.unlock();
						fullBar.updateBuffer();
					}
				}
				else
				{
					if ( targetProgress >= currentProgress )
					{
						fullBar.drawMask.lock();
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height), 0);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height * targetProgress), 0xAAAAAAAA);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height * (currentProgress + diffVal)), 0xFFFFFFFF);
						fullBar.drawMask.unlock();
						fullBar.updateBuffer();
					}
					else
					{
						fullBar.drawMask.lock();
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height), 0);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height * (currentProgress + diffVal)), 0xAAAAAAAA);
						fullBar.drawMask.fillRect(new Rectangle(0, 0, fullBar.width, fullBar.height * targetProgress), 0xFFFFFFFF);
						fullBar.drawMask.unlock();
						fullBar.updateBuffer();
					}
				}

			}
		}
		
	}

}
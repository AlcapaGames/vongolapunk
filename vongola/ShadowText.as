package vongola 
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Stefano Musumeci
	 */
	public class ShadowText extends Text
	{
		public var shadowColor : int = 0x433327;
		
		public function ShadowText(text : String, x : Number = 0, y : Number = 0, options : Object = null, h : Number = 0) 
		{
			super(text, x, y, options, h);
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void 
		{
			var prevColor : int = color;
			color = shadowColor;
			super.render(target, point.add(new Point(1, 0)), camera);
			super.render(target, point.add(new Point(0, 1)), camera);
			super.render(target, point.add(new Point(1, 1)), camera);
			color = prevColor;
			super.render(target, point, camera);
		}
		
	}

}
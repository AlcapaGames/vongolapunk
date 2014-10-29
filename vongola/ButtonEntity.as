package vongola {
	import flash.ui.MouseCursor;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Stefano Musumeci
	 */
	public class ButtonEntity extends Entity {
		
		private var pressedCallback : Function;
		public var buttonActive : Boolean = true;
		
		private var wasActive : Boolean = false;
		
		public function ButtonEntity(x : int, y : int, image : Class, pressedCallback : Function) {
			super(x, y, new Image(image));
			graphic.scrollX = graphic.scrollY = 0;
			this.pressedCallback = pressedCallback;
		}
		
		override public function update() : void {
			super.update();
			if (buttonActive) {
				var currentImage : Image = graphic as Image;
				setHitbox(currentImage.scaledWidth, currentImage.scaledHeight);
				if (this.collidePoint(x, y, Input.mouseX, Input.mouseY)) {
					Input.mouseCursor = MouseCursor.BUTTON;
					wasActive = true;
					if (Input.mousePressed) {
						Input.mouseCursor = MouseCursor.ARROW;
						if (pressedCallback != null)
							pressedCallback();
					}
				} else if(wasActive) {
					Input.mouseCursor = MouseCursor.ARROW;
					wasActive = false;
				}
			}
		}
	
	}

}
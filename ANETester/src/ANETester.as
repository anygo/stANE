package
{
	import com.stintern.ane.ANEExtension;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class ANETester extends Sprite
	{
		private var _aneExtension:ANEExtension;
		
		public function ANETester()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_aneExtension = new ANEExtension();
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK )
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				
				_aneExtension.showEndDlg();
			}
		}
	}
}
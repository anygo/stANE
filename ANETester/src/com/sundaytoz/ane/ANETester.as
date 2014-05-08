package com.sundaytoz.ane
{
	import com.sundaytoz.ane.events.ImageResultEvent;
	import com.sundaytoz.ane.events.VolumeEvent;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	public class ANETester extends Sprite
	{
		private var _deviceExtension:DeviceExtension;
		
		public function ANETester()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_deviceExtension = new DeviceExtension();
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
			
			// 디바이스 정보를 알아옴
			var deviceInfo:Array = _deviceExtension.getDeviceInfo();
			
			var deviceInfoText:TextField = new TextField();
			deviceInfoText.width = 400;
			deviceInfoText.height = 200;
			deviceInfoText.htmlText = "<p><b> Phone No : </b>" + deviceInfo[0] + "</br><b> Model : </b>" + deviceInfo[1] + "</p>";
			
			addChild(deviceInfoText);
			
			_deviceExtension.getImageFromAlbum();
			
			_deviceExtension.addEventListener(ImageResultEvent.IMAGE_SELECTED, onImageSelected);
			
//			VolumeController.instance.setVolume(3);
//			trace(VolumeController.instance.systemVolume);
//			
//			VolumeController.instance.addEventListener(VolumeEvent.VOLUME_CHANGED, onVolumeChanged);
		}
		
		private function onInvoke(event:InvokeEvent):void
		{
			trace(event.arguments.length);
			//trace(event.arguments);		
		}
		
		private function onImageSelected(event:ImageResultEvent):void
		{
			trace(event.imageString);
		}
		
		private function onVolumeChanged(event:VolumeEvent):void
		{
			trace(event.toString());
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK )
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				
				_deviceExtension.showEndDlg();
			}
		}
	}
}
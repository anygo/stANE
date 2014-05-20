package com.stintern.anetest.layer
{
	import com.stintern.anetest.utils.DeviceInfo;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DeviceInfoLayer extends Sprite
	{
		private var _deviceInfo:DeviceInfo;
		private var _deviceInfoText:TextField;
		
		private static const FONT_SIZE:int= 32;
		
		private static const TEXT_INITIAL_X:Number = 0.1;
		private static const TEXT_INITIAL_Y:Number = 0.9;
		
		public function DeviceInfoLayer()
		{
			_deviceInfo = new DeviceInfo();
			_deviceInfoText = new TextField();
		}
		
		public function showDeviceInfo():void
		{
			_deviceInfoText.x = stage.fullScreenWidth * TEXT_INITIAL_X;
			_deviceInfoText.y = stage.fullScreenHeight * TEXT_INITIAL_Y;
						
			_deviceInfoText.width = stage.fullScreenWidth;
			_deviceInfoText.height = FONT_SIZE + 10;
			
			_deviceInfoText.text = "Phone No : " + _deviceInfo.phoneNo + ", Model : " + _deviceInfo.modelName;
			addChild(_deviceInfoText);
			
			var format:TextFormat = new TextFormat();
			format.size = FONT_SIZE;
			
			_deviceInfoText.setTextFormat(format);
		}
	}
}
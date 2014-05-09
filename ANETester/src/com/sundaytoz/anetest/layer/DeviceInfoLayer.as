package com.sundaytoz.anetest.layer
{
	import com.sundaytoz.anetest.utils.DeviceInfo;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DeviceInfoLayer extends Sprite
	{
		private var _deviceInfo:DeviceInfo;
		private var _deviceInfoText:TextField;
		
		private static const FONT_SIZE:int= 32;
		
		public function DeviceInfoLayer()
		{
			_deviceInfo = new DeviceInfo();
			
			_deviceInfoText = new TextField();
		}
		
		public function showDeviceInfo():void
		{
			_deviceInfoText.x = stage.fullScreenWidth * 0.1;
			_deviceInfoText.y = stage.fullScreenHeight * 0.9;
						
			_deviceInfoText.width = stage.fullScreenWidth;
			_deviceInfoText.height = 200;
			
			_deviceInfoText.text = "Phone No : " + _deviceInfo.phoneNo + ", Model : " + _deviceInfo.modelName;
			addChild(_deviceInfoText);
			
			var format:TextFormat = new TextFormat();
			format.size = FONT_SIZE;
			
			_deviceInfoText.setTextFormat(format);
		}
	}
}
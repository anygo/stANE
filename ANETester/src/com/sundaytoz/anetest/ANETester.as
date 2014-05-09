package com.sundaytoz.anetest  
{
	import com.dynamicflash.util.Base64;
	import com.sundaytoz.anemaker.AndroidExtension;
	import com.sundaytoz.anemaker.events.ImageResultEvent;
	import com.sundaytoz.anetest.layer.DeviceInfoLayer;
	import com.sundaytoz.anetest.layer.ImageLayer;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	
	public class ANETester extends Sprite
	{
		private var _deviceExtension:AndroidExtension;
		private var _bmp:Bitmap;
		
		public function ANETester()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// Back Button 컨트롤을 위해 KEY_DOWN 이벤트 리스너 설정
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			
			// Image 레이어를 출력
			var imageLayer:ImageLayer = new ImageLayer();
			addChild(imageLayer);
			
			// 디바이스 정보 레이어를 출력
			var deviceInfoLayer:DeviceInfoLayer = new DeviceInfoLayer();
			addChild(deviceInfoLayer);
			
			deviceInfoLayer.showDeviceInfo();
		}
						
		/**
		 * KEY_DOWN 이벤트를 받으면 불려지는 함수입니다.
		 * Back Button 이 눌려졌을 경우 ANE 를 통해 종료를 하는 Alert Dialog 를 띄웁니다. 
		 * @param event Keyboard 이벤트
		 */
		private function onKeyDown(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK )
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				
				var deviceExtension:AndroidExtension = new AndroidExtension();
				deviceExtension.showEndDlg();
			}
		}
	}
}
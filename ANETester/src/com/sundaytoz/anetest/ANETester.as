package com.sundaytoz.anetest  
{
	import com.dynamicflash.util.Base64;
	import com.sundaytoz.anemaker.AndroidExtension;
	import com.sundaytoz.anemaker.events.ImageResultEvent;
	
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
	import flash.text.TextField;
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
			
			_deviceExtension = new AndroidExtension();
			
			// 디바이스 정보를 알아옴
			var deviceInfo:Array = _deviceExtension.getDeviceInfo();
			
			// 디바이스 정보를 출력
			var deviceInfoText:TextField = new TextField();
			deviceInfoText.width = 400;
			deviceInfoText.height = 200;
			deviceInfoText.htmlText = "<p><b> Phone No : </b>" + deviceInfo[0] + "</br><b> Model : </b>" + deviceInfo[1] + "</p>";
			
			addChild(deviceInfoText);
			
			// 앨범에서 사진 하나를 선택해서 출력
			_deviceExtension.getImageFromAlbum();
			
			// 이미지가 선택되면 불려지는 리스너 설정
			_deviceExtension.addEventListener(ImageResultEvent.IMAGE_SELECTED, onImageSelected);
			
			// Back Button 컨트롤을 위해 KEY_DOWN 이벤트 리스너 설정
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
		}
		
		/**
		 * 앨범에서 사진을 선택하면 사진 Bitmap byte array 를 스트링 값으로 받습니다. 
		 * @param event Bitmap Byte Array 가 들어있는 Custom Event 
		 */
		private function onImageSelected(event:ImageResultEvent):void
		{
			var decodedArray:ByteArray = Base64.decodeToByteArray(event.imageString);
					
			var loader:Loader = new Loader();
			loader.loadBytes(decodedArray);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		
		/**
		 * 이미지 byte array 를 읽은 후 불려지는 함수입니다. 
		 */
		private function onComplete(event:Event):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(event.target);
			var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, false, 0xFFFFFF);
			bitmapData.draw(loaderInfo.loader);
			_bmp = new Bitmap(bitmapData);
			
			addChild(_bmp);
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
				
				_deviceExtension.showEndDlg();
			}
		}
	}
}
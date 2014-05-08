package  
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
	import flash.events.InvokeEvent;
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
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
			
			// 디바이스 정보를 알아옴
			var deviceInfo:Array = _deviceExtension.getDeviceInfo();
			
			var deviceInfoText:TextField = new TextField();
			deviceInfoText.width = 400;
			deviceInfoText.height = 200;
			deviceInfoText.htmlText = "<p><b> Phone No : </b>" + deviceInfo[0] + "</br><b> Model : </b>" + deviceInfo[1] + "</p>";
			
			addChild(deviceInfoText);
			
			_deviceExtension.getImageFromAlbum();
			
			_deviceExtension.addEventListener(ImageResultEvent.IMAGE_SELECTED, onImageSelected);
		}
		
		private function onImageSelected(event:ImageResultEvent):void
		{
			trace(event.imageString);

			var byteArr:ByteArray = new ByteArray();
			byteArr.writeUTFBytes(event.imageString);
			
			var decodedArray:ByteArray = Base64.decodeToByteArray(event.imageString);
					
			var loader:Loader = new Loader();
			loader.loadBytes(byteArr);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(event:Event):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(event.target);
			var bitmapData:BitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, false, 0xFFFFFF);
			bitmapData.draw(loaderInfo.loader);
			_bmp = new Bitmap(bitmapData);
			
			addChild(_bmp);
			
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
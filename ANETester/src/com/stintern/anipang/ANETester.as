package com.stintern.anipang
{
	import com.dynamicflash.util.Base64;
	import com.stintern.ane.ANEExtension;
	import com.stintern.ane.events.ImageResultEvent;
	
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
        private var _image:Bitmap;
        private var _fbANE:ANEExtension;
		
		public function ANETester()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
            _image = new Bitmap();
            _fbANE = new ANEExtension();
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK )
			{
                
				event.preventDefault();
				event.stopImmediatePropagation();
				
                //_fbANE.addEventListener(ImageResultEvent.EVENT_USER_IMAGE, onLoadUserImage);
                _fbANE.getUserInfo();
                
			}
		}
        
        private function onLoadUserImage(event:ImageResultEvent):void
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
            
            // 다른 이미지가 있을 경우 삭제
            if( _image.bitmapData != null )
            {
                _image.bitmapData.dispose();
            }
            
            _image.bitmapData = bitmapData;
            
            _image.x = stage.fullScreenWidth * 0.5 - _image.width * 0.5;
            _image.y = stage.fullScreenHeight * 0.2;
        }

	}
}
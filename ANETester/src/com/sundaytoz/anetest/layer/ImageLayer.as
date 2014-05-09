package com.sundaytoz.anetest.layer
{
	import com.dynamicflash.util.Base64;
	import com.sundaytoz.anemaker.events.ImageResultEvent;
	import com.sundaytoz.anetest.utils.ImagePicker;
	import com.sundaytoz.anetest.utils.Resources;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	public class ImageLayer extends Sprite
	{
		private var _image:Bitmap;
		private var _imagePicker:ImagePicker = null;
		
		private var _cameraButton:Sprite;
		private var _imageChangeButton:Sprite;
		
		public function ImageLayer()
		{
			init();
		}
		
		/**
		 * ImageLayer 에 필요한 이미지 및 버튼을 초기화합니다.
		 */
		private function init():void
		{
			// 사용자가 선택한 이미지가 출력될 Bitmap 초기화
			loadImage(Resources.IMG_INITIAL_PICTURE, initInitialImage);
			
			// 카메라 버튼을 초기화
			initCameraButton();
			
			// 사진 변경 버튼을 초기화
			initChangeButton();	
		}
		
		/**
		 * 카메라 버튼을 초기화합니다.
		 */
		private function initCameraButton():void
		{
			_cameraButton = new Sprite();
			_cameraButton.addEventListener(MouseEvent.MOUSE_UP, onClickCameraButton);
			addChild(_cameraButton);
			
			// 버튼에 이미지를 출력
			loadImage(Resources.IMG_CAMERA, initCameraButtonImage);	
		}
		
		/**
		 * 사진 변경 버튼을 초기화합니다.
		 */
		private function initChangeButton():void
		{
			// 이미지 변경 버튼 생성
			_imageChangeButton = new Sprite();
			_imageChangeButton.addEventListener(MouseEvent.MOUSE_UP, onClickChangeImage);
			addChild(_imageChangeButton);
			
			// 버튼에 이미지를 출력
			loadImage(Resources.IMG_CHANGE_PICTURE, initChangeButtonImage);		
		}
		
		/**
		 * 카메라 버튼이 눌려졌을 경우 ANE 를 통해 사진을 찍습니다.
		 */
		private function onClickCameraButton(event:MouseEvent):void
		{
			if( _imagePicker == null )
			{
				_imagePicker = new ImagePicker();
			}
			
			_imagePicker.takeNewPicture(onChangedImage);
		}
		
		/**
		 * 이미지를 변경하기위해 버튼을 ANE을 통해 앨범에서 사진을 불러옵니다.
		 */
		private function onClickChangeImage(event:MouseEvent):void
		{
			if( _imagePicker == null )
			{
				_imagePicker = new ImagePicker();
			}
			
			_imagePicker.showAlbum(onChangedImage);
		}
		
		/**
		 * 앨범에서 사진을 선택하면 사진 Bitmap byte array 를 스트링 값으로 받습니다. 
		 * @param event Bitmap Byte Array 가 들어있는 Custom Event 
		 */
		public function onChangedImage(event:ImageResultEvent):void
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
		
		/**
		 * 이미지를 읽어옵니다. 
		 * @param path 읽어올 이미지의 경로
		 * @param listener 읽은 후 불려질 리스너
		 * 
		 */
		private function loadImage(path:String, listener:Function):void
		{
			// 이미지 로더 생성
			var loader:Loader = new Loader();
			var urlRequest:URLRequest = new URLRequest(path);
			loader.load(urlRequest);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, listener);
			urlRequest = null;
		}
		
		/**
		 * 카메라 버튼을 초기화합니다.
		 * @param event bmpData 정보가 들어있는 event 객체 
		 */
		private function initCameraButtonImage(event:Event):void
		{
			var bmp:Bitmap = new Bitmap( Bitmap(LoaderInfo(event.target).content).bitmapData );
			
			bmp.x = stage.fullScreenWidth * 0.4 - bmp.width * 0.5;
			bmp.y = stage.fullScreenHeight * 0.5;
			
			_cameraButton.addChild(bmp);
		}
		
		/**
		 * 이미지 변경 버튼을 초기화합니다.
		 * @param event bmpData 정보가 들어있는 event 객체 
		 */
		private function initChangeButtonImage(event:Event):void
		{
			var bmp:Bitmap = new Bitmap( Bitmap(LoaderInfo(event.target).content).bitmapData );
			
			bmp.x = stage.fullScreenWidth * 0.6 - bmp.width * 0.5;
			bmp.y = stage.fullScreenHeight * 0.5;
		
			_imageChangeButton.addChild(bmp);
		}
		
		/**
		 * 앨범에서 아직 사진을 선택한 게 없을 때 출력하는 이미지를 설정합니다.
		 */
		private function initInitialImage(event:Event):void
		{			
			_image = new Bitmap(Bitmap(LoaderInfo(event.target).content).bitmapData);
			
			_image.x = stage.fullScreenWidth * 0.5 - _image.width * 0.5;
			_image.y = stage.fullScreenHeight * 0.2;
			
			addChild(_image);
		}
		
		/**
		 * 사용한 자원을 해제합니다.
		 */
		public function clean():void
		{
			_imagePicker = null;
			
			_image.bitmapData.dispose();
			_image = null;
			
			_cameraButton.removeEventListener(MouseEvent.MOUSE_UP, onClickCameraButton);
			_imageChangeButton.removeEventListener(MouseEvent.MOUSE_UP, onClickChangeImage);
		}
	}
}
package com.sundaytoz.anetest.utils
{
	import com.sundaytoz.anemaker.AndroidExtension;
	import com.sundaytoz.anemaker.events.ImageResultEvent;
	
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;

	public class ImagePicker extends EventDispatcher
	{
		private var _bmp:Bitmap;
		private var _extension:AndroidExtension;
		
		public function ImagePicker()
		{
			_extension = new AndroidExtension();
		}
		
		public function takeNewPicture(listener:Function):void
		{
			_extension.addEventListener(ImageResultEvent.IMAGE_SELECTED, listener);
			
			_extension.takePicture();
		}
		
		public function showAlbum(listener:Function):void
		{			
			// 이미지가 선택되면 불려지는 리스너 설정
			_extension.addEventListener(ImageResultEvent.IMAGE_SELECTED, listener);
			
			// 앨범에서 사진 하나를 선택해서 출력
			_extension.getImageFromAlbum();
		}
		
		/**
		 * 사용한 자원을 해제합니다.
		 */
		public function clean():void
		{
			_extension = null;
			_bmp.bitmapData.dispose();
		}
	}
}
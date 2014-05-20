package com.stintern.anetest.utils
{
	import com.sundaytoz.anemaker.AndroidExtension;
	import com.sundaytoz.anemaker.events.ImageResultEvent;
	
	import flash.events.EventDispatcher;

	public class ImagePicker extends EventDispatcher
	{
		private var _extension:AndroidExtension;
		
		public function ImagePicker()
		{
			_extension = new AndroidExtension();
		}
		
		/**
		 * 새로운 사진을 찍습니다. 
		 * @param listener 찍은 사진 정보가 전달될 리스너
		 */
		public function takeNewPicture(listener:Function):void
		{
			// 사진을 찍으면 불려지는 리스너 설정
			_extension.addEventListener(ImageResultEvent.IMAGE_SELECTED, listener);
			
			// ANE 를 통해서 사진을 찍음
			_extension.takePicture();
		}
		
		/**
		 * 앨범에서 사진을 선택합니다. 
		 * @param listener 선택한 사진정보가 전달될 리스너
		 */
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
		}
	}
}
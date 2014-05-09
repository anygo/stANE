package com.sundaytoz.anemaker.events{	import flash.events.Event;
	/**	 * Native 단에서 이미지 관련 작업을 끝내고 받은 Image 의 byte array 스트링을 	 * 담은 이벤트를 만들어서 리스너에게 보냅니다.	 */
	public class ImageResultEvent extends Event
	{
		public static const IMAGE_SELECTED:String = "imageSelected";	
		private var _imageString:String;
	
		public function ImageResultEvent( type:String, imageString:String, bubbles:Boolean=false, cancelable:Boolean=false )		{
			_imageString = imageString;
			super(type, bubbles, cancelable);
		}				public function get imageString():String		{			return _imageString;			}
	}
}
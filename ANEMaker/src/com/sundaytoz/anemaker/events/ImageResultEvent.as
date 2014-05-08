

	public class ImageResultEvent extends Event
	{
		public static const IMAGE_SELECTED:String = "imageSelected";	
		private var _imageString:String;
	
		public function ImageResultEvent( type:String, result:String, bubbles:Boolean=false, cancelable:Boolean=false ) {
			_imageString = result;
			
			super(type, bubbles, cancelable);
		}
	}
}
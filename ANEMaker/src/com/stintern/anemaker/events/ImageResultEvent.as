

	public class ImageResultEvent extends Event
	{
		public static const IMAGE_SELECTED:String = "imageSelected";	
		private var _imageString:String;
	
		public function ImageResultEvent( type:String, imageString:String, bubbles:Boolean=false, cancelable:Boolean=false )
			_imageString = imageString;
			super(type, bubbles, cancelable);
		}
	}
}
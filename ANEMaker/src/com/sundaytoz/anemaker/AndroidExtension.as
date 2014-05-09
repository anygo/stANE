package com.sundaytoz.anemaker
{
	import com.sundaytoz.anemaker.events.ImageResultEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class AndroidExtension extends EventDispatcher
	{
		private var _context:ExtensionContext;
		
		public function AndroidExtension()
		{
			try
			{
				_context = ExtensionContext.createExtensionContext("com.sundaytoz.ane.ANEMaker", null);
				_context.addEventListener(StatusEvent.STATUS, onStatus);
			}
			catch(e:Error)
			{
				trace(e.message);
			}
		}
		
		private function onStatus( event:StatusEvent ):void {
			if(event.code == "imageSelected")
			{
				dispatchEvent( new ImageResultEvent( ImageResultEvent.IMAGE_SELECTED, event.level, false, false ) );
			}
		}
		
		
		/**
		 * 종료 AlertDialg 를 띄웁니다. 
		 */
		public function showEndDlg():void
		{
			_context.call("showEndDlg");
		}
		
		/**
		 * 사용자의 휴대폰 디바이스 정보(전화번호, 모델명)을 받아옵니다.
		 * @return 정보가 포함된 Array
		 */
		public function getDeviceInfo():Array
		{
			return _context.call("showDeviceInfo") as Array;
		}
		
		
		/**
		 * 사용자의 휴대폰 앨범에서 사진을 선택하면 해당 사진을 불러옵니다. 
		 * 불러온 이미지정보는 ImageResultEvent.IMAGE_SELECTED 이벤트를 통해서 전달됩니다.
		 */
		public function getImageFromAlbum():void
		{
			_context.call("getImageFromAlbum");
		}
	}
}

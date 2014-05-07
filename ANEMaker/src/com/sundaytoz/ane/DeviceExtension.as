package com.sundaytoz.ane
{
	import flash.external.ExtensionContext;

	public class DeviceExtension
	{
		private var _context:ExtensionContext;
		
		public function DeviceExtension()
		{
			try
			{
				_context = ExtensionContext.createExtensionContext("com.sundaytoz.ane.ANEMaker", null);
			}
			catch(e:Error)
			{
				trace(e.message);
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
	}
}

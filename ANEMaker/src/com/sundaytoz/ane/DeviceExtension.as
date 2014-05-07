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
		
		public function showEndDlg():void
		{
			_context.call("showEndDlg");
		}
	}
}
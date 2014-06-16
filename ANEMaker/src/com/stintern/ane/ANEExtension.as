package com.stintern.ane
{
	import flash.external.ExtensionContext;

	public class ANEExtension
	{
		private var _context:ExtensionContext;
		
		public function ANEExtension()
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
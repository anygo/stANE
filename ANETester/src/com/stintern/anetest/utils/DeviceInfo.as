package com.stintern.anetest.utils
{
	import com.sundaytoz.anemaker.AndroidExtension;

	public class DeviceInfo
	{
		private var _phoneNo:String;
		private var _modelName:String;
		
		private var _deviceInfoExt:AndroidExtension;
		
		public function DeviceInfo()
		{
			_deviceInfoExt = new AndroidExtension();
			
			// 디바이스 정보를 알아옴
			var deviceInfo:Array = _deviceInfoExt.getDeviceInfo();
			_phoneNo = deviceInfo[0];
			_modelName = deviceInfo[1];
		}
		
		public function get phoneNo():String
		{
			return _phoneNo;
		}
		public function get modelName():String
		{
			return _modelName;
		}
		
	}
}
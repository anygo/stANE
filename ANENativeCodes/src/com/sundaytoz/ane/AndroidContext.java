package com.sundaytoz.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.sundaytoz.zne.functions.BackButtonFunction;
import com.sundaytoz.zne.functions.DeviceInfoFunction;
import com.sundaytoz.zne.functions.GetImageFunction;

public class AndroidContext extends FREContext {

	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {

        Map<String, FREFunction> map = new HashMap<String, FREFunction>();
        
        map.put("showEndDlg", new BackButtonFunction());
        map.put("showDeviceInfo", new DeviceInfoFunction());
        map.put("getImageFromAlbum", new GetImageFunction());
        
		return map;
	}

}

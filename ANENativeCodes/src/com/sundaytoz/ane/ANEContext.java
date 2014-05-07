package com.sundaytoz.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

import functions.BackButtonFunction;
import functions.DeviceInfoFunction;

public class ANEContext extends FREContext {

	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {

        Map<String, FREFunction> map = new HashMap<String, FREFunction>();
        
        map.put("showEndDlg", new BackButtonFunction());
        map.put("showDeviceInfo", new DeviceInfoFunction());
        
		return map;
	}

}

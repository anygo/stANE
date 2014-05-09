package com.sundaytoz.ane;

import java.util.HashMap;
import java.util.Map;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.sundaytoz.ane.functions.BackButtonFunction;
import com.sundaytoz.ane.functions.DeviceInfoFunction;
import com.sundaytoz.ane.functions.GetImageFunction;

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
	
	public void getImageFromAlbum()
	{
        dispatchStatusEventAsync("debugging", "getImageFromAlbum()");

		Intent intent = new Intent(getActivity().getApplicationContext(), ImagePickerActivity.class);
		getActivity().startActivity(intent);
	}

}

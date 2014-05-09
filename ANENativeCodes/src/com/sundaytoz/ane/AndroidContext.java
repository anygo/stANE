package com.sundaytoz.ane;

import java.util.HashMap;
import java.util.Map;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.sundaytoz.ane.functions.BackButtonFunction;
import com.sundaytoz.ane.functions.DeviceInfoFunction;
import com.sundaytoz.ane.functions.GetImageFunction;
import com.sundaytoz.ane.functions.TakePictureFunction;

public class AndroidContext extends FREContext 
{

	public static final String METHOD_TYPE = "METHOD_TYPE";
	
	public static final int GET_IMAGE = 0;
	public static final int NEW_IMAGE = 1;
	
	@Override
	public void dispose() 
	{

	}

	@Override
	public Map<String, FREFunction> getFunctions() 
	{

        Map<String, FREFunction> map = new HashMap<String, FREFunction>();
        
        map.put("showEndDlg", new BackButtonFunction());
        map.put("showDeviceInfo", new DeviceInfoFunction());
        map.put("getImageFromAlbum", new GetImageFunction());
        map.put("takePicture", new TakePictureFunction());
        
		return map;
	}
	
	public void getImageFromAlbum()
	{
		Intent intent = new Intent(getActivity().getApplicationContext(), ImagePickerActivity.class);
		intent.putExtra(METHOD_TYPE, GET_IMAGE);
		getActivity().startActivity(intent);
	}
	
	public void takePicture()
	{
		Intent intent = new Intent(getActivity().getApplicationContext(), ImagePickerActivity.class);
		intent.putExtra(METHOD_TYPE, NEW_IMAGE);
		getActivity().startActivity(intent);
	}

}

package com.sundaytoz.ane.functions;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sundaytoz.ane.AndroidContext;
import com.sundaytoz.ane.AndroidExtension;
import com.sundaytoz.ane.DummyActivity;

public class GetImageFunction implements FREFunction {

	private FREContext _ctx;
	
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		
		AndroidExtension.aneContext.getImageFromAlbum();
		        
		return null;
	}
	
}

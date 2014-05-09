package com.sundaytoz.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sundaytoz.ane.AndroidExtension;

public class GetImageFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) 
	{
		AndroidExtension.aneContext.getImageFromAlbum();
		return null;
	}
	
}

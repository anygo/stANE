package com.sundaytoz.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class AndroidExtension implements FREExtension {
			
	public static AndroidContext aneContext;

	@Override
	public FREContext createContext(String arg0)
	{
		aneContext = new AndroidContext();
		return aneContext ;
	}

	@Override
	public void dispose() 
	{
		aneContext = null;
	}

	@Override
	public void initialize() {}
	
}

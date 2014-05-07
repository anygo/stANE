package com.sundaytoz.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class ANEHandler implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		return new ANEContext() ;
	}

	@Override
	public void dispose() {
	}

	@Override
	public void initialize() {
	}
	
}

package com.sundaytoz.ane.functions;

import android.content.Context;
import android.os.Build;
import android.telephony.PhoneNumberUtils;
import android.telephony.TelephonyManager;

import com.adobe.fre.FREASErrorException;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREInvalidObjectException;
import com.adobe.fre.FREObject;
import com.adobe.fre.FRETypeMismatchException;
import com.adobe.fre.FREWrongThreadException;

public class DeviceInfoFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {

		// 전화번호를 받음
	    TelephonyManager telephony=(TelephonyManager)(arg0.getActivity().getSystemService(Context.TELEPHONY_SERVICE));
	    String formattedTelNumber = PhoneNumberUtils.formatNumber(telephony.getLine1Number());
	    
	    try
	    {
	    	// 전화번호 및 모델명을 담은 FREArray 를 생성
	    	FREArray array = FREArray.newArray(2);
	    	array.setObjectAt(0, FREObject.newObject(formattedTelNumber));
	    	array.setObjectAt(1, FREObject.newObject(Build.MODEL));
	    	return array;
		} 
	    catch (FREWrongThreadException e) 
	    {
			e.printStackTrace();
		} 
	    catch (IllegalStateException e)
		{
			e.printStackTrace();
		} 
	    catch (FREASErrorException e) 
		{
			e.printStackTrace();
		}
	    catch (FREInvalidObjectException e) 
	    {
			e.printStackTrace();
		} 
	    catch (FRETypeMismatchException e) 
	    {
			e.printStackTrace();
		}
	    
	    return null;

	}


}

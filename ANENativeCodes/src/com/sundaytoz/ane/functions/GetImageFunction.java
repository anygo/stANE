package com.sundaytoz.ane.functions;

import java.io.ByteArrayOutputStream;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.net.Uri;
import android.provider.MediaStore.Images;
import android.util.Base64;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.sundaytoz.ane.AndroidExtension;

public class GetImageFunction implements FREFunction {

	private FREContext _ctx;
	
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		
		_ctx = arg0;
		
		Intent intent = new Intent();
        intent.setAction(Intent.ACTION_GET_CONTENT);
        intent.setType("image/*");

        AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "before calling startActivityForResult()");
		
        arg0.getActivity().startActivityForResult(intent, 0);

        AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after calling startActivityForResult()");

        
		return null;
	}
	
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
    	switch(0)
    	{
    	case 0:
    		try
    		{    			
    			//AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "starting startActivityForResult()");
    			
    			Uri imgUri = data.getData();
    			Bitmap bitmap = Images.Media.getBitmap(_ctx.getActivity().getContentResolver(), imgUri);

    			//AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after getBitmap()");

    			int height = bitmap.getHeight();
    			int width = bitmap.getWidth();
    			
    			Bitmap resized = null;
    			while(height>512)
    			{
    				resized = Bitmap.createScaledBitmap(bitmap, (width * 512)/height, 512, true);
    				height = resized.getHeight();
    				width = resized.getWidth();
    			}

    			//AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after createScaledBitmap()");
    			
    			Log.i("test", String.valueOf(resized.getWidth()));
    			Log.i("test", String.valueOf(resized.getHeight()));

    			ByteArrayOutputStream stream = new ByteArrayOutputStream();
    			resized.compress(CompressFormat.JPEG, 100, stream);
    			byte[] imageByteArray = stream.toByteArray();

    			//AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after toByteArray()");
    			    			
    			String result = Base64.encodeToString(imageByteArray, Base64.DEFAULT);
    			
    			Activity airActivity = _ctx.getActivity();
    			Intent noti = new Intent(airActivity, airActivity.getClass());
    			noti.addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
    			noti.setData(Uri.parse(result));
    			airActivity.startActivity(noti);
    			
    			//AndroidExtension.aneContext.dispatchStatusEventAsync("imageSelected", result);
    			
//    			byte[] encodeByte = Base64.decode(result, Base64.DEFAULT);
    	
    			
//    			resized = BitmapFactory.decodeByteArray(encodeByte, 0, encodeByte.length ) ;  
//    		    _imageView.setImageBitmap(resized);
    		}
    		catch(Exception e)
    		{
    			e.printStackTrace();
    		}
    		
    		break;
    	}
    }
	
}

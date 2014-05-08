package com.sundaytoz.ane;

import java.io.ByteArrayOutputStream;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore.Images;
import android.util.Base64;
import android.util.Log;

public class DummyActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);

        AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "onCreate()");
        
		Intent intent = new Intent();
        intent.setAction(Intent.ACTION_GET_CONTENT);
        intent.setType("image/*");


        AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "before calling startActivityForResult()");

        startActivityForResult(intent, 0);

        AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after calling startActivityForResult()");
	}
	

	protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
    	switch(0)
    	{
    	case 0:
    		try
    		{    			
    			AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "starting startActivityForResult()");
    			
    			Uri imgUri = data.getData();
    			Bitmap bitmap = Images.Media.getBitmap(getContentResolver(), imgUri);

    			AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after getBitmap()");

    			int height = bitmap.getHeight();
    			int width = bitmap.getWidth();
    			
    			Bitmap resized = null;
    			while(height>512)
    			{
    				resized = Bitmap.createScaledBitmap(bitmap, (width * 512)/height, 512, true);
    				height = resized.getHeight();
    				width = resized.getWidth();
    			}

    			AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after createScaledBitmap()");
    			
    			Log.i("test", String.valueOf(resized.getWidth()));
    			Log.i("test", String.valueOf(resized.getHeight()));

    			ByteArrayOutputStream stream = new ByteArrayOutputStream();
    			resized.compress(CompressFormat.JPEG, 100, stream);
    			byte[] imageByteArray = stream.toByteArray();

    			AndroidExtension.aneContext.dispatchStatusEventAsync("debugging", "after toByteArray()");
    			    			
    			String result = Base64.encodeToString(imageByteArray, Base64.DEFAULT);
    			
    			AndroidExtension.aneContext.dispatchStatusEventAsync("imageSelected", result);
    			
    			finish();
    		}
    		catch(Exception e)
    		{
    			e.printStackTrace();
    		}
    		
    		break;
    	}
    }

}

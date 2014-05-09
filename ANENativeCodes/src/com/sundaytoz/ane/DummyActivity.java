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
import android.view.WindowManager;

public class DummyActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		// 투명 액티비티 설정
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_BLUR_BEHIND, WindowManager.LayoutParams.FLAG_BLUR_BEHIND);
        
		Intent intent = new Intent();
        intent.setAction(Intent.ACTION_GET_CONTENT);
        intent.setType("image/*");

        // 앨범에서 사진을 받아옴
        startActivityForResult(intent, 0);
	}
	
	/**
	 * 앨범에서 사진을 받아온 후 호출되는 메소드입이다.
	 */
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
		try
		{    			
			Uri imgUri = data.getData();
			Bitmap bitmap = Images.Media.getBitmap(getContentResolver(), imgUri);
			
			int height = bitmap.getHeight();
			int width = bitmap.getWidth();
			
			// 이미지 사이즈 조정 (높이를 512 이하로 수정)
			Bitmap resized = null;
			while(height>512)
			{
				resized = Bitmap.createScaledBitmap(bitmap, (width * 512)/height, 512, true);
				height = resized.getHeight();
				width = resized.getWidth();
			}

			// Bitmap 파일을 String 으로 변환
			ByteArrayOutputStream stream = new ByteArrayOutputStream();
			resized.compress(CompressFormat.PNG, 100, stream);
			byte[] imageByteArray = stream.toByteArray();
			String encodedString = Base64.encodeToString(imageByteArray, Base64.NO_WRAP);
			
			// Air Application 으로 변환한 String 값을 보냄
			AndroidExtension.aneContext.dispatchStatusEventAsync("imageSelected", encodedString);
			
			// 액티비티 종료
			finish();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
    }

}

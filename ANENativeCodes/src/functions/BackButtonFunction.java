package functions;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class BackButtonFunction implements FREFunction{

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		
		final Activity activity = arg0.getActivity();
		
		new AlertDialog.Builder(activity)
			.setTitle("Quit")
			.setMessage("종료하시겠습니까?")
			.setPositiveButton("Yes", new DialogInterface.OnClickListener()
			{
				@Override
				public void onClick(DialogInterface dialog, int which) {
					activity.finish();
				}
			}).setNegativeButton("No", null).show();
		
		return null;
	}

}

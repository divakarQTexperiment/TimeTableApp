//email intent javaclass

package com.lasconic;

import org.qtproject.qt5.android.QtNative;

import java.lang.String;
import android.content.Intent;
import android.util.Log;

public class QEmailUtils
{
    protected QEmailUtils()
    {
      // Log.d("lasconic", "QEmailUtils()");
    }

    public static void sendEmail(String emailBody, String subject ,String emailId) {
        if (QtNative.activity() == null)
            return;
        Intent sendIntent = new Intent();
        sendIntent.setAction(Intent.ACTION_SEND);
	sendIntent.setType("text/html");
	sendIntent.putExtra(Intent.EXTRA_EMAIL, "emailaddress@emailaddress.com");
	sendIntent.putExtra(Intent.EXTRA_SUBJECT, "Subject");
	sendIntent.putExtra(Intent.EXTRA_TEXT, "I'm email body.");
       // sendIntent.putExtra(Intent.EXTRA_TEXT, text + " " + url);
       // sendIntent.setType("text/plain");
        QtNative.activity().startActivity(sendIntent);

	//Intent intent = new Intent(Intent.ACTION_SEND);
//	intent.setType("text/html");
//	intent.putExtra(Intent.EXTRA_EMAIL, "emailaddress@emailaddress.com");
//	intent.putExtra(Intent.EXTRA_SUBJECT, "Subject");
//	intent.putExtra(Intent.EXTRA_TEXT, "I'm email body.");

//	startActivity(Intent.createChooser(intent, "Send Email"));
    }
}


//share intent javaclass

package com.lasconic;
import org.qtproject.qt5.android.QtNative;
import java.lang.String;
import android.content.Intent;
import android.util.Log;

public class QShareUtils
{
    protected QShareUtils()
    {
       //Log.d("lasconic", "QShareUtils()");
    }

    public static void share(String text, String url) {
        if (QtNative.activity() == null)
            return;
        Intent sendIntent = new Intent();
        sendIntent.setAction(Intent.ACTION_SEND);
        sendIntent.putExtra(Intent.EXTRA_TEXT, text + " " + url);
        sendIntent.setType("text/plain");
        QtNative.activity().startActivity(sendIntent);
    }
}

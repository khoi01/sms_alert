package com.example.sms_alert;

import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.IBinder;
import android.provider.Telephony;
import android.util.Log;


import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class SmsService extends Service  implements MethodChannel.MethodCallHandler {

    private SmsBroadcastReceiver smsBroadcastReceiver;
    private static final String TAG = "SmsService";
    private static final String CHANNEL = "com.khoi.sms_alert";


    public SmsService() {

    }

    @Override
    public IBinder onBind(Intent intent) {
        return  null;
    }


    @Override
    public void onCreate() {

        smsBroadcastReceiver = new SmsBroadcastReceiver();
        IntentFilter intentFilter =  new IntentFilter(Telephony.Sms.Intents.SMS_RECEIVED_ACTION);
//        intentFilter.addAction(Intent.ACTION_SCREEN_ON);
//        intentFilter.addAction(Intent.ACTION_SCREEN_OFF);
        registerReceiver(smsBroadcastReceiver, intentFilter);

        smsBroadcastReceiver.setListener(new SmsBroadcastReceiver.Listener() {
            @Override
            public void onTextReceived(String sender, String message) {
                Log.d(TAG, "onTextReceived: sender:"+sender+"| messsage:"+message);
               //MainActivity.callFlutter();


            }
        });
        super.onCreate();
    }





    @Override
    public void onDestroy() {
        unregisterReceiver(smsBroadcastReceiver);
        super.onDestroy();
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

    }
}

package cn.org.xinli.android.app
import io.flutter.app.FlutterApplication
import com.umeng.commonsdk.UMConfigure
class MyFlutterApplication: FlutterApplication() {
    override fun onCreate() {
        super.onCreate();
        UMConfigure.preInit(this, "60c1b8eba82b08615e4d8883", "android_oppo");
        UMConfigure.init(this, "60c1b8eba82b08615e4d8883", "android_oppo", UMConfigure.DEVICE_TYPE_PHONE, "");
        UMConfigure.setLogEnabled(true);
        com.umeng.umeng_common_sdk.UmengCommonSdkPlugin.setContext(this);
        android.util.Log.i("UMLog", "onCreate@MainActivity");
    }
}
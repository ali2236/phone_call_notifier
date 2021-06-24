package ir.aligator.phone_call_notifier

import android.content.Context
import android.content.Context.TELEPHONY_SERVICE
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel


/** PhoneCallNotifierPlugin */
class PhoneCallNotifierPlugin: FlutterPlugin, EventChannel.StreamHandler {
  private lateinit var channel : EventChannel
  private var context : Context? = null
  private lateinit var telephonyManager : TelephonyManager
  private lateinit var phoneStateListener : PhoneStateListener

  /** Flutter Plugin Overrides **/
  
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = EventChannel(flutterPluginBinding.binaryMessenger, "ir.aligator.phonecallnotifier")
    channel.setStreamHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setStreamHandler(null)
  }

  /** Event Stream Overrides **/

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    if(context!=null){
      telephonyManager =  context!!.getSystemService(TELEPHONY_SERVICE) as TelephonyManager
      phoneStateListener = createListener(events!!)
      telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
    } else {
      events?.error("no_context", "Context is Null in AndroidPhoneCallNotifierPlugin", null)
    }
    TelephonyManager.CALL_STATE_IDLE
  }

  override fun onCancel(arguments: Any?) {
    telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_NONE);
  }

  /** Private Methods **/

  private fun createListener(events: EventChannel.EventSink) : PhoneStateListener{
    return object : PhoneStateListener() {
      override fun onCallStateChanged(state: Int, phoneNumber: String?) {
        events.success(state)
      }
    }
  }
}

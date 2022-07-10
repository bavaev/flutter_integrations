package com.example.integrations_flutter

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.widget.EditText
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val androidViewId = "INTEGRATION_ANDROID"
    private val methodChannel = "CALL_METHOD"
    private val intentMessage = "CALL"
    private val eventsChannel = "CALL_EVENTS"
    private val intentName = "EVENTS"

    private var receiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.platformViewsController.registry.registerViewFactory(
            androidViewId,
            AndroidTextViewFactory(flutterEngine.dartExecutor.binaryMessenger)
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            methodChannel
        ).setMethodCallHandler { call, result ->
            if (call.method == intentMessage) {
                result.success(findViewById<EditText?>(0).text.toString());
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor, eventsChannel).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventChannel.EventSink) {
                    receiver = createReceiver(events)
                    applicationContext?.registerReceiver(receiver, IntentFilter(intentName))
                }

                override fun onCancel(args: Any?) {
                    receiver = null
                }
            }
        )
    }

    fun createReceiver(events: EventChannel.EventSink): BroadcastReceiver? {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent) {
                events.success(intent.getStringExtra(intentMessage))
            }
        }
    }
}

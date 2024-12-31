package com.example.ir_remote_control

import android.hardware.ConsumerIrManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "ir_transmitter"
    private var irManager: ConsumerIrManager? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        irManager = getSystemService(CONSUMER_IR_SERVICE) as ConsumerIrManager?

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isIRSupported" -> {
                    val isSupported = irManager?.hasIrEmitter() == true
                    result.success(isSupported)
                }
                "sendIR" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                        val consumerIrManager = getSystemService(CONSUMER_IR_SERVICE) as ConsumerIrManager
                        val pattern = call.argument<List<Int>>("pattern")
                        val frequency = call.argument<Int>("frequency")

                        if (pattern != null && frequency != null) {
                            try {
                                consumerIrManager.transmit(frequency, pattern.toIntArray())
                                result.success(null) // Signal sent successfully
                            } catch (e: Exception) {
                                result.error("IR_TRANSMIT_ERROR", "Failed to send IR signal: ${e.message}", null)
                            }
                        } else {
                            result.error("INVALID_ARGUMENTS", "Invalid arguments for sendIR", null)
                        }
                    } else {
                        result.error("UNSUPPORTED", "IR transmission requires at least Android 4.4 (KitKat)", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun sendIRSignal(pattern: String) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            val codes = pattern.split(" ").map { it.toInt(16) }.toIntArray()
            irManager?.transmit(38000, codes) // Sends IR signal at 38 kHz
        }
    }
}

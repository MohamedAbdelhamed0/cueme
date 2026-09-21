package com.cueme.cueme

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.core.content.FileProvider
import java.io.File
import android.content.Intent

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "cueme/notification_sounds")
            .setMethodCallHandler { call, result ->
                if (call.method != "getSoundUri") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }
                try {
                    val path = requireNotNull(call.argument<String>("path"))
                    val file = File(path).canonicalFile
                    val recordings = File(filesDir, "audio/recordings").canonicalFile
                    require(file.parentFile == recordings && file.isFile) {
                        "Notification recording is missing or outside the recordings directory"
                    }
                    val uri = FileProvider.getUriForFile(
                        this, "$packageName.notification_sounds", file
                    )
                    // The system ringtone player must be able to open the recording
                    // independently of the Flutter activity and notification tap.
                    grantUriPermission(
                        "com.android.systemui", uri, Intent.FLAG_GRANT_READ_URI_PERMISSION
                    )
                    result.success(uri.toString())
                } catch (e: Exception) {
                    result.error("notification_sound_unavailable", e.message, null)
                }
            }
    }
}

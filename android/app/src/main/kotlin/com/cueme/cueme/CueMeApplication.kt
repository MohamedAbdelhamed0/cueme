package com.cueme.cueme

import android.app.Application
import android.content.Intent
import android.util.Log
import androidx.core.content.FileProvider
import java.io.File

class CueMeApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // URI grants do not survive a reboot. Restore them when Android starts
        // the scheduled receiver, even if no Flutter activity has been opened.
        File(filesDir, "audio/recordings").listFiles()?.forEach { recording ->
            if (recording.isFile && recording.extension == "wav") {
                try {
                    val uri = FileProvider.getUriForFile(
                        this, "$packageName.notification_sounds", recording
                    )
                    grantUriPermission(
                        "com.android.systemui", uri, Intent.FLAG_GRANT_READ_URI_PERMISSION
                    )
                } catch (e: Exception) {
                    Log.w("CueMeSound", "Unable to restore notification sound access", e)
                }
            }
        }
    }
}

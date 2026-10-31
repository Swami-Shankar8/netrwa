package com.example.netrwa

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager

class MainActivity: FlutterActivity() {
    private val APP_SCANNER_CHANNEL = "netrwa.security/app_scanner"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, APP_SCANNER_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getInstalledApps" -> {
                    val apps = getInstalledApplications()
                    result.success(apps)
                }
                "getHiddenApps" -> {
                    val hiddenApps = getSuspiciousApplications()
                    result.success(hiddenApps)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getInstalledApplications(): List<Map<String, Any>> {
        val pm = packageManager
        val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)
        val appList = mutableListOf<Map<String, Any>>()

        for (appInfo in packages) {
            val isSystemApp = (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
            val appMap = mapOf(
                "appName" to pm.getApplicationLabel(appInfo).toString(),
                "packageName" to appInfo.packageName,
                "isSystem" to isSystemApp
            )
            appList.add(appMap)
        }
        return appList
    }

    private fun getSuspiciousApplications(): List<Map<String, Any>> {
        val pm = packageManager
        val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)
        val hiddenApps = mutableListOf<Map<String, Any>>()

        for (appInfo in packages) {
            // Check for apps without launcher icons or system disguise
            val isSystemApp = (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
            val launchIntent = pm.getLaunchIntentForPackage(appInfo.packageName)
            
            if (!isSystemApp && launchIntent == null) {
                hiddenApps.add(
                    mapOf(
                        "appName" to pm.getApplicationLabel(appInfo).toString(),
                        "packageName" to appInfo.packageName,
                        "risk" to "High Risk",
                        "access" to "Hidden background service"
                    )
                )
            }
        }
        return hiddenApps
    }
}
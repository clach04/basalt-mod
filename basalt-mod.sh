#!/bin/bash
echo "com.getpebble.android.basalt"
echo "Applying Android P telephony patch..."
rm PutApkHere/deleteme
if [ -z "$(ls -A PutApkHere)" ]; then
   	echo "PutApkHere has no APK! Please put com.getpebble.android.basalt APK in $(pwd)/PutApkHere/ and run the script again."
else
	mkdir tmp
	apktool d PutApkHere/com.getpebble.android.basalt.apk -o tmp/PebbleApk
	cd tmp/PebbleApk
	patch AndroidManifest.xml -i ../../android-p-read_call_logs.patch -o AndroidManifest_Mod.xml
	mv AndroidManifest_Mod.xml AndroidManifest.xml
	cd ..
	apktool b PebbleApk -o ../OUT/com.getpebble.mod.basalt.apk
	echo "Optional: sign APK with your own keystore file"
	echo "Then install App on device"
	sleep 2
	echo "Step 2: grant permission to pebble app"
	echo "Plug phone with Adb enabled and app installed"
	echo "Then press enter;"
	read
	adb shell pm grant com.getpebble.android.basalt android.permission-group.CALL_LOG
	adb shell dumpsys package com.getpebble.android.basalt
fi

nox_adb.exe -s 127.0.0.1:62025 shell am start -n 'com.android.settings'
nox_adb.exe -s 127.0.0.1:62025 shell monkey -p com.global.musvn -c android.intent.category.LAUNCHER 1 ; start app
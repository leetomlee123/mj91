call flutter build apk --obfuscate --split-debug-info=HLQ_Struggle --target-platform android-arm64 --split-per-abi --build-name=0.0.1 --build-number=3
call adb connect 192.168.18.113
call flutter install
pause
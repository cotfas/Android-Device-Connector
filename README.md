# Android-Device-Connector
Simple android.sh terminal command to connect to Android devices via ADB and scrcpy for Android Developers

Example of usage video:
https://github.com/cotfas/Android-Device-Connector/blob/main/Example.mov

# How to install on Mac OSX:

    brew install scrcpy
    brew install android-platform-tools
    
Copy android.sh to your profile path.

#How to use it:
    
    Connect android device to USB cable
    Use command: android.sh and select from the dropdown the proper device
    
Example android.sh:

    cotfas@Vlads-MacBook-Pro Desktop % android.sh
    List of devices attached
    9889db394248483045	device
    emulator-5554	device

    >>> Select device to connect via USB...

Selecting the device it will automatically connect to the device screen, where the user can interact with

The script will also work with connecting to devices over wifi by using the command:

    android.sh w
    
    List of devices attached
    9889db394248483045	device
    emulator-5554	device

    >>> Select a device to connect via wifi...

And selecting the `android.sh d` will be able to deconnect the device from the ADB.

Example on how it looks:

    ![alt text](https://raw.githubusercontent.com/cotfas/Android-Device-Connector/main/android-device-window.png)


# License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

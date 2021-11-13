# Android-Device-Connector
Created a simple android.sh terminal command to connect to Android devices via ADB and scrcpy for Android Developers

# How to install on Mac OSX:

    brew install scrcpy
    brew install android-platform-tools
    
Copy android.sh to your profile path.

How to use it:
    
    Connect android device to USB cable
    Use command: android.sh and select from the dropdown the proper device
    
Example command `android.sh`:

    List of devices attached
    9889db394248483045  device
    emulator-5554	    device

    >>> Select device to connect via USB...

Selecting the device it will automatically connect to the device screen, where the user can interact with

The script will also work with connecting to devices over wifi by using the `android.sh w` command:

    List of devices attached
    9889db394248483045  device
    emulator-5554       device

    >>> Select a device to connect via wifi...

And selecting the `android.sh d` will be able to disconnect the device from the ADB.

Example on how it looks like:

![alt text](https://raw.githubusercontent.com/cotfas/Android-Device-Connector/main/Sample/android-device-window.png?raw=true)

Example of usage can be found: [Link to Video](https://github.com/cotfas/Android-Device-Connector/blob/main/Sample/Example.mov)


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

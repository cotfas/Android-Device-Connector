#!/bin/bash

#Author: Vlad Cotfas @APACHE2.0 License - https://github.com/cotfas/Android-Device-Connector

#first setup
#brew install scrcpy
#brew install android-platform-tools
#brew install iproute2mac


function random-port() {
    while [[ not != found ]]; do
        # 2000..33500
        port=$((RANDOM + 2000))
        while [[ $port -gt 33500 ]]; do
            port=$((RANDOM + 2000))
        done

        # 2000..65001
        [[ $((RANDOM % 2)) = 0 ]] && port=$((port + 31501)) 

        # 2000..65000
        [[ $port = 65001 ]] && continue
        echo $port
        break
    done
}

function getDeviceIp() {
    #echo "Getting deviceIp for deviceName = $1"
    adb -s $1 shell ip route | awk '{print $9}'
}

#https://stackoverflow.com/questions/2604727/how-can-i-connect-to-android-with-adb-over-tcp/44460975
function adb-connect-to-wifi() {
    ip=$1
    port=5555
    ipPort=${ip}:${port}

    #first we disconnect
    #adb disconnect ${ip}

    adb tcpip ${port}
    adb connect ${ipPort}
}

#brew install iproute2mac - https://stackoverflow.com/questions/21679893/linux-check-if-in-same-network
function is_remote_ip() {
   ip route get $1 | grep -q "via $(ip route | awk '/default/ {print $3}') "
}

#List of devices attached
#9889db394248483045  device
#emulator-5554   device
function listDevicesAndSelect() {

    adb devices > /tmp/adbdevices
    cat /tmp/adbdevices

    fileItemString=$(cat /tmp/adbdevices |tr "\n" " ")
    fileItemArray=($fileItemString)
    Length=${#fileItemArray[@]}

    # taking firts word
    #echo "asd dd"  | head -n1 | cut -d " " -f1

    #Printing selecting device
    if [ -z "$paramArgs" ]; then
        echo ">>> Select device to connect via USB..."
    elif [ "$paramArgs" = "d" ]; then
        echo ">>> Select device to disconnect..."
    elif [ "$paramArgs" = "w" ]; then
       echo ">>> Select a device to connect via wifi..."
    else
        echo ">>> Select a device to connect..."
    fi
    read parameter
    
    #No selected parameter, using first option
    if [ -z "$parameter" ]; then
          parameter=1
    fi

    # Finding/extracting deviceName from the selected param
    counter=1
    for i in $(seq 4 2 $Length)
    do
        if [ $parameter = $counter ]; then
            deviceName=${fileItemArray[$i]}
        fi
       counter=$((counter + 1))
    done

    #Getting deviceIp from deviceName
    deviceIp=$(getDeviceIp $deviceName)

    if [ -z "$deviceIp" ]; then
        isConnectedToLan="no"
    else
        isConnectedToLan=$(is_remote_ip $deviceIp && echo no || echo yes)
    fi

    echo ">>> Selected device = $parameter, deviceName = $deviceName, deviceIp = $deviceIp, isConnectedToLan = $isConnectedToLan"
}

function closeConsole() {
    # does not fully work
    command; exit
    kill -9 $PPID
}

function connectWifi() { 
    echo ">>> Connecting via ADB wifi, executing scrcpy deviceIp = $deviceIp"
    adb-connect-to-wifi $deviceIp
    scrcpy -p $(random-port) -s $ipPort
}

function connectUsb() {
    if [[ $deviceName == *"5555"* ]]; then
        echo ">>> Connecting via wifi, executing scrcpy deviceName = $deviceName"
    else
        echo ">>> Connecting via USB cable, executing scrcpy deviceName = $deviceName"
    fi
    scrcpy -p $(random-port) -s $deviceName
}

function execute {  

    if [ "$paramArgs" = "d" ]; then
        listDevicesAndSelect
        adb disconnect $deviceName
        return
    fi

    if [ "$paramArgs" = "w" ]; then
        listDevicesAndSelect

        if [ $isConnectedToLan = "yes" ]; then
            connectWifi &
            return
        else
            connectUsb &
            return
        fi
    fi    

    if [ -z "$paramArgs" ]; then
        listDevicesAndSelect

        connectUsb &
    else
        deviceIp=$paramArgs
        connectWifi &
    fi
}


paramArgs=$1
clear
execute

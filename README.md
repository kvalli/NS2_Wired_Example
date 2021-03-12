# NS2_Wired_Example
Example TCL Script to generate wired NS2 scenario

This is for automatic fire detection in a multi storeyed building/society. There are 15 houses on each block and each house has 5 rooms in which the sensors are enabled. All End Devices are equipped with Controllers that can turn on/ turn off the sprinklers based on the various parameters (temperature, gas, flame) measured in each rooms. All End Devices are connected to a local coordinator in each house.

A local Coordinator also has its own smoke and DHT sensors that can control its own smoke level and other connected devices and make decisions accordingly. The local Coordinators are connected to a Central Coordinator – which you can assume interfaces to the cloud. All connections are wired.

 
Traffic in the system
At regular intervals of time (every 5 minutes) the local coordinators send information about the present status of the smoke level, temperature of the rooms and sprinkler status to the central coordinator.The central coordinator checks the sent information for each end device with the limit values and if there are any higher indications, sends alerts to the local coordinators every 10 minutes.The local coordinators alert the end devices accordingly after receiving instructions from the central coordinator.
Simulate this traffic.

![image](https://user-images.githubusercontent.com/8524239/110910952-fd93b100-834c-11eb-9fb4-a8498b12aaaa.png)

# WiFiScanner

![demo](https://raw.githubusercontent.com/darg20127/WiFiScanner/master/Demo/demo.jpeg)

### USAGE
```
Usage: WiFiScanner [OPTION]
Scan wireless networks and view WLAN SSID, BSSID, PHY Mode, Channel, Channel Band, Bandwidth, RSSI, Noise and Security

--help, -h            This usage
--updateInterval=NUM  Process wait for NUM seconds for every scan
--updateTimes=NUM     Process will scan NUM times
--ssid=NAME           Process will try to find wifi whose SSID is NAME
--fssid=NAME          Porcess will try to find wifi that contains NAME in their SSID.
--band=[24|5]         Porcess will try to find 2.4G or 5G.

About updateInterval and updateTimes:
If updateInterval is not given, process run once.
If updateInterval is given but updateTimes is not, process run forever.
If updateInterval and updateTimes are given, process updateTimes times.
```

### TODO
- [ ] Refresh output
- [ ] Filter 




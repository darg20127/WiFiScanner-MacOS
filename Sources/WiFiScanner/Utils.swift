import Darwin

let ARGUMENT_NOT_SET_INT = -1

// global settings
struct Settings {
	var updateInterval: Int = ARGUMENT_NOT_SET_INT
	var updateTimes: Int = ARGUMENT_NOT_SET_INT
	var maxRecord: Int = ARGUMENT_NOT_SET_INT
	var sortBy: String = "SSID"
	var sortOrder: String = ""
	var findSSID: String? = nil
	var findFSSID: String? = nil
	var findBand: Int = ARGUMENT_NOT_SET_INT
}

func getopt_long (argus: [String]) -> [(name: String, value: String)] {
	var res = [(name: String, value: String)]()

	for argu in argus {

		let seps = argu.split(separator: "=", maxSplits: 1)

		var name: String = ""
		var value: String = ""

		if seps.count == 1 {
			name = String(seps[0])
		} else if seps.count == 2 {
			name = String(seps[0])
			value = String(seps[1])
		} else {
			print("Argument error on \(argu)")
		}

		guard name.hasPrefix("--") || name.hasPrefix("-") else {
			print("Arguments error: require '--' or '-' on \(argu)")
			continue
		}
		
		if name.first == "-" {
			name.removeFirst()
		}
		
		if name.first == "-" {
			name.removeFirst()
		}
		
		res.append( (name: name, value: value ) )
	}

	return res
}

func getSettings ( argus: [(name: String, value: String)] ) -> Settings{
	var Sets = Settings()
	for argu in argus {
		if argu.name == "updateInterval" {
			let input = Int(argu.value) ?? ARGUMENT_NOT_SET_INT
			guard input >= 5 else {
				print("Arguments error: updateIntreval should be >= 5 but get \(argu.value)")
				exit(-1)
			}
			Sets.updateInterval = input
		} else if argu.name == "updateTimes" {
			let input = Int(argu.value) ?? ARGUMENT_NOT_SET_INT
			guard input >= 0 else {
				print("Arguments error: updateTimes should be >= 0 but get \(argu.value)")
				exit(-1)
			}
			Sets.updateTimes = input
		} else if argu.name == "ssid" {
			let input = argu.value
			guard input != "" else {
				print("Arguments error: ssid require input but get \(argu.value)")
				exit(-1)
			}
			Sets.findSSID = input
		} else if argu.name == "fssid" {
			let input = argu.value
			guard input != "" else {
				print("Arguments error: fssid require input but get \(argu.value)")
				exit(-1)
			}
			Sets.findFSSID = input
		} else if argu.name == "band" {
			let input = Int(argu.value) ?? ARGUMENT_NOT_SET_INT
			guard input == 24 || input == 5 else {
				print("Arguments error: band require input ether 24 or 5 but get \(argu.value)")
				exit(-1)
			}
			Sets.findBand = input
		} else if argu.name == "help" || argu.name == "h" {
			usage()
			exit(0)
		}
	}
	return Sets
}

func usage() {
	print("Usage: WiFiScanner [OPTION]")
	print("Scan wireless networks and view WLAN SSID, BSSID, PHY Mode, Channel, Channel Band, Bandwidth, RSSI, Noise and Security")
	print()
	print("--help, -h            This usage")
	print("--updateInterval=NUM  Process wait for NUM seconds for every scan")
	print("--updateTimes=NUM     Process will scan NUM times")
	print("--ssid=NAME           Process will try to find wifi whose SSID is NAME")
	print("--fssid=NAME          Porcess will try to find wifi that contains NAME in their SSID.")
	print("--band=[24|5]         Porcess will try to find 2.4G or 5G.")
	print("\nAbout updateInterval and updateTimes:")
	print("If updateInterval is not given, process run once.")
	print("If updateInterval is given but updateTimes is not, process run forever.")
	print("If updateInterval and updateTimes are given, process updateTimes times.")
}

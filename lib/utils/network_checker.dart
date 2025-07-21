

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChercker {
  static Future<bool> hasInternetConnection() async {
    //print('✅ Internet is available2');
    var connectivityResult = await Connectivity().checkConnectivity();
    //print('✅ Internet is available3');
    // Check if device is connected to WiFi or Mobile data
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    //print('✅ Internet is available4');
    // Check if the internet is actually available
    bool isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
  }
}
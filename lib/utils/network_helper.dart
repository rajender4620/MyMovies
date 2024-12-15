import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  static Future<ConnectivityResult> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.first;
  }
}

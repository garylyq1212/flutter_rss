import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final Connectivity connectivity;

  NetworkService(this.connectivity);

  // Future<bool> isConnected() async {
  //   final result = await connectivity.checkConnectivity();

  //   switch (result) {
  //     case ConnectivityResult.wifi:

  //       break;
  //     default:
  //   }

  // }
}

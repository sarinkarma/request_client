import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckInternetConnection {
  Future<bool> isInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      try {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result) {
          return true;
        } else {
          // Mobile data detected but no internet connection found.
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      try {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result) {
          return true;
        } else {
          // Mobile data detected but no internet connection found.
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }
}

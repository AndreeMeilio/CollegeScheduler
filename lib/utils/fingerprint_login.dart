
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintLogin {

  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkDeviceSupportedForBiometrics() async{

    final canCheckBiometrics = await auth.canCheckBiometrics;
    final canAuthenticate = canCheckBiometrics || await auth.isDeviceSupported();

    return canAuthenticate;
  }

  Future<List<BiometricType>> availableBiometrics() async {
    if (await checkDeviceSupportedForBiometrics()){
      final availableBiometrics = await auth.getAvailableBiometrics();
      
      if (availableBiometrics.contains(BiometricType.strong)){
        return availableBiometrics;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<bool> authenticateBiometric() async{
    try {
      final haveAvailableBio = await availableBiometrics();

      if (haveAvailableBio.isNotEmpty){

        final didAuth = await auth.authenticate(
          localizedReason: "Please authenticate to login using fingerprint",
        );

        return didAuth;
      } else {
        return false;
      }
    } on PlatformException catch (e){
      return false;
    }
  }
}
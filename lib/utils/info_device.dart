
import 'package:device_info_plus/device_info_plus.dart';

class InfoDeviceUtils {
  static final DeviceInfoPlugin device = DeviceInfoPlugin();

  static Future<AndroidDeviceInfo> getAndroidInfo() async{
    final AndroidDeviceInfo info = await device.androidInfo;

    return info;
  }
}
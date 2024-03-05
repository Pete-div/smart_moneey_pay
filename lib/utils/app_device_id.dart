import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class AppDeviceIdUtil {
  AppDeviceIdUtil._();
  static Future<String> getId() async {
 

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
      return deviceInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;
      return deviceInfo.identifierForVendor ?? '';
    }
    return '';
  }}
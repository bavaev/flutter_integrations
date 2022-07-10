import 'package:flutter/services.dart';
import 'package:platform_channels/service.dart';

class PlatformServiceImpl implements PlatformService {
  static const platform = MethodChannel('CALL_METHOD');
  static const stream = EventChannel('CALL_EVENTS');

  Future<String> getValue() async {
    try {
      return await platform.invokeMethod('CALL');
    } on PlatformException catch (e) {
      print('Failed to get value: ${e.message}');
      return '';
    }
  }

  Stream getStream() => stream.receiveBroadcastStream().map((event) => event);
}

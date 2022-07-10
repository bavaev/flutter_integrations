import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final Widget view;
    if (defaultTargetPlatform == TargetPlatform.android) {
      view = AndroidView(
        viewType: 'INTEGRATION_ANDROID',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      view = UiKitView(
        viewType: 'INTEGRATION_IOS',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      view = Text('$defaultTargetPlatform is not yet supported');
    }
    return SizedBox(
      child: view,
    );
  }

  void _onPlatformViewCreated(int id) {
    print('PlatformView with id:$id created');
  }
}

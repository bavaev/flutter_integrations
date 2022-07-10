import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 200,
      child: HtmlElementView(
        viewType: 'web-button',
        onPlatformViewCreated: _onPlatformViewCreated,
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    print('PlatformView with id:$id created');
  }
}

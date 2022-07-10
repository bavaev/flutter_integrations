import 'package:flutter/material.dart';

import 'package:platform_channels/service.dart';

import 'dummy/platform_view_dummy.dart' if (dart.library.html) 'web/platform_view.dart' if (dart.library.io) 'mobile/platform_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Channels',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Platform Channels'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _service = getService();
  String _text = '';

  void _getValue() async {
    _text = await _service.getValue();
    setState(() => _text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Events from platform:',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
            stream: _service.getStream(),
            builder: (context, snapshot) => Text(
              '${snapshot.hasData ? snapshot.data : ''}',
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Method channel from platform',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            _text,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: SizedBox(
              height: 200,
              child: PlatformWidget(),
            ),
          ),
          ElevatedButton(
            onPressed: _getValue,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Flutter Button',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

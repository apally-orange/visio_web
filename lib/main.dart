import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:poc_web_visioglobe/mapview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Test VisioWeb'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapViewer map;

  @override
  void initState() {
    super.initState();

    final mapview = IFrameElement()
      ..id = 'mapview'
      ..style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'element',
      (int viewId) => mapview,
    );

    map = MapViewer(
      MapViewerParameters(
        path:
            'https://mapserver.visioglobe.com/kd9426d8cb3f1c532f22b5bcbd325c280bd351feb/descriptor.json',
        initialFloor: 'B4-UL00',
      ),
    );

    map.load().then(() {
      map.setupView(mapview);
      map.start();
      map.setupMultiBuildingView(
        MultiBuildingParameters(
          mapview,
          '',
          'multibuilding',
          'both',
        ),
        MultifloorConfig(true, true, true, true),
        0,
      );
      map.cameraDrivenExplorer.setEnabled(true);

      goToHome();
    });
  }

  void goToHome() {
    print('hello');
    map.multiBuildingView.goTo(
      GotTorParameters(
        mode: 'global',
        animationDuration: 500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HtmlElementView(
        key: UniqueKey(),
        viewType: 'element',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToHome(),
        child: Icon(Icons.home),
      ),
    );
  }
}

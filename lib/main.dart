import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:poc_web_visioglobe/mapview.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

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

    map = MapViewer();

    map
        .load(
          MapViewerParameters(
            path:
                'https://mapserver.visioglobe.com/kd9426d8cb3f1c532f22b5bcbd325c280bd351feb/descriptor.json',
            initialFloor: 'B4-UL00',
          ),
        )
        .then(
          () => map.setupView(mapview).then(() {
            map.start();
            map.setupMultiBuildingView(
              MultiBuildingParameters(
                container: mapview,
                viewType: 'multibuilding',
                animationType: 'perspective',
              ),
              MultifloorConfig(
                click: true,
                rotation: true,
                pitch: true,
                zoom: true,
              ),
              0,
            );
            map.cameraDrivenExplorer.maxExploreDistance = 300.0;
            map.cameraDrivenExplorer.setEnabled(true);

            goToHome();
          }),
        );
  }

  void goToHome() {
    print('hello ${map.cameraDrivenExplorer.maxExploreDistance}');
    map.multiBuildingView.goTo(
      GoToParameters(mode: 'global'),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    map?.resize(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
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
      floatingActionButton: PointerInterceptor(
        child: FloatingActionButton(
          onPressed: () => goToHome(),
          child: Icon(Icons.home),
        ),
      ),
    );
  }
}

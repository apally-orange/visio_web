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
  @override
  void initState() {
    super.initState();

    // final _iframeElement = IFrameElement();

    // _iframeElement.height = '500';
    // _iframeElement.width = '500';
    // _iframeElement.src = 'https://www.youtube.com/embed/RQzhAQlg2JQ';
    // _iframeElement.style.border = 'none';

    final element = DivElement();
    final mapview = DivElement()..id = 'mapview';
    element.id = 'element';
    element.children = [ParagraphElement()..text = 'Visio Web', mapview];

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'element',
      (int viewId) => element,
    );

    final map = MapViewer(
      MapViewerParameters(
        path:
            'https://mapserver.visioglobe.com/kd9426d8cb3f1c532f22b5bcbd325c280bd351feb/descriptor.json',
      ),
    );
    map.load().then(() {
      return map.setupView(mapview);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Expanded(
        child: Center(
          child: HtmlElementView(
            key: UniqueKey(),
            viewType: 'element',
          ),
        ),
      ),
    );
  }
}

@JS('visioweb')
library visioweb;

import 'package:js/js.dart';

@JS('Mapviewer')
class MapViewer {
  external MapViewer(parameters);
  external load();
  external start();
  external setupView(mapview);
  external resize(width, height);
  external setupMultiBuildingView(
      Object parameters, Object multifloorConfig, double stackGap);
  @JS()
  external CameraDrivenExplorer get cameraDrivenExplorer;
  @JS()
  external MultiBuildingView get multiBuildingView;
}

@JS('CameraDrivenExplorer')
class CameraDrivenExplorer {
  external setEnabled(bool enable);
}

@JS('MultiBuildingView')
class MultiBuildingView {
  external goTo(parameters);
}

class GotTorParameters {
  GotTorParameters({
    this.mode,
    this.animationDuration,
  });

  final String mode;
  final double animationDuration;
}

class MapViewerParameters {
  MapViewerParameters({
    this.path,
    this.initialFloor,
  });

  final String path;
  final String initialFloor;
}

class MultiBuildingParameters {
  MultiBuildingParameters(
    this.container,
    this.containerDivSelector,
    this.viewType,
    this.animationType,
  );

  Object container;
  String containerDivSelector;
  String viewType;
  String animationType;
}

class MultifloorConfig {
  MultifloorConfig(
    this.click,
    this.rotation,
    this.pitch,
    this.zoom,
  );

  bool click;
  bool rotation;
  bool pitch;
  bool zoom;
}

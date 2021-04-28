@JS('visioweb')
library visioweb;

import 'package:js/js.dart';

@JS('Mapviewer')
class MapViewer {
  external MapViewer();
  external load(parameters);
  external start();
  external setupView(mapview);
  external resize(width, height);
  external setupMultiBuildingView(
    Object parameters,
    Object multifloorConfig,
    double stackGap,
  );
  @JS()
  external CameraDrivenExplorer get cameraDrivenExplorer;
  @JS()
  external MultiBuildingView get multiBuildingView;
}

@JS('CameraDrivenExplorer')
class CameraDrivenExplorer {
  external get maxExploreDistance;
  external set maxExploreDistance(double value);
  external setEnabled(bool enable);
}

@JS('MultiBuildingView')
class MultiBuildingView {
  external String get DEFAULT;
  external goTo(parameters);
}

@JS()
@anonymous
class GoToParameters {
  external String get mode;

  external factory GoToParameters({String mode});
}

@JS()
@anonymous
class MapViewerParameters {
  external factory MapViewerParameters({
    String path,
    String initialFloor,
  });

  external String get path;
  external String get initialFloor;
}

@JS()
@anonymous
class MultiBuildingParameters {
  external factory MultiBuildingParameters({
    Object container,
    String containerDivSelector,
    String viewType,
    String animationType,
  });

  external Object get container;
  external String get containerDivSelector;
  external String get viewType;
  external String get animationType;
}

@JS()
@anonymous
class MultifloorConfig {
  external factory MultifloorConfig({
    bool click,
    bool rotation,
    bool pitch,
    bool zoom,
  });

  external bool get click;
  external bool get rotation;
  external bool get pitch;
  external bool get zoom;
}

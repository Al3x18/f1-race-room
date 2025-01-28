import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:race_room/utils/track/get_track_image.dart';
import 'package:widget_zoom/widget_zoom.dart';

class TrackMapView extends StatefulWidget {
  const TrackMapView({super.key, required this.trackName});

  final String trackName;

  @override
  State<TrackMapView> createState() => _TrackMapViewState();
}

class _TrackMapViewState extends State<TrackMapView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 42,
            right: 4,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close, size: 30),
            ),
          ),
          Center(
            child: WidgetZoom(
              heroAnimationTag: "circuit",
              zoomWidget: getTrackImage(widget.trackName),
            ),
          ),
        ],
      ),
    );
  }
}

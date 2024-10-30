import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:race_room/Utils/get_track_image.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(child: getTrackImage(widget.trackName)),
      ),
    );
  }
}

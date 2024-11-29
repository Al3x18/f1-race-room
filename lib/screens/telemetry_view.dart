import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/utils/save_pdf_locally.dart';

class ShowTelemetryFileView extends StatefulWidget {
  const ShowTelemetryFileView({
    super.key,
    required this.year,
    required this.trackName,
    required this.session,
    required this.driverName,
  });

  final String year;
  final String trackName;
  final String session;
  final String driverName;

  @override
  State<ShowTelemetryFileView> createState() => _TelemetryViewState();
}

class _TelemetryViewState extends State<ShowTelemetryFileView> {
  String? errorMessage;
  File? _pdfFile;

  @override
  void initState() {
    super.initState();
    _loadPdfFile();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future<void> _loadPdfFile() async {
    try {
      final pdfBytes = await ApiService().fetchTelemetryPdfFile(
        widget.year,
        widget.trackName,
        widget.session,
        widget.driverName,
      );
      final pdfFile = await savePdfLocally(pdfBytes);
      setState(() {
        _pdfFile = pdfFile;
        errorMessage = null; // Reset error message on successful file load
      });
    } catch (e) {
      String errMsg;
      try {
        errMsg = e.toString().split(":")[2];
      } catch (_) {
        debugPrint(e.toString());
        errMsg = "Internal server error. Try again later.";
      }
      setState(() {
        errorMessage = errMsg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final double topMargin = isLandscape ? screenHeight * 0.01 : screenHeight * 0.052;
    final double rightMargin = isLandscape ? screenWidth * 0.046 : screenWidth * 0.022;

    const TextStyle causesTextStyle = TextStyle(color: Colors.grey, fontSize: 10.5);

    return Scaffold(
      body: Stack(
        children: [
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 14),
                    Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 15.5),
                    ),
                    const SizedBox(height: 22),
                    Text("Some possible causes", style: causesTextStyle.copyWith(fontWeight: FontWeight.bold)),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("-  The driver may not be present in the session", style: causesTextStyle),
                        Text("-  There was no racing on that circuit that season", style: causesTextStyle),
                        Text("-  The session did not take place", style: causesTextStyle),
                        Text("-  The driver was not present that season", style: causesTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
            )
          else if (_pdfFile == null)
            const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Colors.red,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                  SizedBox(height: 14),
                  Text("Please wait..."),
                  Text("This may take a while."),
                  Text("Depends on your internet connection."),
                ],
              ),
            )
          else
            PDFView(
              filePath: _pdfFile!.path,
              backgroundColor: isDark ? Colors.black : Colors.white,
            ),
          Positioned(
            top: topMargin,
            right: rightMargin,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}

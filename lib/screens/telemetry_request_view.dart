import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/screens/telemetry_view.dart';

class TelemetryRequestView extends StatefulWidget {
  const TelemetryRequestView({super.key});

  @override
  State<TelemetryRequestView> createState() => _TelemetryRequestViewState();
}

class _TelemetryRequestViewState extends State<TelemetryRequestView> {
  String year = "";
  String trackName = "";
  String session = "";
  String driverName = "";

  String serverStatus = "Unreachable";
  bool showAdvice = false;

  final GlobalKey _dropdownMenuKey = GlobalKey();

  Future<Map<String, dynamic>> _getServerStatus() async {
    Map<String, dynamic> status = await ApiService().checkTelemetryServerStatus();
    if (status['status'] == 'online') {
      serverStatus = "online";
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const double sizeBoxHeight = 12.0;
    const double dropMenuLabelFontSize = 12.8;

    List<int> years = List<int>.generate(DateTime.now().year - 2023 + 1, (i) => 2023 + i);
    List<int> reversedYears = years.reversed.toList();

    List<DropdownMenuEntry<int>> dropdownMenuEntriesYears = reversedYears
        .map((year) => DropdownMenuEntry<int>(
              value: year,
              label: year.toString(),
            ))
        .toList();

    const List<DropdownMenuEntry<String>> dropdownMenuEntriesTracks = [
      DropdownMenuEntry<String>(value: 'Bahrain', label: 'Bahrein International Circuit'),
      DropdownMenuEntry<String>(value: 'Jeddah', label: 'Jeddah Corniche Circuit'),
      DropdownMenuEntry<String>(value: 'Melbourne', label: 'Albert Park Grand Prix Circuit'),
      DropdownMenuEntry<String>(value: 'Suzuka', label: 'Suzuka Circuit'),
      DropdownMenuEntry<String>(value: 'Shanghai', label: 'Shanghai International Circuit'),
      DropdownMenuEntry<String>(value: 'Miami', label: 'Miami International Autodrome'),
      DropdownMenuEntry<String>(value: 'Imola', label: 'Autodromo Enzo e Dino Ferrari'),
      DropdownMenuEntry<String>(value: 'Monaco', label: 'Circuit de Monaco'),
      DropdownMenuEntry<String>(value: 'Montreal', label: 'Circuit Gilles Villeneuve'),
      DropdownMenuEntry<String>(value: 'Spain', label: 'Circuit de Barcelona-Catalunya'),
      DropdownMenuEntry<String>(value: 'Austrian', label: 'Red Bull Ring'),
      DropdownMenuEntry<String>(value: 'Silverstone', label: 'Silverstone Circuit'),
      DropdownMenuEntry<String>(value: 'Hungary', label: 'Hungaroring'),
      DropdownMenuEntry<String>(value: 'Belgium', label: 'Circuit de Spa-Francorchamps'),
      DropdownMenuEntry<String>(value: 'Netherlands', label: 'Circuit Park Zandvoort'),
      DropdownMenuEntry<String>(value: 'Monza', label: 'Autodromo Nazionale di Monza'),
      DropdownMenuEntry<String>(value: 'Azerbaijan', label: 'Baku City Circuit'),
      DropdownMenuEntry<String>(value: 'Singapore', label: 'Marina Bay Street Circuit'),
      DropdownMenuEntry<String>(value: 'Austin', label: 'Circuit of the Americas'),
      DropdownMenuEntry<String>(value: 'Mexico', label: 'Autodromo Hermanos Rodriguez'),
      DropdownMenuEntry<String>(value: 'Brazil', label: 'Autodromo Jose Carlos Pace'),
      DropdownMenuEntry<String>(value: 'Las Vegas', label: 'Las Vegas Strip Street Circuit'),
      DropdownMenuEntry<String>(value: 'Qatar', label: 'Losail International Circuit'),
      DropdownMenuEntry<String>(value: 'AbuDhabi', label: 'Yas Marina Circuit'),
    ];

    const List<DropdownMenuEntry<String>> dropdownMenuEntriesSessions = [
      DropdownMenuEntry<String>(value: "FP1", label: "Practice 1"),
      DropdownMenuEntry<String>(value: "FP2", label: "Practice 2"),
      DropdownMenuEntry<String>(value: "FP3", label: "Practice 3"),
      DropdownMenuEntry<String>(value: 'Q', label: 'Qualifying'),
      DropdownMenuEntry<String>(value: 'R', label: 'Race'),
    ];

    const List<DropdownMenuEntry<String>> dropdownMenuEntriesDrivers = [
      DropdownMenuEntry<String>(value: 'ALO', label: 'Fernando ALONSO'),
      DropdownMenuEntry<String>(value: 'ALB', label: 'Alexander ALBON'),
      DropdownMenuEntry<String>(value: 'BOT', label: 'Valtteri BOTTAS'),
      DropdownMenuEntry<String>(value: 'COL', label: 'Franco COLAPINTO'),
      DropdownMenuEntry<String>(value: 'GAS', label: 'Pierre GASLY'),
      DropdownMenuEntry<String>(value: 'HAM', label: 'Lewis HAMILTON'),
      DropdownMenuEntry<String>(value: 'HUL', label: 'Nico HULKENBERG'),
      DropdownMenuEntry<String>(value: 'LAW', label: 'Liam LAWSON'),
      DropdownMenuEntry<String>(value: 'LEC', label: 'Charles LECLERC'),
      DropdownMenuEntry<String>(value: 'MAG', label: 'Kevin MAGNUSSEN'),
      DropdownMenuEntry<String>(value: 'NOR', label: 'Lando NORRIS'),
      DropdownMenuEntry<String>(value: 'OCO', label: 'Esteban OCON'),
      DropdownMenuEntry<String>(value: 'PER', label: 'Sergio PEREZ'),
      DropdownMenuEntry<String>(value: 'PIA', label: 'Oscar PIASTRI'),
      DropdownMenuEntry<String>(value: 'RUS', label: 'George RUSSEL'),
      DropdownMenuEntry<String>(value: 'SAI', label: 'Carlos SAINZ'),
      DropdownMenuEntry<String>(value: 'STR', label: 'Lance STROLL'),
      DropdownMenuEntry<String>(value: 'TSU', label: 'Yuki TSUNODA'),
      DropdownMenuEntry<String>(value: 'VER', label: 'Max VERSTAPPEN'),
      DropdownMenuEntry<String>(value: 'ZHO', label: 'Guanyu ZHOU'),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: kIsWeb || Platform.isIOS ? _buildBackButton() : null,
        actions: [
          if (!kIsWeb && Platform.isAndroid) _buildBackButton(),
        ],
        title: const Column(
          children: [
            Text(
              "(BETA)",
              style: TextStyle(fontSize: 9, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              "Telemetry",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "Fastest Lap",
              style: TextStyle(fontSize: 10.5, color: Colors.grey, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Visibility(
                visible: showAdvice,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text("Select all parameters to request the telemetry", style: TextStyle(color: Colors.red, fontSize: 11)),
                ),
              ),
            ),
            DropdownMenu<int>(
              width: double.infinity,
              dropdownMenuEntries: dropdownMenuEntriesYears,
              label: const Text("YEAR", style: TextStyle(fontSize: dropMenuLabelFontSize)),
              textStyle: const TextStyle(fontSize: dropMenuLabelFontSize),
              onSelected: (value) {
                year = value.toString();
              },
            ),
            const SizedBox(height: sizeBoxHeight),
            DropdownMenu<String>(
              key: _dropdownMenuKey,
              width: double.infinity,
              dropdownMenuEntries: dropdownMenuEntriesTracks,
              menuHeight: MediaQuery.of(context).size.height * 0.67,
              label: const Text("TRACK", style: TextStyle(fontSize: dropMenuLabelFontSize)),
              textStyle: const TextStyle(fontSize: dropMenuLabelFontSize),
              onSelected: (value) {
                trackName = value.toString();
              },
            ),
            const SizedBox(height: sizeBoxHeight),
            DropdownMenu<String>(
              width: double.infinity,
              dropdownMenuEntries: dropdownMenuEntriesSessions,
              label: const Text("SESSION", style: TextStyle(fontSize: dropMenuLabelFontSize)),
              textStyle: const TextStyle(fontSize: dropMenuLabelFontSize),
              onSelected: (value) {
                session = value.toString();
              },
            ),
            const SizedBox(height: sizeBoxHeight),
            DropdownMenu<String>(
              width: double.infinity,
              dropdownMenuEntries: dropdownMenuEntriesDrivers,
              menuHeight: MediaQuery.of(context).size.height < 670 ? MediaQuery.of(context).size.height * 0.48 : MediaQuery.of(context).size.height * 0.536,
              label: const Text("DRIVER", style: TextStyle(fontSize: dropMenuLabelFontSize)),
              textStyle: const TextStyle(fontSize: dropMenuLabelFontSize),
              onSelected: (value) {
                driverName = value.toString();
              },
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (year.isNotEmpty || trackName.isNotEmpty || session.isNotEmpty || driverName.isNotEmpty) {
                    if (serverStatus == 'online') {
                      Get.to(() => ShowTelemetryFileView(year: year, trackName: trackName, session: session, driverName: driverName));
                      setState(() {
                        showAdvice = false;
                      });
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();

                      SnackBar snackBar = SnackBar(
                        behavior: SnackBarBehavior.fixed,
                        content: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Server is offline or unreachable", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Please try again later.", style: TextStyle(fontSize: 12.5)),
                          ],
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: isDark ? Colors.white : Colors.black87,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      setState(() {
                        showAdvice = false;
                      });
                    }
                  } else {
                    setState(() {
                      showAdvice = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 237, 63, 51),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Request Telemetry", style: TextStyle(color: Colors.white, fontSize: 13.5)),
                    Text("may take a while", style: TextStyle(color: Color.fromARGB(255, 202, 202, 202), fontSize: 9.2)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            _buildServerStatusLabel(),
          ],
        ),
      ),
    );
  }

  IconButton _buildBackButton() {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.close, size: 28),
    );
  }

  FutureBuilder<Map<String, dynamic>> _buildServerStatusLabel() {
    const double serverStatusFontSize = 9.2;
    return FutureBuilder<Map<String, dynamic>>(
      future: _getServerStatus(),
      builder: (context, snapshot) {
        final String status = snapshot.data?['status'] ?? "Unreachable";

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: SizedBox(
              height: 6,
              width: 6,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.red,
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          if (snapshot.error is SocketException || snapshot.error is ClientException) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Text(
                "SERVER STATUS - UNREACHABLE",
                style: TextStyle(color: Colors.red, fontSize: serverStatusFontSize, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red, fontSize: serverStatusFontSize),
              ),
            );
          }
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              "SERVER STATUS - ${status.toUpperCase()}",
              style: TextStyle(color: status == 'online' ? Colors.green : Colors.red, fontSize: serverStatusFontSize, fontWeight: FontWeight.w600),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              "SERVER STATUS - UNKNOWN",
              style: TextStyle(color: Colors.grey, fontSize: serverStatusFontSize, fontWeight: FontWeight.w600),
            ),
          );
        }
      },
    );
  }
}

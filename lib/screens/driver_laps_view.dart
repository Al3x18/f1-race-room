import 'package:flutter/material.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/model/driver_laps_model.dart';

class DriverLapsView extends StatefulWidget {
  const DriverLapsView({
    super.key,
    required this.driverName,
    required this.driverSurname,
    required this.seasonYear,
    required this.round,
    required this.driverId,
  });

  final String driverName;
  final String driverSurname;
  final String seasonYear;
  final String round;
  final String driverId;

  @override
  State<DriverLapsView> createState() => _DriverLapsViewState();
}

class _DriverLapsViewState extends State<DriverLapsView> {
  late Future<MRDataDriverLaps?> futureDriverLapsData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    futureDriverLapsData = ApiService().fetchDriverLaps(seasonYear: widget.seasonYear, round: widget.round, driverId: widget.driverId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.driverName,
              style: const TextStyle(fontSize: 18),
            ),
            const Text(" "),
            Text(
              widget.driverSurname,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: futureDriverLapsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          final driverLaps = snapshot.data!.raceTable.races[0].laps;

          return ListView.builder(
            itemCount: driverLaps.length,
            itemBuilder: (context, index) {
              final lapNumber = driverLaps[index].number;
              final lapTime = driverLaps[index].timings[0].time;
              final positionInLap = driverLaps[index].timings[0].position;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Column(
                  children: [
                    ListTile(
                      //leading: Text(lapNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      title: Text("Lap $lapNumber", style: const TextStyle(fontSize: 16)),
                      subtitle: Text("Position: $positionInLap", style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      trailing: Text(lapTime, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500)),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/model/f1/driver_laps_model.dart';
import 'package:race_room/utils/colors/app_colors.dart';

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
                color: AppColors.circularProgressIndicator,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.raceTable.races.isEmpty) {
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
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                  children: [
                    if (index == 0) const SizedBox(height: 5),
                    ListTile(
                      //leading: Text(lapNumber, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      dense: true,
                      minTileHeight: 1,
                      title: Text("LAP $lapNumber", style: const TextStyle(fontSize: 13.5)),
                      subtitle: Text("Position: $positionInLap", style: const TextStyle(fontSize: 10.5, color: AppColors.driverLapsPosition)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("LAP TIME", style: TextStyle(fontSize: 10.5, color: AppColors.driverLapsTime)),
                          Text(lapTime, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 0.1,
                      child: Divider(indent: 15.5, endIndent: 23.5, thickness: 0.5),
                    ),
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

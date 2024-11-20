import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:race_room/utils/convert_race_time.dart';
import 'package:race_room/model/race_schedule_model.dart';
import 'package:race_room/widgets/countdown_timer.dart';
import 'package:race_room/widgets/race_details.dart';

class RacesScheduleView extends StatefulWidget {
  const RacesScheduleView({
    super.key,
    required this.controller,
    required this.futureRaceScheduleData,
    required this.seasonYear,
    required this.onRefresh,
  });

  final ScrollController controller;
  final Future<MRDataRaceSchedule?> futureRaceScheduleData;
  final String seasonYear;
  final void Function() onRefresh;

  @override
  State<RacesScheduleView> createState() => _RacesScheduleViewState();
}

class _RacesScheduleViewState extends State<RacesScheduleView> {
  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    return FutureBuilder(
      future: widget.futureRaceScheduleData,
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

        final raceSchedule = snapshot.data!.raceTable.races;

        return RefreshIndicator.adaptive(
          onRefresh: () async {
            widget.onRefresh();
            return;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.8),
            child: ListView.builder(
              controller: widget.controller,
              itemCount: raceSchedule.length,
              itemBuilder: (context, index) {
                final String roundNumber = raceSchedule[index].round.toString();
                final String raceName = raceSchedule[index].raceName;
                final String raceDate = raceSchedule[index].date;
                final String raceHour = convertTimeToLocal(raceSchedule[index].date, raceSchedule[index].time);
                final String raceCircuitName = raceSchedule[index].circuit.circuitName;
                final String raceCircuitLocation = raceSchedule[index].circuit.location.locality;
                final String raceCircuitCountry = raceSchedule[index].circuit.location.country;
            
                final String qualifyingDate = raceSchedule[index].qualifying.date;
                final String qualifyingTime = raceSchedule[index].qualifying.time;
            
                final String fp1Date = raceSchedule[index].firstPractice.date;
                final String fp1Time = raceSchedule[index].firstPractice.time;
            
                final String fp2Date = raceSchedule[index].secondPractice?.date ?? "";
                final String? fp2Time = raceSchedule[index].secondPractice?.time;
            
                final String? fp3Date = raceSchedule[index].thirdPractice?.date;
                final String? fp3Time = raceSchedule[index].thirdPractice?.time;
            
                final String? sprintDate = raceSchedule[index].sprint?.date;
                final String? sprintTime = raceSchedule[index].sprint?.time;
            
                final String? sprintQualifyingDate = raceSchedule[index].sprintQualifying?.date;
                final String? sprintQualifyingTime = raceSchedule[index].sprintQualifying?.time;
            
                final DateTime raceDateTime = DateTime.parse('${raceSchedule[index].date} ${raceSchedule[index].time}');
            
                return InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    _showModalBottomSheet(
                      context,
                      raceDate: raceDate,
                      raceTime: raceHour,
                      qualifyingDate: qualifyingDate,
                      qualifyingTime: qualifyingTime,
                      fp1Date: fp1Date,
                      fp1Time: fp1Time,
                      fp2Date: fp2Date,
                      fp2Time: fp2Time ?? "",
                      fp3Date: fp3Date ?? "",
                      fp3Time: fp3Time ?? "",
                      sprintDate: sprintDate ?? "",
                      sprintTime: sprintTime ?? "",
                      sprintQualifyingDate: sprintQualifyingDate ?? "",
                      sprintQualifyingTime: sprintQualifyingTime ?? "",
                      raceCircuitName: raceCircuitName,
                      round: roundNumber,
                      seasonYear: widget.seasonYear,
                    );
                  },
                  child: Card(
                    elevation: 0.45,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Round $roundNumber - $raceHour",
                            style: listTileStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 11),
                          ),
                          CountdownTimer(raceDate: raceDateTime),
                          Row(
                            children: [
                              Text(
                                raceName,
                                style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14.3),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Visibility(
                                  visible: fp2Date.isEmpty,
                                  child: Text(
                                    "(Sprint)",
                                    style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 10.8, color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Circuit: $raceCircuitName',
                            style: listTileStyle.copyWith(color: Colors.grey, fontSize: 11.8),
                          ),
                          Text(
                            'Location: $raceCircuitLocation, $raceCircuitCountry',
                            style: listTileStyle.copyWith(color: Colors.grey, fontSize: 11.8),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            formatDate(raceDate, TYPE.date),
                            style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            formatDate(raceDate, TYPE.shortMonth),
                            style: listTileStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

void _showModalBottomSheet(
  BuildContext context, {
  required String raceDate,
  required String raceTime,
  required String qualifyingDate,
  required String qualifyingTime,
  required String fp1Date,
  required String fp1Time,
  required String fp2Date,
  required String fp2Time,
  required String fp3Date,
  required String fp3Time,
  required String sprintDate,
  required String sprintTime,
  required String sprintQualifyingDate,
  required String sprintQualifyingTime,
  required String raceCircuitName,
  required String seasonYear,
  required String round,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Get.isDarkMode ? const Color.fromARGB(255, 201, 45, 34) : Colors.red,
    isScrollControlled: true,
    showDragHandle: false,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.65,
        maxChildSize: 1,
        expand: false,
        builder: (context, scrollController) {
          return RaceDetailsView(
            scrollController: scrollController,
            raceDate: raceDate,
            raceTime: raceTime,
            qualifyingDate: qualifyingDate,
            qualifyingTime: qualifyingTime,
            fp1Date: fp1Date,
            fp1Time: fp1Time,
            fp2Date: fp2Date,
            fp2Time: fp2Time,
            fp3Date: fp3Date,
            fp3Time: fp3Time,
            sprintDate: sprintDate,
            sprintTime: sprintTime,
            sprintQualifyingDate: sprintQualifyingDate,
            sprintQualifyingTime: sprintQualifyingTime,
            trackName: raceCircuitName,
            seasonYear: seasonYear,
            raceRound: round,
            raceName: raceCircuitName,
          );
        },
      );
    },
  );
}

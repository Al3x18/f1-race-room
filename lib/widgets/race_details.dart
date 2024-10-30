import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:race_room/Utils/check_date.dart';
import 'package:race_room/Utils/convert_race_time.dart';
import 'package:race_room/Utils/get_track_image.dart';
import 'package:race_room/screens/race_results_view.dart';
import 'package:race_room/screens/track_map_view.dart';

class RaceDetailsView extends StatefulWidget {
  final ScrollController scrollController;

  const RaceDetailsView({
    super.key,
    required this.scrollController,
    required this.raceDate,
    required this.raceTime,
    required this.qualifyingDate,
    required this.qualifyingTime,
    required this.fp1Date,
    required this.fp1Time,
    required this.fp2Date,
    required this.fp2Time,
    required this.fp3Date,
    required this.fp3Time,
    required this.sprintDate,
    required this.sprintTime,
    required this.sprintQualifyingDate,
    required this.sprintQualifyingTime,
    required this.trackName,
    required this.seasonYear,
    required this.raceRound,
    required this.raceName,
  });

  final String raceDate;
  final String raceTime;
  final String qualifyingDate;
  final String qualifyingTime;
  final String fp1Date;
  final String fp1Time;
  final String fp2Date;
  final String fp2Time;
  final String fp3Date;
  final String fp3Time;
  final String sprintDate;
  final String sprintTime;
  final String sprintQualifyingDate;
  final String sprintQualifyingTime;
  final String trackName;
  final String seasonYear;
  final String raceRound;
  final String raceName;

  @override
  State<RaceDetailsView> createState() => _RaceDetailsViewState();
}

class _RaceDetailsViewState extends State<RaceDetailsView> {
  double _buttonOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                width: 110,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.fp2Date.isEmpty ? "Sprint Weekend" : "Standard Race Weekend",
                style: listTileStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            _buildRaceDetailSection("Race Schedule", widget.raceDate, widget.raceTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            _buildRaceDetailSection("Qualifying Session", widget.qualifyingDate, widget.qualifyingTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            _buildRaceDetailSection("FP1", widget.fp1Date, widget.fp1Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            if (widget.fp2Date.isNotEmpty) _buildRaceDetailSection("FP2", widget.fp2Date, widget.fp2Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            if (widget.sprintQualifyingDate.isNotEmpty)
              _buildRaceDetailSection("Sprint Race", widget.sprintDate, widget.sprintTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 12),
            if (widget.fp3Date.isNotEmpty) _buildRaceDetailSection("FP3", widget.fp3Date, widget.fp3Time, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            if (widget.sprintQualifyingDate.isNotEmpty)
              _buildRaceDetailSection("Sprint Qualifying", widget.sprintQualifyingDate, widget.sprintQualifyingTime, listTileStyle, widget.seasonYear, widget.raceRound, widget.raceName),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "Track Map",
                style: listTileStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Get.to(() => TrackMapView(trackName: widget.trackName)),
              child: Center(child: getTrackImage(widget.trackName)),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }

  Widget _buildRaceDetailSection(String title, String date, String time, TextStyle style, String seasonYear, String raceRound, String raceName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "DATE",
                style: style.copyWith(fontSize: 12.5),
              ),
              Text(
                "${getDayName(date)}, ${convertDateToLocal(date)}",
                style: style.copyWith(fontSize: 12.5),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "START",
                style: style.copyWith(fontSize: 13),
              ),
              Text(
                convertTimeToLocal(date, time),
                style: style.copyWith(fontSize: 13),
              ),
            ],
          ),
          if (title == "Race Schedule") const SizedBox(height: 6),
          Visibility(
            visible: title == "Race Schedule",
            child: InkWell(
              onTapDown: (_) {
                setState(() {
                  _buttonOpacity = 0.4;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _buttonOpacity = 1.0;
                });
              },
              onTap: () {
                if (isDatePast(date)) {
                  Get.to(
                    () => RaceResultsView(
                      seasonYear: seasonYear,
                      raceRound: raceRound,
                      raceName: raceName,
                    ),
                  );
                } else {
                  Get.closeAllSnackbars();
                  Get.snackbar(
                    "Results not available",
                    "Race not finished yet",
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    duration: const Duration(seconds: 2),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.white,
                    borderRadius: 6,
                  );
                }
              },
              child: Opacity(
                opacity: _buttonOpacity,
                child: Text(
                  "View Results",
                  style: style.copyWith(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

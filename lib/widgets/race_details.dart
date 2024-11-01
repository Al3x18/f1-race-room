import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:race_room/utils/convert_race_time.dart';
import 'package:race_room/utils/get_track_image.dart';
import 'package:race_room/screens/track_map_view.dart';

class RaceDetailsView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    return SingleChildScrollView(
      controller: scrollController,
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
                fp2Date.isEmpty ? "Sprint Weekend" : "Standard Race Weekend",
                style: listTileStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            _buildRaceDetailSection("Race Schedule", raceDate, raceTime, listTileStyle, seasonYear, raceRound, raceName),
            const SizedBox(height: 12),
            _buildRaceDetailSection("Qualifying Session", qualifyingDate, qualifyingTime, listTileStyle, seasonYear, raceRound, raceName),
            const SizedBox(height: 12),
            _buildRaceDetailSection("FP1", fp1Date, fp1Time, listTileStyle, seasonYear, raceRound, raceName),
            const SizedBox(height: 12),
            if (fp2Date.isNotEmpty) _buildRaceDetailSection("FP2", fp2Date, fp2Time, listTileStyle, seasonYear, raceRound, raceName),
            if (sprintQualifyingDate.isNotEmpty)
              _buildRaceDetailSection("Sprint Race", sprintDate, sprintTime, listTileStyle, seasonYear, raceRound, raceName),
            const SizedBox(height: 12),
            if (fp3Date.isNotEmpty) _buildRaceDetailSection("FP3", fp3Date, fp3Time, listTileStyle, seasonYear, raceRound, raceName),
            if (sprintQualifyingDate.isNotEmpty)
              _buildRaceDetailSection("Sprint Qualifying", sprintQualifyingDate, sprintQualifyingTime, listTileStyle, seasonYear, raceRound, raceName),
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
              onTap: () => Get.to(() => TrackMapView(trackName: trackName)),
              child: Center(child: getTrackImage(trackName)),
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
        color: Get.isDarkMode ? Colors.black : Colors.white,
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
          if (title == "Race Schedule") const SizedBox(height: 8),
          Visibility(
            visible: title == "Race Schedule",
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Get.isDarkMode ? Colors.white : Colors.red,
                    width: 1.15,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.5)),
                ),
                child: Text("View Results", style: style.copyWith(
                  fontWeight: FontWeight.w500, 
                  fontSize: 12.2, 
                    color: Get.isDarkMode ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:race_room/api/api_service.dart';
import 'package:race_room/utils/f1_teams_color.dart';
import 'package:race_room/model/constructor_standings_model.dart';

class TeamsSToRound extends StatefulWidget {
  const TeamsSToRound({
    super.key,
    required this.seasonYear,
    required this.round,
  });

  final String seasonYear;
  final String round;

  @override
  State<TeamsSToRound> createState() => _TeamsSToRoundState();
}

class _TeamsSToRoundState extends State<TeamsSToRound> {
  late Future<MRDataConstructorStandings?> futureConstructorStandingsData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    futureConstructorStandingsData = ApiService().fetchConstructorStandingsToRound(seasonYear: widget.seasonYear, round: widget.round);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Teams Standings", style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w600)),
            Text("After Round ${widget.round}", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
      body: FutureBuilder(
        future: futureConstructorStandingsData,
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

          final constructorStandings = snapshot.data!.standingsTable.standingsLists[0].constructorStandings;

          return RefreshIndicator.adaptive(
            onRefresh: () async {
              _getData();
              return;
            },
            child: ListView.builder(
              itemCount: constructorStandings.length,
              itemBuilder: (context, index) {
                //final String roundNumber = snapshot.data!.standingsTable.round.toString();
                final String constructorName = constructorStandings[index].constructor.name;
                final String constructorPoints = constructorStandings[index].points.toString();
                final String constructorWins = constructorStandings[index].wins.toString();
                final String constructorPosition = constructorStandings[index].position.toString();
                final String constructorNationality = constructorStandings[index].constructor.nationality;

                final String firstConstructorPoints = constructorStandings[0].points.toString();

                int safeParsePoints(String points) {
                  try {
                    return int.parse(points);
                  } catch (e) {
                    return 0;
                  }
                }

                return ListTile(
                  leading: SizedBox(
                    width: 46,
                    child: Text(
                      "#$constructorPosition",
                      style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 16.5),
                    ),
                  ),
                  title: Text(
                    constructorName,
                    style: listTileStyle.copyWith(fontWeight: FontWeight.bold, color: getTeamColor(constructorName)),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$constructorPoints pts.",
                        style: listTileStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: safeParsePoints(firstConstructorPoints) - safeParsePoints(constructorPoints) > 0,
                        child: Text(
                          "(-${safeParsePoints(firstConstructorPoints) - safeParsePoints(constructorPoints)})",
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        constructorNationality,
                        style: listTileStyle.copyWith(color: Colors.grey, fontSize: 12.5, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.028),
                      Visibility(
                        visible: constructorWins != "0",
                        child: Text(
                          "Wins: $constructorWins",
                          style: listTileStyle.copyWith(fontSize: 12.5, color: const Color.fromARGB(255, 222, 179, 5), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

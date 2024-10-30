import 'package:flutter/material.dart';
import 'package:race_room/Utils/f1_teams_color.dart';
import 'package:race_room/model/constructor_standings_model.dart';

class ConstructorStandingsView extends StatefulWidget {
  const ConstructorStandingsView({
    super.key,
    required this.futureConstructorStandingsData,
    required this.controller,
  });

  final Future<MRDataConstructorStandings?> futureConstructorStandingsData;
  final ScrollController controller;

  @override
  State<ConstructorStandingsView> createState() => _ConstructorStandingsViewState();
}

class _ConstructorStandingsViewState extends State<ConstructorStandingsView> {
  @override
  Widget build(BuildContext context) {
    const TextStyle listTileStyle = TextStyle(
      fontFamily: "Formula1",
      fontSize: 15,
    );

    return FutureBuilder(
      future: widget.futureConstructorStandingsData,
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

        return ListView.builder(
          controller: widget.controller,
          itemCount: constructorStandings.length,
          itemBuilder: (context, index) {
            final String roundNumber = snapshot.data!.standingsTable.round.toString();
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

            return Column(
              children: [
                if (index == 0) const SizedBox(height: 5),
                if (index == 0)
                  Text(
                    "Constructor Standings after Round $roundNumber",
                    style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                  ),
                ListTile(
                  leading: SizedBox(
                    width: 42,
                    child: Text(
                      "#$constructorPosition",
                      style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 17),
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
                ),
              ],
            );
          },
        );
      },
    );
  }
}

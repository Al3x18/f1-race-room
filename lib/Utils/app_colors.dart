import 'package:flutter/material.dart';

class AppColors {

  //MARK: General
  static const Color _greyShade600 = Color.fromARGB(255, 158, 158, 158);

  static const Color circularProgressIndicator = Colors.red;

  static const Color themeLightPrimary = Colors.white;
  static const Color scaffoldLightBackground = Colors.white;
  static const Color cardLight = Colors.white;

  static const Color themeDarkPrimary = Colors.black;
  static const Color scaffoldDarkBackground = Colors.black;
  static const Color cardDark = Colors.black;

  //MARK: RootView
  static const Color rootTabTextStyleFullLight = Colors.white;
  static const Color rootTabTextStyleFullDark = Colors.black;

  static const Color rootTabTextStyleShortLight = Colors.white;
  static const Color rootTabTextStyleShortDark = Colors.black;

  static const List<Color> rootAppBarGradientDark = [Colors.black, Colors.black];
  static const List<Color> rootAppBarGradientLight = [Colors.red, Colors.white];

  static const Color rootAppBarTitle = _greyShade600;

  static const Color rootBottomBarIcon = Colors.white;

  static const Color rootBottomBar = Colors.black;

  static const Color rootTabBarDark = Color.fromARGB(255, 241, 240, 240);
  static const Color rootTabBarLight = Colors.red;
  static const Color rootTabBarIndicatorDark = Colors.black;
  static const Color rootTabBarIndicatorLight = Colors.white;

  static const Color rootSeasonYearText = _greyShade600;
  static const Color rootSeasonYearTextIcon = _greyShade600;

  //MARK: ConstructorStandingsView
  static const Color constructorStandingsAfterRound = Colors.grey;
  static const Color constructorStandingsNationality = Colors.grey;
  static const Color constructorStandingsWins = Color.fromARGB(255, 222, 179, 5);

  //MARK: DriverLapsView
  static const Color driverLapsPosition = Colors.grey;
  static const Color driverLapsTime = Colors.grey;

  static const Color driverStandingsAfterRound = Colors.grey;
  static const Color driverStandingsTeam = Colors.grey;
  static const Color driverStandingsWins = Color.fromARGB(255, 222, 179, 5);

  //MARK: RaceResultsView
  static const Color raceResultsSnackBarTextDark = Colors.black;
  static const Color raceResultsSnackBarTextLight = Colors.white;

  static const Color raceResultsSnackBarBackgroundDark = Colors.white;
  static const Color raceResultsSnackBarBackgroundLight = Colors.black;

  static const Color raceResultsSnackBarTextButton = Colors.red;

  static const Color raceResultsFastestLap = Color.fromARGB(255, 127, 21, 146);

  static const Color raceResultsListTileIcon = Colors.grey;

  //MARK: RaceScheduleView
  static const Color raceScheduleRoundAndHours = Colors.grey;
  static const Color raceScheduleSprintText = Colors.red;
  static const Color raceScheduleCircuitName = Colors.grey;
  static const Color raceScheduleLocation = Colors.grey;

  static const Color raceScheduleBottomSheetBackgroundDark = Color.fromARGB(255, 201, 45, 34);
  static const Color raceScheduleBottomSheetBackgroundLight = Colors.red;

  //MARK: SelectYearView
  static const Color selectYearAppBarButton = Colors.red;
  static const Color selectYearDecorationColorYearSelected = Colors.red;
  static const Color selectYearDecorationColorYearNotSelected = Colors.transparent;

  static const Color selectYearTextYearSelected = Colors.white;
  static const Color selectYearTextYearNotSelectedDark = Colors.white;
  static const Color selectYearTextYearNotSelectedLight = Colors.black;

  static const Color selectedYearTrailingIcon = Colors.white;

  //MARK: SettingsView
  static const Color settingsDevName = Color.fromARGB(255, 189, 189, 189);
  static const Color settingsDevNameDecoration = Color.fromARGB(255, 189, 189, 189);

  static const Color settingsBuildNumber = Colors.grey;

  static const Color settingsReportSubtitle = Colors.grey;

  static const Color settingsExpansionTile = Colors.grey;

  static const Color settingsEnableShortTextSubtitle = Colors.grey;
  static const Color settingsSwitchActive = Colors.red;

  //MARK: TelemetryRequestView
  static const Color telemetryRequestAppBarBetaText = Colors.red;
  static const Color telemetryRequestTypeText = Colors.grey;

  static const Color telemetryRequestErrorAdvice = Colors.red;

  static const Color telemetryRequestElevatedButtonBackground = Color.fromARGB(255, 237, 63, 51);
  static const Color telemetryRequestElevatedButtonText = Colors.white;
  static const Color telemetryRequestElevatedButtonTextSubtitle = Color.fromARGB(255, 202, 202, 202);

  static const Color telemetryRequestSnackBarBackgroundDark = Colors.white;
  static const Color telemetryRequestSnackBarBackgroundLight = Colors.black87;

  static const Color telemetryRequestServerStatusUnreachableText = Colors.red;
  static const Color telemetryRequestServerStatusOnlineText = Colors.green;
  static const Color telemetryRequestServerStatusUnknownText = Colors.grey;
  static const Color telemetryRequestServerStatusGeneralErrorText = Colors.red;

  //MARK: TelemetryView
  static const Color telemetryCausesText = Colors.grey;
  static const Color telemetryErrorIcon = Colors.red;
  static const Color telemetryErrorText = Colors.red;

  static const Color telemetryBackgroundDark = Colors.black;
  static const Color telemetryBackgroundLight = Colors.white;

  //MARK: CountdownTimer
  static const Color countdownTimerRaceEnded = Colors.green;
  static const Color countdownTimerRaceOngoing = Colors.red;

  static const Color countdownLightsOutText = Colors.grey;

  static const Color countdownTimerText = Color.fromARGB(255, 79, 70, 255);

  //MARK: NoDataAvailable
  static const Color noDataAvailableIcon = Colors.grey;
  static const Color noDataAvailableText = Colors.grey;

  //MARK: PositionContainer
  static const Color positionContainerTSPositionOne = Color.fromARGB(255, 49, 56, 255);
  static const Color positionContainerTSPositionNotOne = Colors.transparent;

  static const Color positionOneTSText = Colors.white;
  static const Color positionNotOneTSText = Color.fromARGB(255, 106, 106, 106);

  static const Color positionContainerDSNotFirstThree = Colors.transparent;

  static const Color positionContainerDSFirstThreeTextDark = Colors.black;
  static const Color positionContainerDSFirstThreeTextLight = Colors.white;

  static const Color positionContainerDSNotFirstThreeText = Color.fromARGB(255, 74, 74, 74);

  //MARK: RaceDetailsView
  static const Color raceDetailsScrollIndicatorTop = Colors.white;
  static const Color raceDetailsTitleText = Colors.white;

  static const Color raceDetailsDivider = Colors.white;

  static const Color raceDetailsTrackMapText = Colors.white;

  static const Color raceDetailsWeatherText = Colors.white;
  static const Color raceDetailsWeatherTextSubtitle = Colors.white;

  static const Color raceDetailsSessionContainerDecorationDark = Colors.black;
  static const Color raceDetailsSessionContainerDecorationLight = Colors.white;

  static const Color raceDetailsSessionContainerTitleText = Colors.grey;

  static const Color raceDetailsSessionResultsSnackTextDark = Colors.black;
  static const Color raceDetailsSessionResultsSnackTextLight = Colors.white;
  static const Color raceDetailsSessionResultsSnackBackgroundDark = Colors.white;
  static const Color raceDetailsSessionResultsSnackBackgroundLight = Color.fromARGB(255, 30, 30, 30);

  static const Color raceDetailsSessionResultsOutlineButtonBordersDark = Colors.white;
  static const Color raceDetailsSessionResultsOutlineButtonBordersLight = Colors.red;
  static const Color raceDetailsSessionResultsOutlineButtonTextDark = Colors.white;
  static const Color raceDetailsSessionResultsOutlineButtonTextLight = Colors.red;
}

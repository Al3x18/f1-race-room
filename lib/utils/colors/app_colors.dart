import 'package:flutter/material.dart';

class AppColors {
  //MARK: General - Palette Base
  // Colori primari
  static const Color primary = Color(0xFF1A56DB); // Blu più scuro e profondo
  static const Color secondary = Color(0xFF2563EB); // Blu medio intenso
  static const Color accent = Color(0xFFD97706); // Arancione più scuro

  // Colori neutri
  static const Color neutral900 = Color(0xFF0F172A); // Blu scurissimo
  static const Color neutral800 = Color(0xFF1E293B); // Blu molto scuro
  static const Color neutral700 = Color(0xFF334155); // Grigio blu scuro
  static const Color neutral600 = Color(0xFF64748B); // Grigio medio
  static const Color neutral200 = Color(0xFFE2E8F0); // Grigio chiaro
  static const Color neutral100 = Color(0xFFF8FAFC); // Bianco sporco

  // Colori di stato
  static const Color success = Color(0xFF059669); // Verde più scuro
  static const Color warning = Color(0xFFD97706); // Arancione più intenso
  static const Color error = Color(0xFFDC2626); // Rosso più intenso

  // Colori di sistema
  static const Color circularProgressIndicator = primary;
  static const Color dropDownMenuBackgroundLight = neutral100;
  static const Color dropDownMenuBackgroundDark = Color.fromARGB(255, 40, 50, 80);

  // Tema chiaro
  static const Color themeLightPrimary = primary;
  static const Color scaffoldLightBackground = neutral100;
  static const Color cardLight = Colors.white;

  // Tema scuro
  static const Color themeDarkPrimary = primary;
  static const Color scaffoldDarkBackground = neutral900;
  static const Color cardDark = Color.fromARGB(255, 51, 48, 70);

  //MARK: RootView
  static const List<Color> rootAppBarGradientDark = [
    neutral900,
    neutral800,
  ];
  static const List<Color> rootAppBarGradientLight = [
    primary,
    Color.fromARGB(255, 110, 156, 255),
  ];

  static const Color rootTabBarDark = neutral800;
  static const Color rootTabBarLight = Color.fromARGB(255, 42, 103, 255);
  static const Color rootTabBarIndicatorDark = primary;
  static const Color rootTabBarIndicatorLight = Colors.white;
  static const Color rootBottomBar = neutral900;

  static const Color rootTabTextStyleFullLight = Colors.white;
  static const Color rootTabTextStyleFullDark = Colors.white;
  static const Color rootTabTextStyleShortLight = Colors.white;
  static const Color rootTabTextStyleShortDark = Colors.white;

  static const Color rootAppBarTitle = Colors.white;
  static const Color rootBottomBarIcon = Colors.white;
  static const Color rootSeasonYearText = Colors.white;
  static const Color rootSeasonYearTextIcon = Colors.white;

  //MARK: Race Schedule
  static const Color raceScheduleRoundAndHours = neutral600;
  static const Color raceScheduleSprintText = primary;
  static const Color raceScheduleSprintTextDark = Color.fromARGB(255, 49, 114, 254);
  static const Color raceScheduleCircuitName = neutral600;
  static const Color raceScheduleLocation = neutral600;
  static const Color raceScheduleBottomSheetBackgroundDark = Color.fromARGB(255, 49, 62, 86);
  static const Color raceScheduleBottomSheetBackgroundLight = primary;

  //MARK: Standings
  static const Color constructorStandingsWins = primary;
  static const Color driverStandingsWins = primary;
  static const Color constructorStandingsAfterRound = neutral600;
  static const Color constructorStandingsNationality = neutral600;
  static const Color driverStandingsAfterRound = neutral600;
  static const Color driverStandingsTeam = neutral600;

  //MARK: Driver Laps
  static const Color driverLapsPosition = neutral600;
  static const Color driverLapsTime = neutral600;

  //MARK: Settings
  static const Color settingsSwitchActive = primary;
  static const Color settingsDevName = neutral600;
  static const Color settingsDevNameDecoration = neutral600;
  static const Color settingsExpansionTile = neutral600;
  static const Color settingsBuildNumber = neutral600;
  static const Color settingsReportSubtitle = neutral600;
  static const Color settingsEnableShortTextSubtitle = neutral600;
  static const List<Color> settingsAppBarLight = [Colors.white, Colors.white];

  //MARK: Telemetry
  static const Color telemetryRequestAppBarBetaText = error;
  static const Color telemetryRequestTypeText = neutral600;
  static const Color telemetryRequestElevatedButtonBackground = primary;
  static const Color telemetryRequestElevatedButtonText = Colors.white;
  static const Color telemetryRequestElevatedButtonTextSubtitle = neutral200;
  static const Color telemetryRequestServerStatusOnlineText = success;
  static const Color telemetryRequestServerStatusUnreachableText = Colors.grey;
  static const Color telemetryRequestServerStatusUnknownText = neutral600;
  static const Color telemetryRequestServerStatusGeneralErrorText = error;
  static const Color telemetryRequestErrorAdvice = error;
  static const Color telemetryBackgroundDark = neutral900;
  static const Color telemetryBackgroundLight = Colors.white;
  static const Color telemetryCausesText = neutral600;
  static const Color telemetryErrorIcon = error;
  static const Color telemetryErrorText = error;
  static const Color telemetryRequestSnackBarBackgroundDark = neutral800;
  static const Color telemetryRequestSnackBarBackgroundLight = primary;

  //MARK: Race Results
  static const Color raceResultsFastestLap = primary;
  static const Color raceResultsSnackBarBackgroundDark = neutral800;
  static const Color raceResultsSnackBarBackgroundLight = primary;
  static const Color raceResultsSnackBarTextDark = Colors.black;
  static const Color raceResultsSnackBarTextLight = Colors.white;
  static const Color raceResultsSnackBarTextButton = error;
  static const Color raceResultsListTileIcon = neutral600;

  //MARK: Select Year
  static const Color selectYearAppBarButton = primary;
  static const Color selectYearDecorationColorYearSelected = primary;
  static const Color selectYearDecorationColorYearNotSelected = Colors.transparent;
  static const Color selectYearTextYearSelected = Colors.white;
  static const Color selectYearTextYearNotSelectedDark = Colors.white;
  static const Color selectYearTextYearNotSelectedLight = Colors.black;
  static const Color selectedYearTrailingIcon = Colors.white;

  //MARK: Position Container
  static const Color positionContainerTSPositionOne = primary;
  static const Color positionContainerTSPositionNotOne = Colors.transparent;
  static const Color positionOneTSText = Colors.white;
  static const Color positionNotOneTSText = neutral600;
  static const Color positionContainerDSNotFirstThree = Colors.transparent;
  static const Color positionContainerDSFirstThreeTextDark = Colors.black;
  static const Color positionContainerDSFirstThreeTextLight = Colors.white;
  static const Color positionContainerDSNotFirstThreeText = neutral600;

  //MARK: Race Details
  static const Color raceDetailsScrollIndicatorTop = Colors.white;
  static const Color raceDetailsTitleText = Colors.white;
  static const Color raceDetailsDivider = Colors.white;
  static const Color raceDetailsTrackMapText = Colors.white;
  static const Color raceDetailsWeatherText = Colors.white;
  static const Color raceDetailsWeatherTextSubtitle = Colors.white;
  static const Color raceDetailsSessionContainerDecorationDark = Colors.black87;
  static const Color raceDetailsSessionContainerDecorationLight = Colors.white;
  static const Color raceDetailsSessionContainerTitleText = neutral600;
  static const Color raceDetailsSessionResultsSnackTextDark = Color.fromARGB(255, 226, 226, 226);
  static const Color raceDetailsSessionResultsSnackTextLight = Colors.white;
  static const Color raceDetailsSessionResultsSnackBackgroundDark = neutral800;
  static const Color raceDetailsSessionResultsSnackBackgroundLight = primary;
  static const Color raceDetailsSessionResultsOutlineButtonBordersDark = Colors.white;
  static const Color raceDetailsSessionResultsOutlineButtonBordersLight = primary;
  static const Color raceDetailsSessionResultsOutlineButtonTextDark = Colors.white;
  static const Color raceDetailsSessionResultsOutlineButtonTextLight = primary;

  //MARK: Countdown
  static const Color countdownTimerRaceEnded = success;
  static const Color countdownTimerRaceOngoing = error;
  static const Color countdownTimerText = primary;
  static const Color countdownTimerTextDark = Color.fromARGB(255, 49, 114, 254);
  static const Color countdownLightsOutText = neutral600;

  //MARK: No Data Available
  static const Color noDataAvailableIcon = neutral600;
  static const Color noDataAvailableText = neutral600;

  //MARK: MoreView
  static const Color moreViewSubtitle = Color.fromARGB(255, 158, 158, 158);

  //MARK: NewsView
  static const Color newsViewSubtitle = Color.fromARGB(255, 158, 158, 158);
  static const List<Color> newsViewAppBarLight = [Colors.white, Colors.white];
  static const Color newsPopMenuBackgroundLight = dropDownMenuBackgroundLight;
  static const Color newsPopMenuBackgroundDark = dropDownMenuBackgroundDark;
}

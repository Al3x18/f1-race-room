bool isDatePast(String dateStr) {
  // Parsing the input date
  final parts = dateStr.split('-');
  if (parts.length != 3) {
    throw const FormatException("Date must be yyyy-mm-dd");
  }

  final int day = int.parse(parts[2]);
  final int month = int.parse(parts[1]);
  final int year = int.parse(parts[0]);

  // Creating a DateTime object from the parsed values
  final DateTime inputDate = DateTime(year, month, day);
  final DateTime currentDate = DateTime.now();

  // Check if the input date is at least one day in the past
  bool isPast = inputDate.isBefore(currentDate.subtract(const Duration(days: 1)));

  return isPast;
}

bool isAllSessionExceptRaceDatesEmpty(String fp1Date, String fp2Date, String fp3Date, String sprintQualifyingDate, String sprintDate, String qualifyingDate) {
  return fp1Date == "No Data" && fp2Date == "No Data" && fp3Date == "No Data" && sprintQualifyingDate == "No Data" && sprintDate == "No Data" && qualifyingDate == "No Data";
}
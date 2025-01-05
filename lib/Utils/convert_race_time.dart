import 'package:intl/intl.dart';

String convertDateToLocal(String raceDate) {
  if (raceDate == "No Data") {
    return "No Data";
  }
  
  DateTime date = DateTime.parse(raceDate).toLocal();
  return DateFormat("dd-MM-yyyy").format(date);
}

String getDayName(String date) {
  if (date == "No Data") {
    return "No Data";
  }
  
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('EEEE', 'en_US').format(dateTime);
}

String convertTimeToLocal(String raceDate, String raceHour) {
  if (raceDate == "No Data" || raceHour == "No Data") {
    return "No Data";
  }


  DateTime date = DateTime.parse(raceDate);

  DateTime time;
  try {
    time = DateTime.parse("1970-01-01T$raceHour").toUtc();
  } catch (e) {
    return "No Data";
  }

  DateTime combinedDateTime = DateTime(date.year, date.month, date.day,
      time.hour, time.minute, time.second);

  bool isSummerTime = _isSummerTime(date.year, combinedDateTime);

  final romeTime = combinedDateTime.add(Duration(hours: isSummerTime ? 2 : 1));

  return DateFormat("HH:mm").format(romeTime);
}

bool _isSummerTime(int year, DateTime dateTime) {
  DateTime lastMarch = DateTime(year, 3, 31);
  while (lastMarch.weekday != DateTime.sunday) {
    lastMarch = lastMarch.subtract(const Duration(days: 1));
  }


  DateTime lastOctober = DateTime(year, 10, 31);
  while (lastOctober.weekday != DateTime.sunday) {
    lastOctober = lastOctober.subtract(const Duration(days: 1));
  }

  if (dateTime.isBefore(lastMarch) || dateTime.isAfter(lastOctober)) {
    return false; // Non è ora legale
  }
  
  if (dateTime.isAfter(lastMarch) && dateTime.isBefore(lastOctober)) {
    return true; // È ora legale
  }

  if (dateTime.year == lastOctober.year &&
      dateTime.day == lastOctober.day) {
    return dateTime.hour < 3;
  }

  return false;
}

enum TYPE { date, shortDay, shortMonth, month }

String formatDate(String date, TYPE type) {
  if (date == "No Data") {
    return "No Data";
  }
  
  DateTime dateTime = DateTime.parse(date);

  switch (type) {
    case TYPE.date:
      return DateFormat('d').format(dateTime);
    case TYPE.shortDay:
      return DateFormat('EEE', 'en_US').format(dateTime).toUpperCase();
    case TYPE.shortMonth:
      return DateFormat('MMM', 'en_US').format(dateTime).toUpperCase();
    case TYPE.month:
      return DateFormat('MMMM', 'en_US').format(dateTime);
    }
}
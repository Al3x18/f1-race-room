import 'package:intl/intl.dart';

String convertDateToLocal(String raceDate) {
  if (raceDate == "No Data") {
    return "No Data"; // Restituisci un valore di default
  }
  
  DateTime date = DateTime.parse(raceDate).toLocal();
  return DateFormat("dd-MM-yyyy").format(date);
}

String getDayName(String date) {
  if (date == "No Data") {
    return "No Data"; // Restituisci un valore di default
  }
  
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('EEEE', 'en_US').format(dateTime);
}

String convertTimeToLocal(String raceDate, String raceHour) {
  // Gestisci la data non valida
  if (raceDate == "No Data" || raceHour == "No Data") {
    return "No Data"; // Restituisci un valore di default
  }

  // Converte la data in un oggetto DateTime
  DateTime date = DateTime.parse(raceDate);

  // Controlla se raceHour è valido
  DateTime time;
  try {
    time = DateTime.parse("1970-01-01T$raceHour").toUtc();
  } catch (e) {
    return "No Data"; // Se non riesci a parse, restituisci un valore di default
  }

  // Combina la data e l'orario
  DateTime combinedDateTime = DateTime(date.year, date.month, date.day,
      time.hour, time.minute, time.second);

  // Determina se la data è durante l'ora legale
  bool isSummerTime = _isSummerTime(date.year, combinedDateTime);

  // Aggiunge l'offset appropriato per Roma
  final romeTime = combinedDateTime.add(Duration(hours: isSummerTime ? 2 : 1));

  // Ritorna solo l'ora formattata in `HH:mm`
  return DateFormat("HH:mm").format(romeTime);
}

/// Funzione per determinare se una data è nell'ora legale in Italia
bool _isSummerTime(int year, DateTime dateTime) {
  // Determina l'ultima domenica di marzo
  DateTime lastMarch = DateTime(year, 3, 31);
  while (lastMarch.weekday != DateTime.sunday) {
    lastMarch = lastMarch.subtract(const Duration(days: 1));
  }

  // Determina l'ultima domenica di ottobre
  DateTime lastOctober = DateTime(year, 10, 31);
  while (lastOctober.weekday != DateTime.sunday) {
    lastOctober = lastOctober.subtract(const Duration(days: 1));
  }

  // Controlla se la data è compresa tra l'ultima domenica di marzo e l'ultima domenica di ottobre
  if (dateTime.isBefore(lastMarch) || dateTime.isAfter(lastOctober)) {
    return false; // Non è ora legale
  }
  
  // Se è compresa tra l'ultima domenica di marzo e l'ultima domenica di ottobre
  // Verifichiamo se è prima o dopo la data di cambio
  if (dateTime.isAfter(lastMarch) && dateTime.isBefore(lastOctober)) {
    return true; // È ora legale
  }

  // Se è esattamente l'ultima domenica di ottobre, controlla l'ora
  if (dateTime.year == lastOctober.year &&
      dateTime.day == lastOctober.day) {
    return dateTime.hour < 3; // L'ora legale termina alle 3:00 di quella notte
  }

  return false;
}

enum TYPE { date, shortDay, shortMonth, month }

String formatDate(String date, TYPE type) {
  if (date == "No Data") {
    return "No Data"; // Restituisci un valore di default
  }
  
  DateTime dateTime = DateTime.parse(date); // Converti la stringa della data in DateTime

  switch (type) {
    case TYPE.date:
      return DateFormat('d').format(dateTime); // Restituisce solo il giorno (es. 23)
    case TYPE.shortDay:
      return DateFormat('EEE', 'en_US').format(dateTime).toUpperCase(); // Restituisce il giorno abbreviato (es. sun)
    case TYPE.shortMonth:
      return DateFormat('MMM', 'en_US').format(dateTime).toUpperCase(); // Restituisce il mese abbreviato (es. nov)
    case TYPE.month:
      return DateFormat('MMMM', 'en_US').format(dateTime); // Restituisce il mese completo (es. November)
    default:
      return ''; // Caso di default
  }
}
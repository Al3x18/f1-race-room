import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<File> savePdfLocally(Uint8List pdfBytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/temp.pdf';
  final file = File(filePath);
  return await file.writeAsBytes(pdfBytes);
}
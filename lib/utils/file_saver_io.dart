import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<void> saveFileImpl(String filename, Uint8List bytes) async {
  Directory? directory;
  if (Platform.isAndroid) {
    directory = Directory('/storage/emulated/0/Download');
    if (!await directory.exists()) {
      directory = await getExternalStorageDirectory();
    }
  } else if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    directory = await getDownloadsDirectory();
  }

  if (directory != null) {
    final file = File('${directory.path}/$filename');
    await file.writeAsBytes(bytes);
  } else {
    throw Exception('Could not find a directory to save the file.');
  }
}

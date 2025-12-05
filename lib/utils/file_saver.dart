import 'dart:typed_data';

import 'file_saver_io.dart' if (dart.library.html) 'file_saver_web.dart';

class FileSaver {
  static Future<void> saveFile(String filename, Uint8List bytes) async {
    await saveFileImpl(filename, bytes);
  }
}

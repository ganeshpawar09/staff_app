import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'dart:io';

class PDFApi {

  static Future<File?> loadNetwork(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;

      return _storeFile(url, bytes);
    } catch (e) {
      print('Error loading network: $e');
      return null;
    }
  }

  static Future<File?> _storeFile(String url, List<int> bytes) async {
    try {
      final filename = basename(url);
      final dir = await getApplicationDocumentsDirectory();

      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      print('Error storing file: $e');
      return null;
    }
  }
}

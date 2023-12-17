import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;

abstract class DownloadService {
  Future<void> download({String url,String filetype, String filename});
}

class WebDownloadService implements DownloadService {
  @override
  Future<void> download({String? url,String? filetype, String? filename}) async {
    html.window.open(url!, "_blank");
  }
}

class MobileDownloadService implements DownloadService {
  @override
  Future<void> download({String? url,String? filetype ,String? filename}) async {
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();

    // You should put the name you want for the file here.
    // Take in account the extension.
    // String fileName = 'myFile';
    await dio.download(url!, "${dir.path}/$filename");
    // OpenFile.open("${dir.path}/$filename", type: 'application/$filetype');
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }
}
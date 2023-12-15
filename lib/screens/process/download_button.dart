import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DownloadButton extends StatelessWidget {
  const DownloadButton({Key? key, required this.url,required this.filetype,required this.filename, required this.buttonname}) : super(key: key);

  final String url;
  final String filetype;
  final String filename;
  final String buttonname;

Future<void> downloadFile(String fileUrl) async {
  final response = await http.get(Uri.parse(fileUrl));

  if (response.statusCode == 200) {
    // Handle the downloaded file as needed.
    // You can save it to the device or display it, depending on your requirements.
  } else {
    throw Exception('Failed to download file');
  }
}

  Future<void> _downloadFile() async {
    downloadFile('http://192.168.0.116:8000/media/ErpProcess/Part/Lower_plate_genrato_v1.dxf');
    // DownloadService downloadService =
    //     kIsWeb ? WebDownloadService() : MobileDownloadService();
    // await downloadService.download(url: url,filetype:filetype,filename:filename);
    // print('here');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _downloadFile,
      icon: const Icon(Icons.download),
      label: Text("$buttonname"),
    );
  }
}
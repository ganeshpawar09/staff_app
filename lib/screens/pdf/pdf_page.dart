import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class PDFViewerPage extends StatelessWidget {
  final File file;

  const PDFViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Prevent screenshots for this screen
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

    return Scaffold(
      appBar: AppBar(),
      body: PDFView(
        filePath: file.path,
        autoSpacing: false,
        swipeHorizontal: true,
        pageSnap: false,
        pageFling: false,
      ),
    );
  }
}

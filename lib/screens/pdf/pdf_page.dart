import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatelessWidget {
  final File file;
  const PDFViewerPage({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
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

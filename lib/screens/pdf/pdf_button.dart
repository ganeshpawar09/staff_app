import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/screens/pdf/pdf_api.dart';
import 'package:staff_flutter_app/screens/pdf/pdf_page.dart';
import 'package:connectivity/connectivity.dart';

class PDFButton extends StatefulWidget {
  final String url;
  const PDFButton({Key? key, required this.url}) : super(key: key);

  @override
  State<PDFButton> createState() => _PDFButtonState();
}

class _PDFButtonState extends State<PDFButton> {
  bool _loading = false;
  bool _error = false;

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void fetchData(BuildContext context) async {
    try {
      print('Before fetching PDF data');

      bool isConnected = await checkInternetConnectivity();

      if (!isConnected) {
        print('Internet not available');
        return;
      }

      setState(() {
        _loading = true;
      });

      final file = await PDFApi.loadNetwork(widget.url);

      if (file != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFViewerPage(file: file),
          ),
        );
      } else {
        print('Error loading PDF file');
        setState(() {
          _error = true;
        });
      }

      print('After fetching PDF data');
    } catch (error) {
      print('Error fetching PDF data: $error');
      setState(() {
        _error = true;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void onPressedCallback(BuildContext context) async {
    bool isConnected = await checkInternetConnectivity();

    if (!isConnected) {
      print('Internet not available');
      return;
    }

    fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressedCallback(context);
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: _loading
          ? const SizedBox(
              width: 80,
              child: Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          : SizedBox(
              width: 80,
              child: Text(
                "View PDF",
                textAlign: TextAlign.center,
                style: AppStyles.mondaB
                    .copyWith(fontSize: 16, color: Colors.black),
              ),
            ),
    );
  }
}

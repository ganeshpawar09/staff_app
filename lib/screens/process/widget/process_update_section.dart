import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/state/order_process_state.dart';

class ProcessUpdateSection extends StatefulWidget {
  final OrderProcess orderProcess;
  const ProcessUpdateSection({Key? key, required this.orderProcess})
      : super(key: key);

  @override
  State<ProcessUpdateSection> createState() => _ProcessUpdateSectionState();
}

class _ProcessUpdateSectionState extends State<ProcessUpdateSection> {
  final costController = TextEditingController();
  final completedBoolController = TextEditingController();
  String barcodeScanRes = '';

  Future scanBarcode(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );
    setState(() {
      completedBoolController.text = barcodeScanRes;
      this.barcodeScanRes = barcodeScanRes;
      print("barcode text");
      print(this.barcodeScanRes);
    });
  }

  void onAdd() async {
    final String cost = costController.text;
    final String barcodeLink = completedBoolController.text;
    final String processId = widget.orderProcess.processId!;

    print("barcode value is");
    print(barcodeLink);
    if (cost.isNotEmpty && barcodeLink.isNotEmpty) {
      await Provider.of<OrderProcessState>(context, listen: false)
          .updateProcessStatus(processId, double.parse(cost), barcodeLink);
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 3,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/money.png",
                    width: 35,
                    height: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      style: AppStyles.mondaN,
                      controller: costController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                        labelStyle: AppStyles.mondaN.copyWith(fontSize: 18),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: "Enter Cost",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    child: Image.asset(
                      "assets/barcode_scan.png",
                      width: 35,
                      height: 35,
                    ),
                    onTap: () {
                      setState(
                        () {
                          scanBarcode(context);
                          completedBoolController.text = barcodeScanRes;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      style: AppStyles.mondaN,
                      controller: completedBoolController,
                      decoration: InputDecoration(
                        labelText: "Scan Barcode",
                        labelStyle: AppStyles.mondaN.copyWith(fontSize: 18),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  onAdd();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Completed",
                    textAlign: TextAlign.center,
                    style: AppStyles.mondaB
                        .copyWith(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
// import 'package:staff_flutter_app/screens/staff_pending_process.dart';
// import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:staff_flutter_app/state/process_state.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/widgets/add_drawer.dart';
import 'package:staff_flutter_app/screens/process/download_button.dart';
import 'package:staff_flutter_app/server_url.dart';

class ProcessUpdateScreen extends StatefulWidget {
  final int id;
  const ProcessUpdateScreen({super.key, required this.id});

  @override
  _ProcessUpdateScreen createState() => _ProcessUpdateScreen();
}

class _ProcessUpdateScreen extends State<ProcessUpdateScreen> {
  final costController = TextEditingController();
  final barcodeController = TextEditingController();
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

  void onAdd() {
    final String val1 = costController.text;
    final String val2 = completedBoolController.text;

    print("barcode value is");
    print(val2);
    if (val1.isNotEmpty && val2.isNotEmpty) {
      Provider.of<ProcessState>(context, listen: false)
          .updateprocessstatus(widget.id, int.parse(val1), val2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final process = Provider.of<ProcessState>(context).singleProcess(widget.id);
    final orderitem =
        Provider.of<OrderitemState>(context).getorderitembyprocess(process);
    String processid = process.processId!;
    double processcost = process.cost!;
    double processcosttax = processcost * 0.12;
    double processcosttotal = processcost * 1.12;
    String processname = process.processName!;

    var path = process.processDrawing;
    var split = path!.split('.');
    var splitname = path.split('/');
    String filename = splitname.last;
    String filetype = split.last;

    return Scaffold(
        appBar: AppBar(
          title: Text("Process Detail View"),
          backgroundColor: Color(0xff101522),
          actions: [],
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 5, bottom: 5),
                  child: Text(
                    "Process Details:",
                    style: AppStyles.mondaB.copyWith(fontSize: 16)
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Column(
                            children: <Widget>[
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.top,
                                children: [
                                  TableRow(children: [
                                    Text(
                                      "Process ID:",
                                      style: AppStyles.mondaB.copyWith(fontSize: 12)
                                    ),
                                    Text(
                                      "$processid",
                                      style: AppStyles.mondaB.copyWith(fontSize: 12)
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Process Name:",
                                        style:AppStyles.mondaB.copyWith(fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "$processname",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12),
                                      ),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Status:",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Completed",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Process Drawing:",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12),
                                      ),
                                    ),
                                    DownloadButton(
                                        url:
                                            '$serversite/api/process_drawing_download/${process.id}/',
                                        filetype: filetype,
                                        filename: filename,
                                        buttonname: 'filename'),
                                  ]),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 5, bottom: 5),
                  child: Text(
                    "Parts Details",
                    style: AppStyles.mondaB.copyWith(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: <Widget>[
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.top,
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Part ID:",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "${orderitem.document.partId}",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12),
                                      ),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Part Name:",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "${orderitem.document.description}",
                                        style:AppStyles.mondaB.copyWith(fontSize: 12),
                                      ),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Dimension:",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "${orderitem.document.dimensionX} x ${orderitem.document.dimensionY} x ${orderitem.document.dimensionZ} mm",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Material:",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "${orderitem.materialDetail.materialName}",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Comments:",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        "NA",
                                        style: AppStyles.mondaB.copyWith(fontSize: 12)
                                      ),
                                    )
                                  ]),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 5, bottom: 5),
                  child: Text(
                    "Billing Details:",
                    style: AppStyles.mondaB.copyWith(fontSize: 16)
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "TOTAL COST",
                                    style: AppStyles.mondaB.copyWith(fontSize: 12),
                                  ),
                                  Text(
                                    "${processcost.toStringAsFixed(2)}",
                                    style:AppStyles.mondaB.copyWith(fontSize: 12)
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "GST(12%)",
                                    style: AppStyles.mondaB.copyWith(fontSize: 12),
                                  ),
                                  Text(
                                    "${processcosttax.toStringAsFixed(2)}",
                                    style: AppStyles.mondaB.copyWith(fontSize: 12)
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "TOTAL",
                                    style: AppStyles.mondaB.copyWith(fontSize: 12)
                                  ),
                                  Text(
                                    "\u{20B9} ${processcosttotal.toStringAsFixed(2)}",
                                    style: AppStyles.mondaB.copyWith(fontSize: 12)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          controller: costController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: InputDecoration(
                            labelText: "Enter Cost",
                            prefixIcon: IconButton(
                              icon: Icon(Icons.money),
                              onPressed: () => {},
                            ),
                          ),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          controller: completedBoolController,
                          decoration: InputDecoration(
                            labelText: "Scan Barcode",
                            prefixIcon: IconButton(
                              icon: Icon(Icons.scanner_outlined),
                              onPressed: () {
                                setState(() {
                                  scanBarcode(context);
                                  completedBoolController.text = barcodeScanRes;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                              child: Text('Completed'),
                              onPressed: () {
                                onAdd();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             PendingOrderProcessScreen()));
                              }),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}

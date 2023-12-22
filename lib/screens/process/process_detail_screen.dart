import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:staff_flutter_app/barcode_scan/widgets/product_search.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_item_detail_screen.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:staff_flutter_app/state/process_state.dart';
import 'package:provider/provider.dart';

class ProcessDetailScreen extends StatefulWidget {
  final OrderProcess orderProcess;
  const ProcessDetailScreen({Key? key, required this.orderProcess})
      : super(key: key);

  @override
  State<ProcessDetailScreen> createState() => _ProcessDetailScreenState();
}

class _ProcessDetailScreenState extends State<ProcessDetailScreen> {
  final costController = TextEditingController();
  final completedBoolController = TextEditingController();
  String barcodeScanRes = '';
  late ErpOrderItem orderitem;

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
      Provider.of<ProcessState>(context, listen: false).updateProcessStatus(
          int.parse(widget.orderProcess.processId!), int.parse(val1), val2);
    }
  }

  Future<void> fetchData(BuildContext context) async {
    try {
      print('Before fetching data');

      await context
          .read<OrderItemState>()
          .getErpOrderItemByProcess(widget.orderProcess);

      print('After fetching data');
    } catch (error) {
      print('Error fetching data: $error');
    }
    orderitem = context.read<OrderItemState>().erpOrderItemByProcess;
  }

  @override
  Widget build(BuildContext context) {
    OrderProcess process = widget.orderProcess;

    String processid = process.processId!;
    double processcost = process.cost!;
    double processcosttax = processcost * 0.12;
    double processcosttotal = processcost * 1.12;
    String processname = process.processName!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Process Update Details",
          style: AppStyles.mondaB.copyWith(fontSize: 22),
        ),

        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(
        //         Icons.menu,
        //         color: Colors.black,
        //         size: 30,
        //       ),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //     );
        //   },
        // ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearch());
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Process Details:",
                        style: AppStyles.mondaB.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customRow("Process Id: ", processid),
                  customRow("Process Name: ", processname.toUpperCase()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status:",
                          style: AppStyles.mondaN
                              .copyWith(fontSize: 16, color: Colors.black54)),
                      process.completed!
                          ? Text(
                              ('Completed'),
                              style: AppStyles.mondaB
                                  .copyWith(fontSize: 17, color: Colors.green),
                            )
                          : Text(('Not Completed'),
                              style: AppStyles.mondaB
                                  .copyWith(fontSize: 17, color: Colors.red)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Process Drawing: ",
                        style: AppStyles.mondaN.copyWith(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      // DownloadButton(
                      //   url:
                      //       '$serversite/api/process_drawing_download/${process.id}/',
                      //   filetype: filetype,
                      //   filename: filename,
                      //   buttonname: 'filename',
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Go to OrderItem",
                          textAlign: TextAlign.center,
                          style: AppStyles.mondaB.copyWith(fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text("Go to Order",
                            textAlign: TextAlign.center,
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Billing Details:",
                        style: AppStyles.mondaB.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customRow("Total Cost: ", processcost.toStringAsFixed(2)),
                  customRow("GST (12%): ", processcosttax.toStringAsFixed(2)),
                  customRow("Total: ",
                      "\u{20B9} ${processcosttotal.toStringAsFixed(2)}"),
                ],
              ),
            ),

            // UI Section: TextFields and Buttons
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 5,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      // TextField for Entering Cost
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
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              decoration: InputDecoration(
                                labelStyle:
                                    AppStyles.mondaN.copyWith(fontSize: 18),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelText: "Enter Cost",
                                // prefixIcon: IconButton(
                                //   icon: const Icon(Icons.money),
                                //   onPressed: () => {},
                                // ),
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
                                labelStyle:
                                    AppStyles.mondaN.copyWith(fontSize: 18),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                // prefixIcon: IconButton(
                                //   icon: const Icon(Icons.scanner_outlined),
                                //   onPressed: () {
                                //     setState(
                                //       () {
                                //         scanBarcode(context);
                                //         completedBoolController.text = barcodeScanRes;
                                //       },
                                //     );
                                //   },
                                // ),
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             PendingOrderProcessScreen()));
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
            ),
          ],
        ),
      ),
    );
  }
}

Widget customRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppStyles.mondaN.copyWith(fontSize: 16, color: Colors.black54),
      ),
      Expanded(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: AppStyles.mondaB.copyWith(fontSize: 17),
        ),
      ),
    ],
  );
}
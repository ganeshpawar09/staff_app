import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_flutter_app/screens/process/widget/order_button.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/process/widget/order_item_button.dart';

class RFQDetailScreen extends StatefulWidget {
  final OrderProcess orderProcess;
  const RFQDetailScreen({Key? key, required this.orderProcess})
      : super(key: key);

  @override
  State<RFQDetailScreen> createState() => _RFQDetailScreenState();
}

class _RFQDetailScreenState extends State<RFQDetailScreen> {
  final costController = TextEditingController();
  final commentController = TextEditingController();
  final leadTimeController = TextEditingController();

  void onAdd() async {
    final String cost = costController.text;
    final String leadTime = leadTimeController.text;
    final String comment = commentController.text;

    // if (cost.isNotEmpty && leadTime.isNotEmpty) {
    //   await Provider.of<ProcessState>(context, listen: false)
    //       .updateProcessStatus(processId, double.parse(cost), barcodeLink);
    // }
    // if (context.mounted) {
    //   Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    OrderProcess process = widget.orderProcess;
    String processid = process.processId!;
    String processname = process.processName!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RFQ Process Details",
          style: AppStyles.mondaB.copyWith(fontSize: 22),
        ),
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
                      OrderItemButton(orderProcess: widget.orderProcess),
                      OrderButton(orderProcess: widget.orderProcess)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 5,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.money_outlined,
                            size: 35,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_sharp,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.black,
                              style: AppStyles.mondaN,
                              controller: leadTimeController,
                              decoration: InputDecoration(
                                labelText: "Lead Time",
                                labelStyle:
                                    AppStyles.mondaN.copyWith(fontSize: 18),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.comment_outlined,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.black,
                              style: AppStyles.mondaN,
                              controller: commentController,
                              decoration: InputDecoration(
                                labelText: "Commetn",
                                labelStyle:
                                    AppStyles.mondaN.copyWith(fontSize: 18),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
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
                            "Save",
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:staff_flutter_app/widget/process_rfq_state.dart';

class RFQDetailScreen extends StatefulWidget {
  final ProcessRFQ processRFQ;

  const RFQDetailScreen({Key? key, required this.processRFQ}) : super(key: key);

  @override
  State<RFQDetailScreen> createState() => _RFQDetailScreenState();
}

class _RFQDetailScreenState extends State<RFQDetailScreen> {
  final costController = TextEditingController();
  final commentController = TextEditingController();
  final leadTimeController = TextEditingController();

  void onAdd() async {
    final String rfqCost = costController.text;
    final String leadTime = leadTimeController.text;
    final String comment = commentController.text;

    if (rfqCost.isNotEmpty) {
      await Provider.of<ProcessRFQState>(context, listen: false)
          .updateProcessRFQ(widget.processRFQ.id!, double.parse(rfqCost));
    }

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  ErpOrderItem? orderitem;

  Future<ErpOrderItem?> fetchData(BuildContext context) async {
    try {
      print('Before fetching data');
      await context
          .read<OrderItemState>()
          .getErpOrderItemByProcess(widget.processRFQ.process!);
      orderitem = context.read<OrderItemState>().erpOrderItemByProcess;

      print('After fetching data');
    } catch (error) {
      print('Error fetching data: $error');
    }

    return context.read<OrderItemState>().erpOrderItemByProcess;
  }

  void refresh(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => RFQDetailScreen(
                processRFQ: widget.processRFQ,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    ErpOrderProcess process = widget.processRFQ.process!;
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
                  customRow("Target Cost: ", "${process.targetCost}"),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status:",
                          style: AppStyles.mondaN
                              .copyWith(fontSize: 16, color: Colors.black54)),
                      widget.processRFQ.rfqCost != 0.00
                          ? Text(
                              ('Offer Given'),
                              style: AppStyles.mondaB
                                  .copyWith(fontSize: 18, color: Colors.green),
                            )
                          : Text(('Offer Left'),
                              style: AppStyles.mondaB
                                  .copyWith(fontSize: 18, color: Colors.red)),
                    ],
                  ),
                  customRow("Your Offer: ", "${widget.processRFQ.rfqCost}"),
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
                  FutureBuilder<ErpOrderItem?>(
                    future: fetchData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data == null) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Chech Your Internet Connection",
                                textAlign: TextAlign.center,
                                style: AppStyles.mondaN.copyWith(fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  refresh(context);
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  size: 45,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Material Details:",
                                  style:
                                      AppStyles.mondaB.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            customRow("Material Type Name",
                                orderitem!.materialDetail!.materialTypeName!),
                            customRow("Material Name",
                                orderitem!.materialDetail!.materialName!),
                            customRow("Dimensions",
                                "${orderitem!.document!.dimensionX} x ${orderitem!.document!.dimensionY} x ${orderitem!.document!.dimensionZ} mm"),
                          ],
                        );
                      }
                    },
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

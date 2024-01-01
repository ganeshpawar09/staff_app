import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/pdf/pdf_button.dart';
import 'package:staff_flutter_app/screens/process/widget/order_button.dart';
import 'package:staff_flutter_app/screens/process/widget/order_item_button.dart';
import 'package:staff_flutter_app/screens/process/widget/process_update_section.dart';
import 'package:staff_flutter_app/widget/product_search.dart';

class ProcessDetailScreen extends StatelessWidget {
  final ErpOrderProcess orderProcess;
  const ProcessDetailScreen({Key? key, required this.orderProcess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ErpOrderProcess process = orderProcess;

    String processId = process.processId!;
    double processCost = process.cost ?? 0;
    double processCostTax = processCost * 0.12;
    double processCostTotal = processCost * 1.12;
    String processName = (process.processName ?? "Not Found").toUpperCase();
    bool processStatus = process.completed ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Process Update Details",
          style: AppStyles.mondaB.copyWith(fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              showSearch(
                  context: context, delegate: ProductSearch(screen: "process"));
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
                  customTitle("Process Details:"),
                  customRow("Process Id: ", processId),
                  customRow("Process Name: ", processName),
                  status(processStatus),
                  const SizedBox(
                    height: 10,
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
                      (process.processDrawing != null)
                          ? PDFButton(
                              url: process.processDrawing!,
                            )
                          : Text(
                              "Not Available",
                              textAlign: TextAlign.end,
                              style: AppStyles.mondaB.copyWith(fontSize: 17),
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrderItemButton(orderProcess: orderProcess),
                      OrderButton(orderProcess: orderProcess)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTitle("Billing Details:"),
                  customRow("Total Cost: ", processCost.toStringAsFixed(2)),
                  customRow("GST (12%): ", processCostTax.toStringAsFixed(2)),
                  customRow("Total: ",
                      "\u{20B9} ${processCostTotal.toStringAsFixed(2)}"),
                ],
              ),
            ),
            ProcessUpdateSection(orderProcess: orderProcess),
          ],
        ),
      ),
    );
  }
}

Widget status(bool status) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Status:",
          style:
              AppStyles.mondaN.copyWith(fontSize: 16, color: Colors.black54)),
      status
          ? Text(
              ('Completed'),
              style:
                  AppStyles.mondaB.copyWith(fontSize: 17, color: Colors.green),
            )
          : Text(('Not Completed'),
              style:
                  AppStyles.mondaB.copyWith(fontSize: 17, color: Colors.red)),
    ],
  );
}

Widget customTitle(String text) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppStyles.mondaB.copyWith(fontSize: 18),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
    ],
  );
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
          style: AppStyles.mondaB.copyWith(fontSize: 16),
        ),
      ),
    ],
  );
}

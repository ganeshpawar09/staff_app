import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/process/process_detail_screen.dart';

class OrderProcessListView extends StatelessWidget {
  final ErpOrderProcess orderProcess;
  const OrderProcessListView({super.key, required this.orderProcess});

  @override
  Widget build(BuildContext context) {
    String processId = orderProcess.processId ?? "Not Found";
    String processName = orderProcess.processName ?? "Not Found";
    String processCost = (orderProcess.cost != null)
        ? "\u{20B9} ${orderProcess.cost.toString()}"
        : "Not Found";
    bool processStatus = orderProcess.completed ?? false;

    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Process Id: $processId',
                  style: AppStyles.mondaB.copyWith(fontSize: 18)),
              const SizedBox(
                height: 8,
              ),
              customRow("Process Name: ", processName.toUpperCase()),
              customRow("Cost: ", processCost),
              status(processStatus),
              Row(children: [
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProcessDetailScreen(
                          orderProcess: orderProcess,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View Details',
                    style: AppStyles.mondaB.copyWith(fontSize: 17),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

Widget status(bool status) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Status:",
          style:
              AppStyles.mondaN.copyWith(fontSize: 16, color: Colors.black54)),
      status
          ? Text(
              ('Completed'),
              style:
                  AppStyles.mondaB.copyWith(fontSize: 18, color: Colors.green),
            )
          : Text(('Not Completed'),
              style:
                  AppStyles.mondaB.copyWith(fontSize: 18, color: Colors.red)),
    ],
  );
}

Widget customRow(String title, String value) {
  return Column(
    children: [
      Row(
        children: [
          Text(title,
              style: AppStyles.mondaN
                  .copyWith(fontSize: 15, color: Colors.black54)),
          Text(value, style: AppStyles.mondaB.copyWith(fontSize: 16)),
        ],
      ),
      const SizedBox(
        height: 8,
      )
    ],
  );
}

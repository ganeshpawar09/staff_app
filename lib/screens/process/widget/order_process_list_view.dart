import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/process/process_detail_screen.dart';

class OrderProcessListView extends StatelessWidget {
  final OrderProcess orderProcess;
  const OrderProcessListView({super.key, required this.orderProcess});

  String processDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Process id: ${orderProcess.id}',
                        style: AppStyles.mondaB.copyWith(fontSize: 20)),
                    // Text(processDate(orderProcess.startDate.toString()),
                    //     style: AppStyles.mondaN.copyWith(fontSize: 16)),
                  ]),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text("Process Name:",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 15, color: Colors.black54)),
                  Text(orderProcess.processName!,
                      style: AppStyles.mondaB.copyWith(fontSize: 16)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text("Price: ",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 15, color: Colors.black54)),
                  Text(orderProcess.cost.toString(),
                      style: AppStyles.mondaB.copyWith(fontSize: 16)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text("Status:",
                  style: AppStyles.mondaN
                      .copyWith(fontSize: 16, color: Colors.black54)),
              orderProcess.completed!
                  ? Text(
                      ('Completed'),
                      style: AppStyles.mondaB
                          .copyWith(fontSize: 18, color: Colors.green),
                    )
                  : Text(('Not Completed'),
                      style: AppStyles.mondaB
                          .copyWith(fontSize: 18, color: Colors.red)),
              Row(children: <Widget>[
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
                        builder: (context) =>
                            ProcessDetailScreen(orderProcess: orderProcess,),
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

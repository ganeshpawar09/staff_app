import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/processrfq/rfq_detail.dart';

class RFQProcessListView extends StatelessWidget {
  final ProcessRFQ processRFQ;
  const RFQProcessListView({
    Key? key,
    required this.processRFQ,
  }) : super(key: key);

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
                    Text('Process Id: ${processRFQ.process!.processId}',
                        style: AppStyles.mondaB.copyWith(fontSize: 18)),
                  ]),
              const SizedBox(
                height: 8,
              ),
              customRow("Process Name: ", "${processRFQ.process!.processName}"),
              const SizedBox(
                height: 8,
              ),
              customRow("Target Cost: ", "${processRFQ.process!.targetCost}"),
              const SizedBox(
                height: 8,
              ),
              (processRFQ.rfqCost != 0.00)
                  ? customRow("Your Offer: ", "${processRFQ.rfqCost}")
                  : const SizedBox(),
              const SizedBox(
                height: 8,
              ),
              Text("Status:",
                  style: AppStyles.mondaN
                      .copyWith(fontSize: 16, color: Colors.black54)),
              processRFQ.rfqCost != 0.00
                  ? Text(
                      ('Offer Given'),
                      style: AppStyles.mondaB
                          .copyWith(fontSize: 18, color: Colors.green),
                    )
                  : Text(('Offer Left'),
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
                        builder: (context) => RFQDetailScreen(
                          processRFQ: processRFQ,
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

Widget customRow(String title, String value) {
  return Row(
    children: [
      Text(title,
          style:
              AppStyles.mondaN.copyWith(fontSize: 15, color: Colors.black54)),
      Text(value, style: AppStyles.mondaB.copyWith(fontSize: 16)),
    ],
  );
}

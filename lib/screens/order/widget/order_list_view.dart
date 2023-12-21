import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_detail_screen.dart';

class OrderListView extends StatelessWidget {
  final ErpOrder order;
  const OrderListView({super.key, required this.order});
  String processDate(String rawDate) {
    DateTime dateTime = DateTime.parse(rawDate);

    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
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
                    Text('Order id: ${order.id}',
                        style: AppStyles.mondaB.copyWith(fontSize: 20)),
                    Text(processDate(order.startDate.toString()),
                        style: AppStyles.mondaN.copyWith(fontSize: 16)),
                  ]),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Client Id:",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 15, color: Colors.black54)),
                  Text(order.quoteNo.toString(),
                      style: AppStyles.mondaB.copyWith(fontSize: 16)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("No. of Parts: ",
                          style: AppStyles.mondaN
                              .copyWith(fontSize: 15, color: Colors.black54)),
                      Text((order.itemsNew!.length).toString(),
                          style: AppStyles.mondaB.copyWith(fontSize: 16))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price: ",
                          style: AppStyles.mondaN
                              .copyWith(fontSize: 15, color: Colors.black54)),
                      Text("####",
                          style: AppStyles.mondaB.copyWith(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text("Status:",
                  style: AppStyles.mondaN
                      .copyWith(fontSize: 16, color: Colors.black54)),
              order.completed!
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
                        builder: (context) => OrderDetailScreen(order: order),
                      ),
                    );
                    // Navigator.of(context).pushNamed(
                    //   OrderDetailScreen.routeName,
                    //   arguments: dataOrderAllSingle.id,
                    // );
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

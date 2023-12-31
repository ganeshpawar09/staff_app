import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_item_detail_screen.dart';

class OrderItemListView extends StatelessWidget {
  final ErpOrderItem orderItem;
  const OrderItemListView({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    String orderItemId = (orderItem.document!.partId!);
    String orderItemQuantity = (orderItem.quantity ?? 0).toString();
    bool orderItemStatus = orderItem.ordered ?? false;

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
                  Text('OrderItem Id: $orderItemId',
                      style: AppStyles.mondaB.copyWith(fontSize: 18)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text("Quantity: ",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 15, color: Colors.black54)),
                  Text(orderItemQuantity,
                      style: AppStyles.mondaB.copyWith(fontSize: 16)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              (orderItem.materialDetail!=null)?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Material Type: ",
                          style: AppStyles.mondaN
                              .copyWith(fontSize: 15, color: Colors.black54)),
                      Text(orderItem.materialDetail!.materialTypeName!,
                          style: AppStyles.mondaB.copyWith(fontSize: 16))
                    ],
                  ),
                ],
              ):const SizedBox(),
              const SizedBox(
                height: 8,
              ),
              Text("Status:",
                  style: AppStyles.mondaN
                      .copyWith(fontSize: 16, color: Colors.black54)),
              orderItemStatus
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
                        builder: (context) => OrderItemDetailScreen(
                          orderItem: orderItem,
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

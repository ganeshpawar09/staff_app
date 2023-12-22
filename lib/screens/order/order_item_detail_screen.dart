import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/widget/material_list_view.dart';

class OrderItemDetailScreen extends StatelessWidget {
  final ErpOrderItem orderItem;
  const OrderItemDetailScreen({super.key, required this.orderItem});
  double calculateTotalPriceOrderItem() {
    double totalPrice = 0;

    totalPrice += orderItem.quantity! * orderItem.materialDetail!.rate!;

    for (OrderProcess orderProcess in orderItem.process!) {
      totalPrice += orderProcess.cost ?? 0;
    }
    for (OrderMovement orderMovement in orderItem.movement!) {
      totalPrice += orderMovement.transportCost ?? 0;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    String orderItemId = (orderItem.document!.partId!);
    String orderItemQuantity = (orderItem.quantity ?? 0).toString();
    String orderItemMaterialType = orderItem.materialDetail!.materialTypeName!;
    String orderItemMaterialName = orderItem.materialDetail!.materialName!;
    String orderItemMaterialRate =
        orderItem.materialDetail!.rate!.toStringAsFixed(2);
    double orderItemCost = calculateTotalPriceOrderItem();
    double tax12 = orderItemCost * .12;
    double totalCost = orderItemCost + tax12;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("OrderItem Detail View",
            style: AppStyles.mondaB.copyWith(fontSize: 22)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text("OrderItem Details:",
                  style: AppStyles.mondaB.copyWith(fontSize: 20)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("OrderItem Id",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderItemId,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tracking Number",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text("#",
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Quantity",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderItemQuantity,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Cost",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderItemCost.toStringAsFixed(2),
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Taxes(12%)",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(tax12.toStringAsFixed(2),
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("TOTAL",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 18, color: Colors.black54)),
                        Text("\u{20B9} ${totalCost.toStringAsFixed(2)}",
                            style: AppStyles.mondaB.copyWith(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text("Material Details:",
                  style: AppStyles.mondaB.copyWith(fontSize: 20)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Material Type Name",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderItemMaterialType,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Material Name",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderItemMaterialName,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Material Rate",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderItemMaterialRate,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/widget/product_search.dart';

class OrderItemDetailScreen extends StatelessWidget {
  final ErpOrderItem orderItem;
  const OrderItemDetailScreen({super.key, required this.orderItem});
  double calculateTotalPriceOrderItem() {
    double totalPrice = 0;
    if (orderItem.materialDetail != null) {
      totalPrice += orderItem.quantity! * orderItem.materialDetail!.rate!;
    }
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

    double orderItemCost = calculateTotalPriceOrderItem();
    double tax12 = orderItemCost * .12;
    double totalCost = orderItemCost + tax12;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("OrderItem Detail View",
            style: AppStyles.mondaB.copyWith(fontSize: 22)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              showSearch(
                  context: context, delegate: ProductSearch(screen: "order"));
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          customTitle("OrderItem Details:"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                customRow("OrderItem Id", orderItemId),
                customRow("Tracking Number", orderItemId),
                customRow("Quantity", orderItemQuantity),
                customRow("Total Cost", orderItemCost.toStringAsFixed(2)),
                customRow("Taxes(12%)", tax12.toStringAsFixed(2)),
                customRow("TOTAL", orderItemCost.toStringAsFixed(2)),
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
          const SizedBox(
            height: 20,
          ),
          (orderItem.materialDetail != null)
              ? Column(
                  children: [
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          customRow("Material Type Name",
                              orderItem.materialDetail!.materialTypeName!),
                          customRow("Material Name",
                              orderItem.materialDetail!.materialName!),
                          customRow(
                              "Material Rate",
                              orderItem.materialDetail!.rate!
                                  .toStringAsFixed(2)),
                        ],
                      ),
                    ),
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

Widget customTitle(String text) {
  return Column(
    children: [
      Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(text, style: AppStyles.mondaB.copyWith(fontSize: 20)),
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
    children: <Widget>[
      Text(
        title,
        style: AppStyles.mondaB.copyWith(fontSize: 16, color: Colors.black54),
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

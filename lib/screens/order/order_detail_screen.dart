import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/widget/order_item_list_view.dart';
import 'package:staff_flutter_app/widget/product_search.dart';

class OrderDetailScreen extends StatefulWidget {
  final ErpOrder order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  double calculateTotalPriceOrder() {
    double totalPrice = 0;
    if (widget.order.itemsNew != null) {
      for (ErpOrderItem orderItem in widget.order.itemsNew!) {
        if (orderItem.materialDetail != null &&
            orderItem.materialDetail!.rate != null) {
          totalPrice += orderItem.quantity! * orderItem.materialDetail!.rate!;
        }
        if (orderItem.process != null) {
          for (ErpOrderProcess orderProcess in orderItem.process!) {
            totalPrice += orderProcess.cost ?? 0;
          }
        }
        if (orderItem.movement != null) {
          for (ErpOrderMovement orderMovement in orderItem.movement!) {
            totalPrice += orderMovement.transportCost ?? 0;
          }
        }
      }
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    List<ErpOrderItem> orderitem = widget.order.itemsNew ?? [];
    String orderId = widget.order.quoteNo.toString();
    String orderRefId = widget.order.refCode.toString();
    String totalParts =
        ((widget.order.itemsNew != null) ? widget.order.itemsNew!.length : 0)
            .toString();
    double totalPrice = calculateTotalPriceOrder();
    double tax12 = totalPrice * .12;
    double totalPriceAndTax = totalPrice + tax12;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Order Detail View",
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
          customTitle("Order Details:"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                customRow("Order Id", orderId),
                customRow("Order Ref Id", orderRefId),
                customRow("Total Parts", totalParts),
                customRow("Total Cost", totalPrice.toStringAsFixed(2)),
                customRow("Taxes(12%)", tax12.toStringAsFixed(2)),
                customRow(
                    "TOTAL", "\u{20B9} ${totalPriceAndTax.toStringAsFixed(2)}"),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          customTitle("Order Item List:"),
          (widget.order.itemsNew != null)
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: orderitem.length,
                      itemBuilder: (BuildContext context, int index) =>
                          OrderItemListView(
                        orderItem: orderitem[index],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
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
        style: AppStyles.mondaB.copyWith(fontSize: 17, color: Colors.black54),
      ),
      Expanded(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: AppStyles.mondaB.copyWith(fontSize: 18),
        ),
      ),
    ],
  );
}

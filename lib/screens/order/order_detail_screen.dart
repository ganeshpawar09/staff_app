import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/widget/order_item_list_view.dart';

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
          for (OrderProcess orderProcess in orderItem.process!) {
            totalPrice += orderProcess.cost ?? 0;
          }
        }
        if (orderItem.movement != null) {
          for (OrderMovement orderMovement in orderItem.movement!) {
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
              Text("Order Details:",
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Order ID",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderId,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Order Ref ID",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderRefId,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Parts",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(totalParts,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Cost",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(totalPrice.toStringAsFixed(2),
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
                        Text("\u{20B9} ${totalPriceAndTax.toStringAsFixed(2)}",
                            style: AppStyles.mondaB.copyWith(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text("Order Item List:",
                  style: AppStyles.mondaB.copyWith(fontSize: 20)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
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

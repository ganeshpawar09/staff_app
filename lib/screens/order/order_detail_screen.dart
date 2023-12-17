import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/order.dart';
import 'package:staff_flutter_app/widget/order_item_list_view.dart';

class OrderDetailScreen extends StatefulWidget {
  final ErpOrder order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  // final costController = TextEditingController();
  // final barcodeController = TextEditingController();
  // final completedBoolController = TextEditingController();
  // String barcodeScanRes = '';

  // Future scanBarcode(BuildContext context) async {
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //     "#ff6666",
  //     "Cancel",
  //     true,
  //     ScanMode.BARCODE,
  //   );
  //   setState(() {
  //     completedBoolController.text = barcodeScanRes;
  //     this.barcodeScanRes = barcodeScanRes;
  //     print("barcode text");
  //     print(this.barcodeScanRes);
  //   });
  // }

  // void onAdd() {
  //   final String val1 = costController.text;
  //   final String val2 = completedBoolController.text;

  //   final dynamic id = ModalRoute.of(context)!.settings.arguments;
  //   print("barcode value is");
  //   print(val2);
  //   if (val1.isNotEmpty && val2.isNotEmpty) {
  //     Provider.of<ProcessState>(context, listen: false)
  //         .updateprocessstatus(id, int.parse(val1), val2);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final orderitem = widget.order.itemsNew;
    // print(orderitem);
    // String orderid = order.quoteNo!;

    double processcost = 40;
    double processcosttax = processcost * 0.12;
    double processcosttotal = processcost * 1.12;
    // print(orderid);
    // String processname = process.processName!;

    // var path = process.processDrawing;
    // var split = path!.split('.');
    // var splitname = path.split('/');
    // String filename = splitname.last;
    // String filetype = split.last;

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
                        Text(widget.order.quoteNo!,
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Order Ref ID",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(widget.order.refCode.toString(),
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Parts",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(orderitem!.length.toString(),
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Cost",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text("${processcost.toStringAsFixed(2)}",
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Taxes(12%)",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text("${processcosttax.toStringAsFixed(2)}",
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("TOTAL",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 18, color: Colors.black54)),
                        Text("\u{20B9} ${processcosttotal.toStringAsFixed(2)}",
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
              Text("Order Item List:",
                  style: AppStyles.mondaB.copyWith(fontSize: 20)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
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
          ),
          // Container(
          //     padding: EdgeInsets.all(10),
          //     child: Column(
          //       children: [
          //         TextField(
          //           style: TextStyle(fontSize: 12, color: Colors.black),
          //           controller: costController,
          //           keyboardType: TextInputType.number,
          //           inputFormatters: [
          //             FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          //           ],
          //           decoration: InputDecoration(
          //             labelText: "Enter Cost",
          //             prefixIcon: IconButton(
          //               icon: Icon(Icons.money),
          //               onPressed: () => {},
          //             ),
          //           ),
          //         ),
          //         TextField(
          //           style: TextStyle(fontSize: 12, color: Colors.black),
          //           controller: completedBoolController,
          //           decoration: InputDecoration(
          //             labelText: "Scan Barcode",
          //             prefixIcon: IconButton(
          //               icon: Icon(Icons.scanner_outlined),
          //               onPressed: () {
          //                 setState(() {
          //                   scanBarcode(context);
          //                   completedBoolController.text = barcodeScanRes;
          //                 });
          //               },
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(10),
          //           child: ElevatedButton(
          //               child: Text('#change this'),
          //               onPressed: () {
          //                 onAdd();
          //                 // Navigator.push(
          //                 //     context,
          //                 //     MaterialPageRoute(
          //                 //         builder: (context) =>
          //                 //             PendingOrderProcessScreen()));
          //               }),
          //         ),
          //         // change this
          //       ],
          //     ),)
        ],
      ),
    );
  }
}

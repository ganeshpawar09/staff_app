import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_detail_screen.dart';
import 'package:staff_flutter_app/screens/order/order_item_detail_screen.dart';
import 'package:staff_flutter_app/screens/process/process_detail_screen.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:staff_flutter_app/state/order_state.dart';
import 'package:staff_flutter_app/state/order_process_state.dart';
import 'package:staff_flutter_app/state/vedor_state.dart';

class ProductSearch extends SearchDelegate<String> {
  final String screen;
  ProductSearch({required this.screen});

  Future _scanBarcode(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );
    query = barcodeScanRes;
  }

  @override
  String get searchFieldLabel => screen.toUpperCase();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      InkWell(
        child: Image.asset(
          "assets/barcode_scan.png",
          width: 30,
          height: 30,
        ),
        onTap: () {
          _scanBarcode(context);
        },
      ),
      const SizedBox(
        width: 10,
      ),
      IconButton(
        icon: const Icon(
          Icons.clear,
          size: 30,
        ),
        color: Colors.black,
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      color: Colors.black,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    dynamic data;
    if (screen == "order") {
      data = query.isEmpty
          ? context.watch<OrderState>().erporderlist
          : context
              .watch<OrderState>()
              .erporderlist
              .where((p) => p.quoteNo!
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
    } else if (screen == "process") {
      data = query.isEmpty
          ? context.watch<OrderProcessState>().orderProcessList
          : context
              .watch<OrderProcessState>()
              .orderProcessList
              .where((p) => p.processId!
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
    } else if (screen == "orderItem") {
      data = query.isEmpty
          ? context.watch<OrderItemState>().erporderitemlist
          : context
              .watch<OrderItemState>()
              .erporderitemlist
              .where((p) => p.document!.partId!
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
    }
    // else if (screen == "movement") {
    //   data = context.read<MovementState>().movementList;
    //   productNames = data;
    //   products = query.isEmpty
    //       ? productNames
    //       : productNames.where((p) =>
    //           p.movementId!.toString().toLowerCase().startsWith(query.toLowerCase()));
    // }
    else if (screen == "vendor") {
      data = query.isEmpty
          ? context.watch<VendorState>().vendorList
          : context.watch<VendorState>().vendorList.where((p) => p.vendorCode!
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()));
    }

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            if (screen == "order") {
              ErpOrder order = context
                  .read<OrderState>()
                  .singleOrder(data.elementAt(index).quoteNo!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailScreen(
                    order: order,
                  ),
                ),
              );
            } else if (screen == "process") {
              OrderProcess orderProcess = context
                  .read<OrderProcessState>()
                  .singleProcess(data.elementAt(index).processId!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProcessDetailScreen(
                    orderProcess: orderProcess,
                  ),
                ),
              );
            } else if (screen == "orderItem") {
              ErpOrderItem erpOrderItem = context
                  .read<OrderItemState>()
                  .singleOrderItem(data.elementAt(index).document.partId!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderItemDetailScreen(
                    orderItem: erpOrderItem,
                  ),
                ),
              );
            }
            // else if(screen=="movement") {
            //   OrderMovement orderMovement = context
            //       .read<MovementState>()
            //       .singleOrderItem(products.elementAt(index).document.partId!);
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => (
            //       ),
            //     ),
            //   );
            // }
            //   else if(screen=="vendor") {
            //     VendorDetail vendorDetail = context
            //         .read<VendorState>()
            //         .singleVendor(products.elementAt(index).vendorCode!);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => (

            //         ),
            //       ),
            //     );
            //   }
          },
          title: Text(
            (screen == "order")
                ? data[index].quoteNo!
                : (screen == "process")
                    ? data[index].processId!.toString()
                    : data[index].document.partId!.toString(),
          )),
      itemCount: data.length,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_item_detail_screen.dart';
import 'package:staff_flutter_app/state/erp_order_item_state.dart';
import 'package:connectivity/connectivity.dart';

class OrderItemButton extends StatefulWidget {
  final ErpOrderProcess orderProcess;
  const OrderItemButton({super.key, required this.orderProcess});

  @override
  State<OrderItemButton> createState() => _OrderItemButtonState();
}

class _OrderItemButtonState extends State<OrderItemButton> {
  bool _loading = false;
  bool _error = false;

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  void fetchData(BuildContext context) async {
    try {
      print('Before fetching data');

      bool isConnected = await checkInternetConnectivity();

      if (!isConnected) {
        print('Internet not available');
        return;
      }

      if (!mounted) {
        return; // Check if the widget is still in the tree
      }

      setState(() {
        _loading = true;
      });

      await context
          .read<ErpOrderItemState>()
          .getErpOrderItemByProcess(widget.orderProcess);

      print('After fetching data');
    } catch (error) {
      print('Error fetching data: $error');

      if (mounted) {
        // Check if the widget is still in the tree
        setState(() {
          _error = true;
        });
      }
    }

    if (mounted) {
      // Check if the widget is still in the tree
      setState(() {
        _loading = false;
        if (!_error &&
            context.read<ErpOrderItemState>().erpOrderItemByProcess != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderItemDetailScreen(
                orderItem: context.read<ErpOrderItemState>().erpOrderItemByProcess!,
              ),
            ),
          );
        }
      });
    }
  }

  void onPressedCallback(BuildContext context) async {
    bool isConnected = await checkInternetConnectivity();

    if (!isConnected) {
      print('Internet not available');
      return;
    }

    fetchData(context);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressedCallback(context);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: (_loading)
          ? const SizedBox(
              width: 130,
              child: Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          : SizedBox(
              width: 130,
              child: Center(
                child: Text(
                  "Go to OrderItem",
                  textAlign: TextAlign.center,
                  style: AppStyles.mondaB.copyWith(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
    );
  }
}

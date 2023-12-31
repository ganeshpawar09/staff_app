import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_item_detail_screen.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:connectivity/connectivity.dart';

class OrderItemButton extends StatefulWidget {
  final OrderProcess orderProcess;
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

      setState(() {
        _loading = true;
      });

      await context
          .read<OrderItemState>()
          .getErpOrderItemByProcess(widget.orderProcess);

      print('After fetching data');
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _error = true;
      });
    }

    setState(() {
      _loading = false;
      if (!_error &&
          context.read<OrderItemState>().erpOrderItemByProcess != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderItemDetailScreen(
              orderItem: context.read<OrderItemState>().erpOrderItemByProcess!,
            ),
          ),
        );
      }
    });
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
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressedCallback(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: (_loading)
          ? const SizedBox(
              width: 130,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            )
          : SizedBox(
              width: 130,
              child: Text(
                "Go to OrderItem",
                textAlign: TextAlign.center,
                style: AppStyles.mondaB.copyWith(
                  fontSize: 15,
                ),
              ),
            ),
    );
  }
}

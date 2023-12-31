import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_detail_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:staff_flutter_app/state/erp_order_state.dart';

class OrderButton extends StatefulWidget {
  final ErpOrderProcess orderProcess;
  const OrderButton({super.key, required this.orderProcess});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
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
          .read<ErpOrderState>()
          .getErpOrderByProcess(widget.orderProcess);

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
            context.read<ErpOrderState>().singleErpOrderByProcess != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailScreen(
                order: context.read<ErpOrderState>().singleErpOrderByProcess!,
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
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressedCallback(context);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: (_loading)
          ? const SizedBox(
              width: 120,
              child: Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : SizedBox(
              width: 120,
              child: Center(
                child: Text(
                  "Go to Order",
                  textAlign: TextAlign.center,
                  style: AppStyles.mondaB
                      .copyWith(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
    );
  }
}

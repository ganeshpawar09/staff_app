import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/order/order_detail_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:staff_flutter_app/state/order_state.dart';

class OrderButton extends StatefulWidget {
  final OrderProcess orderProcess;
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

      setState(() {
        _loading = true;
      });

      await context
          .read<OrderState>()
          .getErpOrderByProcess(widget.orderProcess);

      print('After fetching data');
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _error = true;
      });
    }

    setState(() {
      _loading = false;
      if (!_error) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
              order: context.read<OrderState>().singleErpOrderByProcess,
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
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: (_loading)
          ? const SizedBox(
              width: 90,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : SizedBox(
              width: 90,
              child: Text(
                "Go to Order",
                textAlign: TextAlign.center,
                style: AppStyles.mondaB
                    .copyWith(fontSize: 15, color: Colors.white),
              ),
            ),
    );
  }
}

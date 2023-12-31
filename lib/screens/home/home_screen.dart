import 'package:flutter/material.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/movement/movement_screen.dart';
import 'package:staff_flutter_app/screens/processrfq/rfq_screen.dart';
import 'package:staff_flutter_app/screens/vendor/vendor_screen.dart';
import 'package:staff_flutter_app/screens/home/widget/home_grid_view.dart';
import 'package:staff_flutter_app/screens/order/order_screen.dart';
import 'package:staff_flutter_app/screens/orderitem/order_item_screen.dart';
import 'package:staff_flutter_app/screens/process/process_screen.dart';
import 'package:staff_flutter_app/widget/drawer.dart';
import 'package:staff_flutter_app/const/font.dart';

class DataFetchStatus {
  static bool orderDataIsFetched = false;
  static bool processDataIsFetched = false;
  static bool orderItemDataIsFetched = false;
  static bool movementDataIsFetched = false;
  static bool vendorDataIsFetched = false;
  static bool rfqProcessDataIsFetched = false;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<GridItem> items = [
      GridItem(
        title: "View Orders",
        img: "assets/box.png",
        widget: OrderScreen(),
      ),
      GridItem(
        title: "View OrderItem",
        img: "assets/parts.png",
        widget: OrderItemScreen(),
      ),
      GridItem(
        title: "View Process",
        img: "assets/list.png",
        widget: ProcessScreen(),
      ),
      GridItem(
        title: "View Movements",
        img: "assets/movement.png",
        widget: MovementScreen(),
      ),
      GridItem(
        title: "View RFQ Process",
        img: "assets/bid.png",
        widget: RFQScreen(),
      ),
      GridItem(
        title: "View Vendors",
        img: "assets/man.png",
        widget: VendorScreen(),
      ),
      GridItem(
        title: "View Payments",
        img: "assets/wallet.png",
        widget: ProcessScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(
                "assets/menu.png",
                width: 35,
                height: 35,
              ),
            );
          },
        ),
        title: Text(
          "Dashboard",
          style: AppStyles.mondaB.copyWith(fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 180,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) =>
                    HomeScreenGridView(item: items[index]),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}

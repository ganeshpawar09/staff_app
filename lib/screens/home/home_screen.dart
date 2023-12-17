import 'package:flutter/material.dart';
import 'package:staff_flutter_app/models/grid_item.dart';
import 'package:staff_flutter_app/widget/home_grid_view.dart';
import 'package:staff_flutter_app/screens/order/order_screen.dart';
import 'package:staff_flutter_app/screens/orderitem/odert_item_screen.dart';
import 'package:staff_flutter_app/screens/process/process_screen.dart';
import 'package:staff_flutter_app/widget/add_drawer.dart';
import 'package:staff_flutter_app/const/font.dart';

class DataFetchStatus {
  static bool orderDataIsFetched = false;
  static bool processDataIsFetched = false;
  static bool orderItemDataIsFetched = false;
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
        widget: ProcessScreen(),
      ),
      GridItem(
        title: "View RFQ Vendor",
        img: "assets/group.png",
        widget: ProcessScreen(),
      ),
      GridItem(
        title: "View Vendors",
        img: "assets/man.png",
        widget: ProcessScreen(),
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 200,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/models/grid_item.dart';
import 'package:staff_flutter_app/screens/home/widget/home_grid_view.dart';
import 'package:staff_flutter_app/screens/order/order_screen.dart';
import 'package:staff_flutter_app/screens/process/process_screen.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:staff_flutter_app/state/order_state.dart';
import 'package:staff_flutter_app/state/process_state.dart';
import 'package:staff_flutter_app/widgets/add_drawer.dart';

class DataFetchStatus {
  static bool orderDataIsFetched = false;
  static bool processDataIsFetched = false;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _init = true;
  // bool _isLoading = true;

  // Future<void> fetchData() async {
  //   await Provider.of<ProcessState>(context, listen: false)
  //       .getorderprocesslists();
  //   await Provider.of<ProcessState>(context, listen: false)
  //       .getorderprocessnowlists();
  //   await Provider.of<ProcessState>(context, listen: false)
  //       .getorderprocessupcominglists();
  //   await Provider.of<OrderState>(context, listen: false).geterporderlists();
  //   await Provider.of<OrderitemState>(context, listen: false)
  //       .geterporderitemlists();
  // }

  // void didChangeDependencies() async {
  //   if (_init) {
  //     await fetchData();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  //   _init = false;
  //   super.didChangeDependencies();
  // }

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
        widget: ProcessScreen(),
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
                width: 40,
                height: 40,
              ),
            );
          },
        ),
        title: Image.asset(
          "assets/cadandcart.png",
          fit: BoxFit.contain,
          height: 35,
          width: 180,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/barcode_scan/widgets/product_search.dart';
import 'package:staff_flutter_app/old%20screen/bottom_nav_screens/bottom_nav_home.dart';
import 'package:staff_flutter_app/old%20screen/bottom_nav_screens/bottom_nav_pending_order.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:staff_flutter_app/state/order_state.dart';
import 'package:staff_flutter_app/state/process_state.dart';
import 'package:staff_flutter_app/widgets/add_drawer.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});
  // static const routeName = '/home-screens';

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  bool _init = true;
  bool _isLoding = false;

  int currentTab = 0;
  final List<Widget> screens = [
    BNdashboard(),
    BNPendingOrderProcessScreen(),
    BNdashboard()
  ];
  Widget currentScreen = BNdashboard();
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  void didChangeDependencies() async {
    if (_init) {
      // Provider.of<OrderitemState>(context).geterporderitemlists();
      Provider.of<ProcessState>(context).getorderprocesslists();
      Provider.of<ProcessState>(context).getorderprocessnowlists();
      Provider.of<ProcessState>(context).getorderprocessupcominglists();
      Provider.of<OrderState>(context).getErpOrderList();
      Provider.of<OrderitemState>(context).geterporderitemlists();
      _isLoding = true;
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoding)
      return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/cadandcart.png",
            fit: BoxFit.contain,
            height: 35,
            width: 180,
          ),
        ),
        body: Center(
          child: Text("Please check internet connection or!"),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
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
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: ProductSearch());
              },
            ),
          ],
        ),

        drawer: AppDrawer(),
        body: PageStorage(child: currentScreen, bucket: bucket),
        // bottomNavigationBar: bmnav.BottomNav(
        //   index: currentTab,
        //   labelStyle: bmnav.LabelStyle(visible: false),
        //   onTap: (i) {
        //     setState(() {
        //       currentTab = i;
        //       currentScreen = screens[i];
        //     });
        //   },
        //   items: [
        //     bmnav.BottomNavItem(Icons.home_outlined),
        //     bmnav.BottomNavItem(Icons.shopping_cart_outlined),
        //     bmnav.BottomNavItem(Icons.notification_add_outlined),
        //     bmnav.BottomNavItem(Icons.view_headline)
        //   ],
        // ),
      );
  }
}

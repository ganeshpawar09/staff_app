  import 'package:flutter/material.dart';

  import 'package:staff_flutter_app/barcode_scan/widgets/product_search.dart';
  import 'package:staff_flutter_app/const/font.dart';
  import 'package:staff_flutter_app/models/order.dart';
  import 'package:staff_flutter_app/screens/home/home_screen.dart';
  import 'package:staff_flutter_app/screens/order/widget/order_list_view.dart';
  import 'package:staff_flutter_app/screens/order/widget/skeleton_order_tabbar_view.dart';
  import 'package:staff_flutter_app/state/order_item_state.dart';
  import 'package:staff_flutter_app/state/order_state.dart';
  import 'package:provider/provider.dart';
  import 'package:intl/intl.dart';

  class OrderScreen extends StatefulWidget {
    const OrderScreen({super.key});

    @override
    State<OrderScreen> createState() => _OrderScreenState();
  }

  class _OrderScreenState extends State<OrderScreen> {
    bool _isLoading = true;

    // List<ErpOrder> dataOrderAll = [];
    // List<ErpOrder> dataOrderPending = [];
    // List<ErpOrder> dataOrderCompleted = [];
    Future<void> fetchData(bool refresh) async {
      if (!DataFetchStatus.orderDataIsFetched || refresh) {
        try {
          await Provider.of<OrderState>(context, listen: false)
              .geterporderlists();
          // await Provider.of<OrderitemState>(context, listen: false)
          //     .geterporderitemlists();
          setState(() {
            _isLoading = false;
            DataFetchStatus.orderDataIsFetched = true;
          });
        } catch (error) {
          print('Error fetching data: $error');
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }

    void refresh() {
      setState(() {
        _isLoading = true;
      });

      fetchData(true);
    }

    @override
    void initState() {
      super.initState();
      fetchData(false);
    }

    @override
    void dispose() {
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "View Order",
              style: AppStyles.mondaB.copyWith(fontSize: 22),
            ),

            // leading: Builder(
            //   builder: (BuildContext context) {
            //     return IconButton(
            //       icon: const Icon(
            //         Icons.menu,
            //         color: Colors.black,
            //         size: 30,
            //       ),
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //     );
            //   },
            // ),
            bottom: const TabBar(
              dividerColor: Colors.white,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontFamily: 'monda', fontSize: 17),
              tabs: [
                Tab(text: 'Total'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: ProductSearch());
                },
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          // drawer: AppDrawer(),
          body: (_isLoading)
              ? const SkeletonOrderTabbarView()
              : TabBarView(
                  children: [
                    OrderTab(
                      data: Provider.of<OrderState>(context).erporderlist,
                      refreshFunction: refresh,
                    ),
                    OrderTab(
                      data: Provider.of<OrderState>(context).erporderpendinglist,
                      refreshFunction: refresh,
                    ),
                    OrderTab(
                      data:
                          Provider.of<OrderState>(context).erpordercompletedlist,
                      refreshFunction: refresh,
                    ),
                  ],
                ),
        ),
      );
    }
  }

  class OrderTab extends StatelessWidget {
    final List<ErpOrder> data;
    final VoidCallback refreshFunction;

    const OrderTab({Key? key, required this.data, required this.refreshFunction})
        : super(key: key);

    @override
    Widget build(BuildContext context) {
      return RefreshIndicator(
        onRefresh: () async {
          return refreshFunction();
        },
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) =>
                OrderListView(dataOrderAllSingle: data[index]),
          ),
        ),
      );
    }
  }

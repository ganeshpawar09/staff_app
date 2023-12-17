import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/order.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/screens/order/widget/order_list_view.dart';
import 'package:staff_flutter_app/screens/order/widget/skeleton_order_tabbar_view.dart';
import 'package:staff_flutter_app/state/order_state.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  Future<List<ErpOrder>> fetchData(BuildContext context) async {
    try {
      if (!DataFetchStatus.orderDataIsFetched) {
        await Provider.of<OrderState>(context, listen: false).getErpOrderList();
        DataFetchStatus.orderDataIsFetched = true;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    if (context.mounted) {
      return Provider.of<OrderState>(context, listen: false).erporderlist;
    }
    return [];
  }

  void refresh(BuildContext context) {
    DataFetchStatus.orderDataIsFetched = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderScreen(),
      ),
    );
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
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                // Provider.of<OrderState>(context, listen: false).manupulate();
                // showSearch(context: context, delegate: ProductSearch());
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: FutureBuilder<List<ErpOrder>>(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                DataFetchStatus.orderDataIsFetched == false) {
              return const SkeletonOrderTabbarView();
            } else if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chech Your Internet Connection",
                      textAlign: TextAlign.center,
                      style: AppStyles.mondaN.copyWith(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        refresh(context);
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 45,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return TabBarView(
                children: [
                  Consumer<OrderState>(
                    builder: (context, provider, child) => OrderTab(
                      data: provider.erporderlist,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<OrderState>(
                    builder: (context, provider, child) => OrderTab(
                      data: provider.erporderpendinglist,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<OrderState>(
                    builder: (context, provider, child) => OrderTab(
                      data: provider.erpordercompletedlist,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),

        // drawer: AppDrawer(),
        // body: (_isLoading)
        //     ? const SkeletonOrderTabbarView()
        //     : TabBarView(
        //         children: [
        //           OrderTab(
        //             data: Provider.of<OrderState>(context).erporderlist,
        //             refreshFunction: refresh,
        //           ),
        //           OrderTab(
        //             data: Provider.of<OrderState>(context).erporderpendinglist,
        //             refreshFunction: refresh,
        //           ),
        //           OrderTab(
        //             data:
        //                 Provider.of<OrderState>(context).erpordercompletedlist,
        //             refreshFunction: refresh,
        //           ),
        //         ],
        //       ),
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
        refreshFunction();
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

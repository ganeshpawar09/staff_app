import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/screens/order/widget/order_list_view.dart';
import 'package:staff_flutter_app/widget/product_search.dart';
import 'package:staff_flutter_app/widget/skeleton_tabbar_view.dart';
import 'package:staff_flutter_app/state/order_state.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  Future<List<ErpOrder>> fetchData(BuildContext context) async {
    try {
      if (!DataFetchStatus.orderDataIsFetched) {
        await context.read<OrderState>().getErpOrderList();
        DataFetchStatus.orderDataIsFetched = true;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    if (context.mounted) {
      return context.read<OrderState>().erporderlist;
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
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            dividerColor: Colors.white,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: const TextStyle(fontFamily: 'monda', fontSize: 17),
            tabs: [
              Tab(
                  text:
                      '(${context.watch<OrderState>().erporderlist.length})Total'),
              Tab(
                  text:
                      '(${context.watch<OrderState>().erporderpendinglist.length})Upcoming'),
              Tab(
                  text:
                      '(${context.watch<OrderState>().erpordercompletedlist.length})Completed'),
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
                showSearch(
                    context: context, delegate: ProductSearch(screen: "order"));
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SkeletonTabbarView(
                tabs: 3,
              );
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
              OrderListView(order: data[index]),
        ),
      ),
    );
  }
}

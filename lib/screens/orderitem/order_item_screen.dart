import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/widget/product_search.dart';
import 'package:staff_flutter_app/widget/skeleton_tabbar_view.dart';
import 'package:staff_flutter_app/screens/order/widget/order_item_list_view.dart';
import 'package:staff_flutter_app/state/erp_order_item_state.dart';
import 'package:provider/provider.dart';

class OrderItemScreen extends StatelessWidget {
  const OrderItemScreen({super.key});

  Future<List<ErpOrderItem>> fetchData(BuildContext context) async {
    try {
      if (!DataFetchStatus.orderItemDataIsFetched) {
        await context.read<ErpOrderItemState>().getErpOrderItemList();
        DataFetchStatus.orderItemDataIsFetched = true;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    if (context.mounted) {
      return context.read<ErpOrderItemState>().erporderitemlist;
    }

    return [];
  }

  void refresh(BuildContext context) {
    DataFetchStatus.orderItemDataIsFetched = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderItemScreen(),
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
            "View Order Item",
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
                      '(${context.watch<ErpOrderItemState>().erporderitemlist.length})Total'),
              Tab(
                  text:
                      '(${context.watch<ErpOrderItemState>().erporderitempendinglist.length})Upcoming'),
              Tab(
                  text:
                      '(${context.watch<ErpOrderItemState>().erporderitemcompletedlist.length})Completed'),
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
                    context: context,
                    delegate: ProductSearch(screen: "orderItem"));
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: FutureBuilder<List<ErpOrderItem>>(
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
                  Consumer<ErpOrderItemState>(
                    builder: (context, provider, child) => OrderItemTab(
                      data: provider.erporderitemlist,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<ErpOrderItemState>(
                    builder: (context, provider, child) => OrderItemTab(
                      data: provider.erporderitempendinglist,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<ErpOrderItemState>(
                    builder: (context, provider, child) => OrderItemTab(
                      data: provider.erporderitemcompletedlist,
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

class OrderItemTab extends StatelessWidget {
  final List<ErpOrderItem> data;
  final VoidCallback refreshFunction;

  const OrderItemTab(
      {Key? key, required this.data, required this.refreshFunction})
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
              OrderItemListView(orderItem: data[index]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:staff_flutter_app/widget/product_search.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/widget/skeleton_tabbar_view.dart';
import 'package:staff_flutter_app/screens/process/widget/process_list_view.dart';
import 'package:staff_flutter_app/state/erp_order_process_state.dart';
import 'package:provider/provider.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  Future<List<ErpOrderProcess>> fetchData(BuildContext context) async {
    try {
      print('Before fetching data');
      if (!DataFetchStatus.processDataIsFetched) {
        await context.read<ErpOrderProcessState>().getOrderProcessList();

        DataFetchStatus.processDataIsFetched = true;
      }

      print('After fetching data');
    } catch (error) {
      print('Error fetching data: $error');
    }

    if (context.mounted) {
      print('Returning orderProcessList');
      return context.read<ErpOrderProcessState>().orderProcessList;
    }

    return [];
  }

  void refresh(BuildContext context) {
    DataFetchStatus.processDataIsFetched = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ProcessScreen(),
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
            "View Process",
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
                      '(${context.watch<ErpOrderProcessState>().orderProcessList.length})Total'),
              Tab(
                  text:
                      '(${context.watch<ErpOrderProcessState>().orderProcessPendingList.length})Upcoming'),
              Tab(
                  text:
                      '(${context.watch<ErpOrderProcessState>().orderProcessCompletedList.length})Completed'),
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
                    delegate: ProductSearch(screen: "process"));
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: FutureBuilder<List<ErpOrderProcess>>(
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
                  Consumer<ErpOrderProcessState>(
                    builder: (context, provider, child) => OrderProcessTab(
                      data: provider.orderProcessList,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<ErpOrderProcessState>(
                    builder: (context, provider, child) => OrderProcessTab(
                      data: provider.orderProcessPendingList,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<ErpOrderProcessState>(
                    builder: (context, provider, child) => OrderProcessTab(
                      data: provider.orderProcessCompletedList,
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

class OrderProcessTab extends StatelessWidget {
  final List<ErpOrderProcess> data;
  final VoidCallback refreshFunction;

  const OrderProcessTab(
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
              OrderProcessListView(
            orderProcess: data[index],
          ),
        ),
      ),
    );
  }
}

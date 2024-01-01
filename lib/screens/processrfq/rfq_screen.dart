import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/screens/processrfq/widget/rfq_process_list_view.dart';
import 'package:staff_flutter_app/widget/process_rfq_state.dart';

class RFQScreen extends StatelessWidget {
  const RFQScreen({Key? key}) : super(key: key);

  Future<List<ProcessRFQ>> fetchData(BuildContext context) async {
    try {
      print('Before fetching data');
      if (!DataFetchStatus.rfqProcessDataIsFetched) {
        await context.read<ProcessRFQState>().getProcessRFQlists();

        DataFetchStatus.rfqProcessDataIsFetched = true;
      }

      print('After fetching data');
    } catch (error) {
      print('Error fetching data: $error');
    }

    if (context.mounted) {
      print('Returning orderProcessList');
      return context.read<ProcessRFQState>().processRFQList;
    }

    return [];
  }

  void refresh(BuildContext context) {
    DataFetchStatus.rfqProcessDataIsFetched = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RFQScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "View RFQ Process",
            style: AppStyles.mondaB.copyWith(fontSize: 22),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            dividerColor: Colors.white,
            labelStyle: const TextStyle(fontFamily: 'monda', fontSize: 17),
            tabs: [
              Tab(
                  text:
                      '(${context.watch<ProcessRFQState>().notOfferProcessRFQList.length})Offer Left'),
              Tab(
                  text:
                      '(${context.watch<ProcessRFQState>().offerProcessRFQList.length})Offer Given (${context.watch<ProcessRFQState>().offerProcessRFQList.length})'),
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
                // showSearch(
                //     context: context,
                //     delegate: ProductSearch(screen: "process"));
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: FutureBuilder<List<ProcessRFQ>>(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
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
                  Consumer<ProcessRFQState>(
                    builder: (context, provider, child) => OrderProcessTab(
                      data: provider.notOfferProcessRFQList,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<ProcessRFQState>(
                    builder: (context, provider, child) => OrderProcessTab(
                      data: provider.offerProcessRFQList,
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
  final List<ProcessRFQ> data;
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
          itemBuilder: (BuildContext context, int index) => RFQProcessListView(
            processRFQ: data[index],
          ),
        ),
      ),
    );
  }
}

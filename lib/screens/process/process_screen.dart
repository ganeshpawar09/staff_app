import 'package:flutter/material.dart';
import 'package:staff_flutter_app/barcode_scan/widgets/product_search.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/order_process.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/screens/process/process_update.dart';
import 'package:staff_flutter_app/state/process_state.dart';
import 'package:staff_flutter_app/widgets/add_drawer.dart';
import 'package:provider/provider.dart';

class ProcessScreen extends StatefulWidget {
  @override
  _ProcessScreen createState() => _ProcessScreen();
}

class _ProcessScreen extends State<ProcessScreen> {
  bool _isLoading = true;

  Future<void> fetchData() async {
    if (!DataFetchStatus.processDataIsFetched) {
      try {
        await Provider.of<ProcessState>(context, listen: false)
            .getorderprocesslists();

        setState(() {
          _isLoading = false;
          DataFetchStatus.processDataIsFetched = true;
        });
      } catch (error) {
        print('Error fetching data: $error');
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
     return Provider.of<ProcessState>(context, listen: false)
            .getorderprocesslists();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final data_process_all =
    //     Provider.of<ProcessState>(context).orderprocesslist;
    // final data_process_completed =
    //     Provider.of<ProcessState>(context).completedorderprocess;
    // final data_process_pending =
    //     Provider.of<ProcessState>(context).pendingorderprocess;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "View Process",
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
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            dividerColor: Colors.white,
            labelStyle: TextStyle(fontFamily: 'monda', fontSize: 17),
            tabs: [
              Tab(text: 'Total'),
              Tab(text: 'Pending'),
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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: ListView.builder(
                        itemCount: Provider.of<ProcessState>(context)
                            .orderprocesslist
                            .length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildAllOrders(
                                context,
                                Provider.of<ProcessState>(context)
                                    .orderprocesslist,
                                index)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: ListView.builder(
                        itemCount: Provider.of<ProcessState>(context)
                            .pendingorderprocess
                            .length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildAllOrders(
                                context,
                                Provider.of<ProcessState>(context)
                                    .pendingorderprocess,
                                index)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: ListView.builder(
                        itemCount: Provider.of<ProcessState>(context)
                            .completedorderprocess
                            .length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildAllOrders(
                                context,
                                Provider.of<ProcessState>(context)
                                    .completedorderprocess,
                                index)),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildAllOrders(BuildContext context, List data, int index) {
    final dataProcessAllSingle = data[index];
    return Container(
      child: Card(
        child: Padding(
          // padding: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.only(
              left: 10, right: 4.0, top: 4.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    ('Process id: ${dataProcessAllSingle.processId}'),
                    style: AppStyles.mondaB.copyWith(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(('Price: ${dataProcessAllSingle.cost}'),
                      style: AppStyles.mondaB.copyWith(fontSize: 16)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(('Process Name:${dataProcessAllSingle.processName}'),
                      style: AppStyles.mondaB.copyWith(fontSize: 16)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                      ('Vendor:${dataProcessAllSingle.vendorDetail.companyName} '),
                      style: AppStyles.mondaB.copyWith(fontSize: 16)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff151022)),
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProcessUpdateScreen(
                                    id: dataProcessAllSingle.id,
                                  )));
                    },
                    child: Text('View Details'),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProcessTab extends StatelessWidget {
//   final List<OrderProcess> data;

//   const ProcessTab({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (BuildContext context, int index) =>
//             buildAllOrders(dataOrderAllSingle: data[index]),
//       ),
//     );
//   }
// }
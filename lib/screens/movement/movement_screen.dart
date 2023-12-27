import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/state/movement_state.dart';
import 'package:staff_flutter_app/screens/movement/widget/movement_list_view.dart';
import 'package:staff_flutter_app/widget/skeleton_tabbar_view.dart';
import 'package:provider/provider.dart';

class MovementScreen extends StatelessWidget {
  const MovementScreen({super.key});

  Future<List<OrderMovement>> fetchData(BuildContext context) async {
    try {
      if (!DataFetchStatus.movementDataIsFetched) {
        await context.read<MovementState>().getMovementList();
        DataFetchStatus.movementDataIsFetched = true;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    if (context.mounted) {
      return context.read<MovementState>().movementList;
    }

    return [];
  }

  void refresh(BuildContext context) {
    DataFetchStatus.movementDataIsFetched = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MovementScreen(),
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
            "View Movement",
            style: AppStyles.mondaB.copyWith(fontSize: 22),
          ),
          bottom: const TabBar(
            dividerColor: Colors.white,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
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
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: FutureBuilder<List<OrderMovement>>(
          future: fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SkeletonTabbarView();
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
                  Consumer<MovementState>(
                    builder: (context, provider, child) => MovementTab(
                      data: provider.movementList,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<MovementState>(
                    builder: (context, provider, child) => MovementTab(
                      data: provider.movementPendingList,
                      refreshFunction: () {
                        refresh(context);
                      },
                    ),
                  ),
                  Consumer<MovementState>(
                    builder: (context, provider, child) => MovementTab(
                      data: provider.movementCompletedList,
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

class MovementTab extends StatelessWidget {
  final List<OrderMovement> data;
  final VoidCallback refreshFunction;

  const MovementTab(
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
              MovementListView(movement: data[index]),
        ),
      ),
    );
  }
}

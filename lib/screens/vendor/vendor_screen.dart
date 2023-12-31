import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/state/vedor_state.dart';
import 'package:staff_flutter_app/screens/vendor/update_vendor.dart';
import 'package:staff_flutter_app/screens/order/widget/order_list_view.dart';
import 'package:staff_flutter_app/widget/skeleton_tabbar_view.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/screens/vendor/widget/vendor_list_view.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({super.key});

  Future<List<VendorDetail>> fetchData(BuildContext context) async {
    try {
      if (!DataFetchStatus.vendorDataIsFetched) {
        await context.read<VendorState>().getVendorList();
        DataFetchStatus.vendorDataIsFetched = true;
      }
    } catch (error) {
      print('Error fetching data: $error');
    }

    if (context.mounted) {
      return context.read<VendorState>().vendorList;
    }

    return [];
  }

  void refresh(BuildContext context) {
    DataFetchStatus.vendorDataIsFetched = false;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VendorScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<VendorDetail> list = context.watch<VendorState>().vendorList;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "View Vendor Details",
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
        body: FutureBuilder<List<VendorDetail>>(
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
              return RefreshIndicator(
                onRefresh: () async {
                  refresh;
                },
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) =>
                        VendroDetailListView(vendorDetail: list[index]),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:staff_flutter_app/screens/order/widget/skeleton_order_list_view.dart';

class SkeletonOrderTabbarView extends StatelessWidget {
  const SkeletonOrderTabbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonOrderListView();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonOrderListView();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonOrderListView();
              }),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:staff_flutter_app/widget/skeleton_list_view.dart';

class SkeletonTabbarView extends StatelessWidget {
  const SkeletonTabbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonListView();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonListView();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonListView();
              }),
        ),
      ],
    );
  }
}

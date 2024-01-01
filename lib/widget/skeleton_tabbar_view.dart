import 'package:flutter/material.dart';
import 'package:staff_flutter_app/widget/skeleton_list_view.dart';

class SkeletonTabbarView extends StatelessWidget {
  final int tabs;

  const SkeletonTabbarView({Key? key, required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs, 
      child: TabBarView(
        children: List.generate(
          tabs,
          (index) => Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonListView();
              },
            ),
          ),
        ),
      ),
    );
  }
}

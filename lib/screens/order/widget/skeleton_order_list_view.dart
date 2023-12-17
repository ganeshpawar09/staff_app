import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonOrderListView extends StatelessWidget {
  const SkeletonOrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShimmerContainer(30, 150),
                  _buildShimmerContainer(20, 100),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShimmerContainer(25, 130),
                  _buildShimmerContainer(25, 110),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildShimmerContainer(25, 110),
                  _buildShimmerContainer(25, 140),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              _buildShimmerContainer(25, 90),
              const SizedBox(
                height: 5,
              ),
              _buildShimmerContainer(30, 150),
              Row(
                children: <Widget>[
                  const Spacer(),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white,
                    period: Duration(milliseconds: 2000),
                    child: Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerContainer(double height, double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.white,
      period: Duration(milliseconds: 2000),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}

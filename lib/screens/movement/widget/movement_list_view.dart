import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';

class MovementListView extends StatelessWidget {
  final OrderMovement movement;
  const MovementListView({super.key, required this.movement});

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
            children: <Widget>[
              Text('Movement Id: ${movement.movementId}',
                  style: AppStyles.mondaB.copyWith(fontSize: 18)),

              const SizedBox(
                height: 8,
              ),
              // Row(
              //   children: [
              //     Text("Material Name: ",
              //         style: AppStyles.mondaN
              //             .copyWith(fontSize: 14, color: Colors.black54)),
              //     Text(material.materialName.toString(),
              //         style: AppStyles.mondaB.copyWith(fontSize: 15)),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text("Material Type Name: ",
              //         style: AppStyles.mondaN
              //             .copyWith(fontSize: 14, color: Colors.black54)),
              //     Text(material.materialTypeName.toString(),
              //         style: AppStyles.mondaB.copyWith(fontSize: 15)),
              //   ],
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("No. of Materials: ",
              //             style: AppStyles.mondaN
              //                 .copyWith(fontSize: 15, color: Colors.black54)),
              //         Text(
              //             (orderItem.manufacturingTech!.material!.length
              //                     .toString())
              //                 .toString(),
              //             style: AppStyles.mondaB.copyWith(fontSize: 16))
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("No of Process: ",
              //             style: AppStyles.mondaN
              //                 .copyWith(fontSize: 15, color: Colors.black54)),
              //         Text(orderItem.process!.length.toString(),
              //             style: AppStyles.mondaB.copyWith(fontSize: 16)),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 8,
              // ),

              Text("Status:",
                  style: AppStyles.mondaN
                      .copyWith(fontSize: 16, color: Colors.black54)),
              ((movement.completed ?? false))
                  ? Text(
                      ('Completed'),
                      style: AppStyles.mondaB
                          .copyWith(fontSize: 18, color: Colors.green),
                    )
                  : (movement.picked ?? false)
                      ? Text(('Started'),
                          style: AppStyles.mondaB
                              .copyWith(fontSize: 18, color: Colors.red))
                      : Text(('Not Started'),
                          style: AppStyles.mondaB
                              .copyWith(fontSize: 18, color: Colors.red)),
            
            ],
          ),
        ),
      ),
    );
  }
}

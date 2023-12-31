import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';
import 'package:staff_flutter_app/screens/vendor/update_vendor.dart';
import 'package:staff_flutter_app/state/vedor_state.dart';

class VendroDetailListView extends StatelessWidget {
  final VendorDetail vendorDetail;
  const VendroDetailListView({super.key, required this.vendorDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Vendor Code: ",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 15, color: Colors.black)),
                  Expanded(
                    child: Text("${vendorDetail.vendorCode}",
                        style: AppStyles.mondaB.copyWith(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Company Name: ",
                      style: AppStyles.mondaN
                          .copyWith(fontSize: 15, color: Colors.black54)),
                  Expanded(
                    child: Text(vendorDetail.companyName.toString(),
                        style: AppStyles.mondaB.copyWith(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateVendor(vendor: vendorDetail),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Text(
                        "Update",
                        textAlign: TextAlign.center,
                        style: AppStyles.mondaB.copyWith(fontSize: 17),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () async {
                      await Provider.of<VendorState>(context)
                          .deleteVendor(vendorDetail.id!);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Text("Delete",
                          textAlign: TextAlign.center,
                          style: AppStyles.mondaB
                              .copyWith(fontSize: 17, color: Colors.white)),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("No. of Parts: ",
              //             style: AppStyles.mondaN
              //                 .copyWith(fontSize: 15, color: Colors.black54)),
              //         Text((vendorDetail.itemsNew!.length).toString(),
              //             style: AppStyles.mondaB.copyWith(fontSize: 16))
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("Price: ",
              //             style: AppStyles.mondaN
              //                 .copyWith(fontSize: 15, color: Colors.black54)),
              //         Text("####",
              //             style: AppStyles.mondaB.copyWith(fontSize: 16)),
              //       ],
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Text("Status:",
              //     style: AppStyles.mondaN
              //         .copyWith(fontSize: 16, color: Colors.black54)),
              // vendorDetail.completed!
              //     ? Text(
              //         ('Completed'),
              //         style: AppStyles.mondaB
              //             .copyWith(fontSize: 18, color: Colors.green),
              //       )
              //     : Text(('Not Completed'),
              //         style: AppStyles.mondaB
              //             .copyWith(fontSize: 18, color: Colors.red)),
              // Row(children: <Widget>[
              //   const Spacer(),
              //   TextButton(
              //     style: TextButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         side: const BorderSide(color: Colors.black),
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //     ),
              //     onPressed: () async {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) =>
              //               OrderDetailScreen(order: vendorDetail),
              //         ),
              //       );
              //       // Navigator.of(context).pushNamed(
              //       //   OrderDetailScreen.routeName,
              //       //   arguments: dataOrderAllSingle.id,
              //       // );
              //     },
              //     child: Text(
              //       'View Details',
              //       style: AppStyles.mondaB.copyWith(fontSize: 17),
              //     ),
              // ),
              // ]
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

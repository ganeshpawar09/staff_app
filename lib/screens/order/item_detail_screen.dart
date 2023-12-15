import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/order.dart';
import 'package:staff_flutter_app/models/data.dart';
import 'package:staff_flutter_app/screens/order/widget/material_list_view.dart';

class ItemDetailScreen extends StatelessWidget {
  final ErpOrderItem part;
  const ItemDetailScreen({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Part Detail View",
            style: AppStyles.mondaB.copyWith(fontSize: 22)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text("Part Details:",
                  style: AppStyles.mondaB.copyWith(fontSize: 20)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Part No",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(part.document!.partId.toString(),
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tracking Number",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text("#",
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Part Name",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text("# ",
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Quantity",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text(part.quantity.toString(),
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Cost(without tax)",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text("#",
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Taxes(12%)",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 15, color: Colors.black54)),
                        Text("#",
                            style: AppStyles.mondaB.copyWith(fontSize: 17)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("TOTAL",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 18, color: Colors.black54)),
                        Text("\u{20B9} #",
                            style: AppStyles.mondaB.copyWith(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text("Material List:",
                  style: AppStyles.mondaB.copyWith(fontSize: 20)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: part.manufacturingTech!.material!.length,
                itemBuilder: (BuildContext context, int index) =>
                    MaterialListView(
                  material: part.manufacturingTech!.material![index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

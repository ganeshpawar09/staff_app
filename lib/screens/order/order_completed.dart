import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: const Card(
                    color: Colors.white,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        size: 23,
                        color: Colors.grey,
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Order #1514",
              textAlign: TextAlign.center,
              style: AppStyles.mondaB.copyWith(fontSize: 25),
            ),
            const SizedBox(
              height: 35,
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.black54,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You have completed the order",
                          style: AppStyles.mondaB
                              .copyWith(fontSize: 17, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text("Rate product to get 5 points for collect.",
                            style: AppStyles.mondaB
                                .copyWith(fontSize: 12, color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        "assets/delivery_man.png",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                children: [
                  orderDetailRow("Order number", "#1514"),
                  orderDetailRow("Tracking number", "IK987362341"),
                  orderDetailRow("Order name", "Parts forsdfsdfsdf milling"),
                  orderDetailRow("Completed On", "13-12-2023"),
                  orderDetailRow("Price(without tax)", "1000"),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      "Return Dashboard",
                      textAlign: TextAlign.center,
                      style: AppStyles.mondaB.copyWith(fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Rate",
                      textAlign: TextAlign.center,
                      style: AppStyles.mondaB.copyWith(fontSize: 17, color: Colors.white)
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

Widget orderDetailRow(String section, String detail) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            section,
            textAlign: TextAlign.center,
            style: AppStyles.mondaN.copyWith(fontSize: 17, color: Colors.grey)
          ),
          Expanded(
            child: Text(
              detail,
              textAlign: TextAlign.end,
              style: AppStyles.mondaN.copyWith(fontSize: 17, color: Colors.black)
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );
}

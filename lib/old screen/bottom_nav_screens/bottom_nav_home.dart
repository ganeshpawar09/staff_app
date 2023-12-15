import 'package:flutter/material.dart';
import 'package:staff_flutter_app/old%20screen/griddashboard.dart';

class BNdashboard extends StatefulWidget {
  static const routeName = '/home-screens';

  const BNdashboard({super.key});

  @override
  _BNdashboardState createState() => _BNdashboardState();
}

class _BNdashboardState extends State<BNdashboard> {
  @override
  Widget build(BuildContext context) {
    // final companyname =
    //     Provider.of<GetPartnerDetails>(context).getcompanyname();
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hello #",
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // GridDashboard()
        ],
      ),
    );
  }
}

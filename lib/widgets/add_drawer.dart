import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/old%20screen/home_screen1.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/screens/login/login_screen.dart';
import 'package:staff_flutter_app/screens/order/order_screen.dart';
import 'package:staff_flutter_app/screens/process/process_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  LocalStorage storage =  LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              title: Text(
                "Welcome",
                style: AppStyles.mondaB.copyWith(fontSize: 25),
              ),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              leading: const Icon(
                Icons.home,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Home",
                style: AppStyles.mondaN.copyWith(fontSize: 18),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderScreen()));
              },
              leading: const Icon(
                Icons.shopping_bag,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "All Orders",
                style: AppStyles.mondaN.copyWith(fontSize: 18),
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(HomeScreens.routeName);
            //   },
            //   leading: Icon(
            //     Icons.inventory,
            //     color: Color(0xff151022),
            //   ),
            //   title: Text("Upcoming Orders"),
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.of(context).pushNamed(HomeScreens.routeName);
            //   },
            //   leading: Icon(
            //     Icons.inventory,
            //     color: Color(0xff151022),
            //   ),
            //   title: Text("Completed Orders"),
            // ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProcessScreen()));
              },
              leading: const Icon(
                Icons.production_quantity_limits,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Order Process",
                style: AppStyles.mondaN.copyWith(fontSize: 18),
              ),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                _logoutnew();
              },
              leading: const Icon(
                Icons.logout,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                "Logout",
                style: AppStyles.mondaN.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void downloadBinaryFile() {
    HttpClient client = new HttpClient();
    var _downloadData = <int>[];
    var fileSave = new File('./logo.png');
    client
        .getUrl(Uri.parse(
            "https://fluttermaster.com/wp-content/uploads/2018/08/fluttermaster.com-logo-web-header.png"))
        .then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.listen((d) => _downloadData.addAll(d), onDone: () {
        fileSave.writeAsBytes(_downloadData);
      });
    });
  }
}

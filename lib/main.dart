import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:staff_flutter_app/screens/home/home_screen.dart';
import 'package:staff_flutter_app/screens/login/login_screen.dart';
import 'package:staff_flutter_app/state/movement_state.dart';
import 'package:staff_flutter_app/state/order_item_state.dart';
import 'package:staff_flutter_app/state/order_state.dart';
import 'package:staff_flutter_app/state/process_state.dart';
import 'package:staff_flutter_app/state/user_state.dart';

main() {
  runApp(const CadAndCart());
}

class CadAndCart extends StatelessWidget {
  const CadAndCart({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = LocalStorage('usertoken');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => UserState()),
        ChangeNotifierProvider(create: (ctx) => OrderState()),
        ChangeNotifierProvider(create: (ctx) => ProcessState()),
        ChangeNotifierProvider(create: (ctx) => OrderState()),
        ChangeNotifierProvider(create: (ctx) => OrderItemState()),
        ChangeNotifierProvider(create: (ctx) => MovementState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          primaryColorLight: Colors.white,
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(255, 254, 254, 1),
        ),
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return LoginScreen();
            }
            return HomeScreen();
          },
        ),
        // routes: {
        //   HomeScreens.routeName: (ctx) => HomeScreens(),
        //   LoginScrrens.routeName: (ctx) => LoginScrrens(),
        //   // RegisterScreens.routeName: (ctx) => RegisterScreens(),
        //   // PartnerDashboard.routeName: (ctx) => PartnerDashboard(),
        //   // RfqPartner.routeName: (ctx) => RfqPartner(),
        //   // PdfViewerScreen.routeName: (ctx) => PdfViewerScreen(),
        //   ProcessScreen.routeName: (ctx) => ProcessScreen(),
        //   ProcessUpdateScreen.routeName: (ctx) => ProcessUpdateScreen(),
        //   OrderDetailScreen.routeName: (ctx) => OrderDetailScreen(
        //         id: 0,
        //       ),
        // },
      ),
    );
  }
}

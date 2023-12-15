// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:staff_flutter_app/screens/order/order_screen.dart';
// import 'package:staff_flutter_app/screens/process/process_screen.dart';

// class GridDashboard extends StatelessWidget {
//   GridDashboard({super.key});

//   final Items item1 = new Items(
//     title: "View Orders",
//     event: "3 Orders",
//     img: "assets/calendar.png",
//     url: OrderScreen.routeName,
//   );
//   final Items item2 = new Items(
//     title: "View Process",
//     event: "4 Items",
//     img: "assets/past_order.png",
//     url: ProcessScreen.routeName,
//   );

//   @override
//   Widget build(BuildContext context) {
//     List<Items> myList = [item1, item2];
//     var color = 0xff151022;
//     return Flexible(
//       child: GridView.count(
//           childAspectRatio: 1.0,
//           padding: const EdgeInsets.only(left: 16, right: 16),
//           crossAxisCount: 2,
//           crossAxisSpacing: 18,
//           mainAxisSpacing: 18,
//           children: myList.map((data) {
//             return GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pushNamed(data.url);
//                 },
//                 child: Card(
//                   elevation: 5,
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Image.asset(
//                           data.img,
//                           width: 42,
//                         ),
//                         const SizedBox(
//                           height: 14,
//                         ),
//                         Text(
//                           data.title,
//                           style: GoogleFonts.monda(
//                             textStyle: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 8,
//                         ),
//                         const SizedBox(
//                           height: 14,
//                         ),
//                         Text(
//                           data.event,
//                           style: GoogleFonts.monda(
//                               textStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w600)),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ));
//           }).toList()),
//     );
//   }
// }

// class Items {
//   String title;
//   // String subtitle;
//   String event;
//   String img;
//   final String url;
//   Items(
//       {required this.title,
//       required this.event,
//       required this.img,
//       required this.url});
// }

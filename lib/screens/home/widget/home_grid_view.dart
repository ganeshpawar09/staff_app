import 'package:flutter/material.dart';
import 'package:staff_flutter_app/const/font.dart';
import 'package:staff_flutter_app/models/combine_data.dart';

class HomeScreenGridView extends StatelessWidget {
  final GridItem item;
  const HomeScreenGridView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.widget),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(item.title,
                    textAlign: TextAlign.center,
                    style: AppStyles.mondaN.copyWith(fontSize: 17)),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  item.img,
                  width: 80,
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

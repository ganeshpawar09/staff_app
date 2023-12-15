import 'package:flutter/material.dart';
import 'package:staff_flutter_app/screens/process/process_update.dart';
import 'package:staff_flutter_app/state/process_state.dart';
import 'package:staff_flutter_app/widgets/add_drawer.dart';
import 'package:provider/provider.dart';

class BNPendingOrderProcessScreen extends StatelessWidget {
  static const routeName = '/pending-order-process-screen';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ProcessState>(context).pendingorderprocess;
    //final process = Provider.of<OrderProcessState>(context).process;
    print('dashboard process data');
    print(data);
    return Scaffold(
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(1),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (ctx, i) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProcessUpdateScreen(id: data[i].id!),
                    ),
                  );
                },
                title: Text(data[i].processId!),
                subtitle: Text(data[i].processName!),
              ),
            );
          },
        ),
      ),
    );
  }
}

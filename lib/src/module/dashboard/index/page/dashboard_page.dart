// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:share_app/src/module/dashboard/index/controller/dashboard_controller.dart';
import 'package:share_app/src/shared/controller/notification_controller.dart';
import 'package:share_app/src/shared/widgets/list_notification.dart';
import 'package:share_app/src/shared/widgets/text_field_message.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardController controller = DashboardController();
  NotificationController notificationController = NotificationController();

  final List<Tab> tabs = [
    Tab(
      text: 'Recebidas',
      height: 48.0,
    ),
    Tab(
      text: 'Enviadas',
      height: 48.0,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'Mensagens',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
            backgroundColor: Colors.deepOrangeAccent,
            bottom: TabBar(
              tabs: tabs,
              indicatorColor: Colors.white,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Sair'),
                        content: Text('Deseja realmente sair?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar',
                                style: TextStyle(color: Colors.grey)),
                          ),
                          SizedBox(width: 12.0),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              controller.signOut(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.red),
                            ),
                            child: Text(
                              'Sair',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          SizedBox(width: 10.0),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TabBarView(
                  children: [
                    ListMessage(
                        notifications:
                            notificationController.getRecievedNotification()),
                    ListMessage(
                        notifications:
                            notificationController.getSentNotification()),
                  ],
                ),
              ),
              SizedBox(width: 100.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 100.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TextFieldMessage(
                    controller: controller.message,
                    onSubmitted: (value) {
                      notificationController.sendNotification(value, context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:share_app/src/module/dashboard/index/controller/dashboard_controller.dart';
import 'package:share_app/src/shared/widgets/list_message.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardController controller = DashboardController();

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
                              controller.signOut();
                            },
                            child: Text('Cancelar',
                                style: TextStyle(color: Colors.grey)),
                          ),
                          SizedBox(width: 12.0),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
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
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: TabBarView(
              children: [
                ListMessage(
                    messages: controller.receivedMessagesController.getList()),
                ListMessage(
                    messages: controller.sentMessagesController.getList()),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Chat iniciado'),
                    content: Text('O chat foi iniciado.'),
                    actions: [
                      TextButton(
                        child: Text('Fechar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Colors.deepOrangeAccent,
            child: Icon(Icons.add_comment),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}

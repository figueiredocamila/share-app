// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class EntrancePage extends StatefulWidget {
  const EntrancePage({super.key});

  @override
  State<EntrancePage> createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attractions_outlined,
                color: Colors.deepOrangeAccent,
                size: 60.0,
              ),
              Text.rich(TextSpan(
                  text: 'SHARE',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'app.',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.deepOrangeAccent,
                      ),
                    )
                  ]))
            ],
          ),
          SizedBox(height: 54),
          Row(children: [
            Text('FAÇA LOGIN E ACESSE SUA CONTA',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14.0, color: Colors.black54))
          ]),
          TextField(
            decoration: InputDecoration(
                labelText: 'E-MAIL',
                labelStyle: TextStyle(fontSize: 12.0, color: Colors.black54),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.deepOrangeAccent,
                ))),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'SENHA',
                labelStyle: TextStyle(fontSize: 12.0, color: Colors.black54),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.deepOrangeAccent,
                ))),
          ),
          SizedBox(height: 14),
          Row(children: [
            Text('Esqueceu sua senha?',
                style: TextStyle(fontSize: 12.0, color: Colors.black54))
          ]),
          SizedBox(height: 34),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print('entrou');
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepOrangeAccent)),
              child: Text('ENTRAR'),
            ),
          ),
          SizedBox(height: 44),
          Row(children: [
            Text.rich(
              TextSpan(
                text: 'PRECISA DE UMA CONTA? ',
                style: TextStyle(fontSize: 14.0, color: Colors.black54),
                children: [
                  TextSpan(
                    text: 'CADASTRE-SE',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';

class TodoDetail extends StatefulWidget {
  const TodoDetail({Key? key}) : super(key: key);

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {


  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments as String ;
    return  Scaffold(
      appBar: AppBar(title:Text('Second Page')),
      body :  Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(args,
            style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );


;
  }
}

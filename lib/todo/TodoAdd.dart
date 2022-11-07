import 'package:flutter/material.dart';

class TodoAdd extends StatefulWidget {
  const TodoAdd({Key? key}) : super(key: key);

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  List<String> todoList = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(onPressed:() {
                Navigator.of(context).pop(controller.value.text);
              }, child: Text('저장하기'))
            ],
          ),
        ),
      ),
    );
  }


}

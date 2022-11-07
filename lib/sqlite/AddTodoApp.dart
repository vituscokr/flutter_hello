import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './Todo.dart';
class AddTodoApp extends StatefulWidget {
  final Future<Database> db;
  const AddTodoApp(this.db, {Key? key }) : super(key: key);

  @override
  State<AddTodoApp> createState() => _AddTodoAppState();
}

class _AddTodoAppState extends State<AddTodoApp> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo 추가')),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: '제목'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: '할일'),
                ),
              ),
              TextButton(
                  onPressed: save,
                  child: Text('저장하기')),
            ],
          ),
        ),),
    );
  }

  save() {
    Todo todo = Todo(titleController.value.text, contentController.value.text, false);
    Navigator.of(context).pop(todo);
  }
}

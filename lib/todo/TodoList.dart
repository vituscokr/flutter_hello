import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> todoList = [];
  @override
  void initState() {
    super.initState();
    todoList.add('당근 사오기');
    todoList.add('약 사오기');
    todoList.add('청소하기');
    todoList.add('부모님께 전화하기');
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Detail Example'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Card(
          child: InkWell(
            child: Text(
              todoList[index],
              style: TextStyle(fontSize: 30),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/detail', arguments: todoList[index]);
            },
          ),
        );
      }
      ,itemCount: todoList.length,),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Navigator.of(context).pushNamed('/add');
            _addnavigation(context);
          },
          child: Icon(Icons.add),
        ),
    );
  }
  _addnavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/add');

    setState(() {
      todoList.add(result as String );
    });
  }
}

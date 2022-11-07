import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './Todo.dart';
import './AddTodoApp.dart';

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;
  const DatabaseApp(this.db, {Key? key}) : super(key: key);

  @override
  State<DatabaseApp> createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {

 late Future<List<Todo>> todoList;

  @override
  void initState() {
    super.initState();
    var items = getList();

    print(items);
    todoList = items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Database Example'),
      ),
      body: Scaffold(
        body: Container(
          child: Center(
            child: FutureBuilder(
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(itemBuilder: (context, index) {
                        var todo = snapshot.data![index];
                        return ListTile(
                          title: Text(todo.title, style: TextStyle(fontSize: 20)),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Text(todo.content),
                                Text('체크 : ${todo.active.toString()}'),
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          onLongPress: () async {
                            TextEditingController controller = TextEditingController(text: todo.content);
                            Todo result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title : Text('${todo.id}: ${todo.title}'),
                                    content: TextField(
                                      controller: controller,
                                      keyboardType: TextInputType.text,
                                    ),
                                    actions: [
                                      TextButton(onPressed: () {
                                        setState(() {
                                          todo.active == true ? todo.active = false : todo.active = true ;
                                          todo.content = controller.value.text;
                                        });
                                        Navigator.of(context).pop(todo);
                                      }, child: Text('예')),
                                      TextButton(onPressed: () {
                                        Navigator.of(context).pop();
                                      }, child: Text('아니요'))
                                    ]
                                  );

                                });
                            if(result != null) {
                              _updateTodo(result);
                            }

                          },
                          onTap: () async {
                            Todo result = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('${todo.id} : ${todo.title}'),
                                content: Text('${todo.content}를 삭제하시겠습니까?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(todo);
                                      },
                                  child: Text('예')
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        },
                                      child: Text('아니요')
                                  ),
                                ],
                              );
                            }
                            );
                            if (result != null) {
                              _deleteTodo(result);
                            }
                            },
    );



                        //   Card(
                        //   child: Column(
                        //     children: [
                        //       Text(todo.title),
                        //       Text(todo.content),
                        //       Text(todo.active.toString()),
                        //     ],
                        //   ),
                        // );

                      },
                      itemCount: snapshot.data?.length,
                      );
                    } else {
                      return Text('No Data');
                    }
                }
                return CircularProgressIndicator();
              },
              future: todoList ,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: action,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }

  action() async {
    final todo = await Navigator.of(context).pushNamed('/add') as Todo;
     _insertTodo(todo);

     setState(() {
       todoList = getList();
     });
  }

  _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }
  _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update('todos', todo.toMap(), where:'id=?', whereArgs: [todo.id],);
    setState(() {
      todoList = getList();
    });
  }
  _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id=?' , whereArgs: [todo.id]);
    setState(() {
      todoList = getList();
    });
  }

  Future<List<Todo>> getList() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');
    return List.generate(maps.length, (index) {
      bool active = maps[index]['active'] == 1 ? true : false ;
      return Todo(
          maps[index]['title'].toString(),
          maps[index]['content'].toString(),
          active,
          int.parse(maps[index]['id'].toString())
      );
    });
  }
}

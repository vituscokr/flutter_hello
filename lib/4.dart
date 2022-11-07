import 'package:flutter/material.dart';
import 'package:flutter/src/material/tab_controller.dart';
import 'package:hello/firstPage.dart';
import 'package:hello/secondPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  late TabController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if(! controller.indexIsChanging) {
        print('이전 index, ${controller.previousIndex}');
        print('현재 index, ${controller.index}');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      darkTheme: ThemeData.light(),
      home: Scaffold(
          appBar: AppBar(title: Text('Tabbar Example'),),
          body: TabBarView(
            children: <Widget>[
              FirstApp(),
              SecondApp(),
            ],
            controller: controller,
          ),
          bottomNavigationBar: TabBar(tabs: <Tab>[
            Tab(icon: Icon(Icons.looks_one, color: Colors.blue),),
            Tab(icon: Icon(Icons.looks_two, color: Colors.blue,)),
          ],
            controller: controller,
          )
      ),
    );


  }
}

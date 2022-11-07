import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:hello/SampleNavigationFirstPage.dart';
import 'package:hello/SampleNavigationSecondPage.dart';
import 'package:hello/fileReadJson.dart';
import 'package:hello/largeFile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'httpApp.dart';
import 'todo/TodoList.dart';
import 'todo/TodoDetail.dart';
import 'todo/TodoAdd.dart';
import 'fileApp.dart';
import 'fileReadJson.dart';
import 'introPage.dart';
import 'sqlite/DatabaseApp.dart';
import 'sqlite/AddTodoApp.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'CustomFirebaseAnalyticsPage.dart';
import 'memo/MemoAddPage.dart';
import 'memo/MemoPage.dart';
import 'memo/MemoDetailPage.dart';
import 'memo/Memo.dart';
import 'fcm/CustomFCMPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  /// firebase 
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDataBase();
    return MaterialApp(
      title: 'Subpage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        observer,
      ],
      initialRoute: "/fcm",
      routes: {
        '/firebase': (context) => CustomFirebaseAnalyticsPage(analytics, observer),
        "/todo": (context) => DatabaseApp(database),
        "/add": (context) => AddTodoApp(database),
        '/memo': (context) => MemoPage(),
        '/fcm': (context) => CustomFCM(),
      },
    );
  }

  Future<Database> initDataBase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'title TEXT, content TEXT, active BOOL)',
        );
      },
      version: 1,
    );
  }
  



}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subpage Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => TodoList(),
        "/detail": (context) => TodoDetail(),
        "/add": (context) => TodoAdd(),
      },
    );
  }
  // void _setData(int value) async {
  //   var key = 'count';
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setInt(key, value);
  // }
  // void _loadData() async {
  //   var key = 'count';
  //   SharedPreferences pref = await SharedPreferences.getInstance()
  //   setState() {
  //     var value = pref.getInt(key);
  //     if (value == null) {
  //       _counter = 0;
  //     } else {
  //       _counter = value;
  //     }
  //   }
  // }
}
*/
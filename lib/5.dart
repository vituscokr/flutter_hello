import 'package:flutter/material.dart';
import 'animalItem.dart';
import 'firstPage.dart';
import 'secondPage.dart';
import 'cupertinoMain.dart';

void main() {
  runApp(CupertinoMain());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController controller;
  List<Animal> animalList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(animalName:'벌', kind: '곤충', imagePath: 'image/bee.png'));
    animalList.add(Animal(animalName:'고양이', kind: '포유류', imagePath: 'image/cat.png'));
    animalList.add(Animal(animalName:'젖소', kind: '포유류', imagePath: 'image/cow.png'));
    animalList.add(Animal(animalName:'강아지', kind: '포유류', imagePath: 'image/dog.png'));
    animalList.add(Animal(animalName:'여우', kind: '포유류', imagePath: 'image/fox.png'));
    animalList.add(Animal(animalName:'원숭이', kind: '포유류', imagePath: 'image/monkey.png'));
    animalList.add(Animal(animalName:'돼지', kind: '포유류', imagePath: 'image/pig.png'));
    animalList.add(Animal(animalName:'늑대' ,kind: '포유류', imagePath: 'image/wolf.png'));


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
        appBar: AppBar(title: Text('ListView Example')),
        body: TabBarView(
          children: <Widget>[
            FirstApp(list: animalList),
            SecondApp(list: animalList),
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(tabs: <Tab>[
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue),),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue,)),
        ],
          controller: controller,
        ),
      ),
    );
  }
}

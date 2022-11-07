import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileReadJson extends StatefulWidget {
  const FileReadJson({Key? key}) : super(key: key);

  @override
  State<FileReadJson> createState() => _FileReadJsonState();
}

class _FileReadJsonState extends State<FileReadJson> {
  late List items;
  @override
  void initState() {

    super.initState();
    readFile();

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  readFile() async {
    List<String> items = [];
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    var firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    var fileExist = await File(dir.path + '/fruit.json').exists();

    if (firstCheck == null || firstCheck == false || fileExist == false ) {
      pref.setBool(key, true);
      final String file = await DefaultAssetBundle.of(context).loadString('resources/fruit.json');

      File(dir.path + '/fruit.json').writeAsStringSync(file);
      var items = await readJson(file);
      setState(() {
        this.items = items;
      });
    }else {
      var file = await File(dir.path + '/fruit.json').readAsString();
      var items = await readJson(file);
      setState(() {
        this.items = items;
      });

    }


    setState(() {
      this.items.add('test');
    });

    saveJson();
  }

  readJson(String str) async {
    final data = await jsonDecode(str);
    return data['fruits'];
  }

  saveJson() async {
    String data = '{"fruits":["'+ items.join("\",\"") +'"]}';

    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/fruit.json').writeAsStringSync(data);

  }
}
class Fruits {
  late List items;
  Fruits( this.items) ;

  factory Fruits.fromJson(Map<String, dynamic> json) {
    return new Fruits(json['fruits']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fruits'] = this.items;
    return data;
  }

}
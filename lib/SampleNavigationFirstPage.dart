import 'package:flutter/material.dart';
import 'package:hello/SampleNavigationSecondPage.dart';

class SampleNavigationFirstPage extends StatefulWidget {
  const SampleNavigationFirstPage({Key? key}) : super(key: key);
  @override
  State<SampleNavigationFirstPage> createState() => _SampleNavigationFirstPageState();
}

class _SampleNavigationFirstPageState extends State<SampleNavigationFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page Main'),
      ),
      body: Container(
        child: Center(
          child: Text('첫 번째 페이지'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SampleNavigationSecondPage()));
          Navigator.of(context).pushNamed("/second");

              //Navigator.of(context).popAndPushNamed(routeName)
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

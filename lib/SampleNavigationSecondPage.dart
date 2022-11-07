import 'package:flutter/material.dart';

class SampleNavigationSecondPage extends StatefulWidget {
  const SampleNavigationSecondPage({Key? key}) : super(key: key);

  @override
  State<SampleNavigationSecondPage> createState() => _SampleNavigationSecondPageState();
}

class _SampleNavigationSecondPageState extends State<SampleNavigationSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('돌아기기'),
          ),
        ),
      )
    );
  }
}

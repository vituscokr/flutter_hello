import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: WidgetApp()
    );
  }
}

class WidgetApp extends StatefulWidget {
  const WidgetApp({Key? key}) : super(key: key);

  @override
  State<WidgetApp> createState() => _WidgetAppState();
}

class _WidgetAppState extends State<WidgetApp> {
  List _buttonList = ['더하기', '빼기','곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems = [];
  String _buttonText = '';
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var item in _buttonList) {
      print(item);
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item),));
    }
    _buttonText = _buttonList.first;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('flutter'),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(keyboardType: TextInputType.number, controller: value1,),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(keyboardType: TextInputType.number, controller: value2,),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton.icon(onPressed: () {

                  setState(() {

                    int v1 = int.parse(value1.value.text);
                    int v2 = int.parse(value2.value.text);
                    var result;

                    if(_buttonText == '더하기') {
                      result = v1 + v2;
                    } else if (_buttonText == '빼기') {
                      result = v1 - v2;
                    } else if (_buttonText == '곱하기') {
                      result = v1 * v2;
                    } else  {
                      result = v1 / v2;
                    }

                    sum = '$result';
                  });
                }, icon: Icon(Icons.add), label: Text('$_buttonText'),style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.amber,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: DropdownButton(items: _dropDownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      _buttonText = value! ;
                    });
                  },
                  value: _buttonText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('결과: $sum', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

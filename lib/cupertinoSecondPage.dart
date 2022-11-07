import 'package:flutter/cupertino.dart';
import 'animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
   final List<Animal> animalList;
  const CupertinoSecondPage({Key? key, required this.animalList}) : super(key: key);

  @override
  State<CupertinoSecondPage> createState() => _CupertinoSecondPageState();
}

class _CupertinoSecondPageState extends State<CupertinoSecondPage> {
  late TextEditingController _textController;
  int _kindChoice = 0;
  bool _flyExist = false;
  var _imagePath;
  Map<int, Widget> segementWidgets = {
    0: SizedBox(
      child: Text('양서류', textAlign: TextAlign.center),
      width: 80,
    ),
    1: SizedBox(
      child: Text('포유류', textAlign: TextAlign.center),
      width: 80,
    ),
    2: SizedBox(
      child: Text('파충류', textAlign: TextAlign.center),
      width: 80,
    ),

  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('동물추가'),
      ),
        child: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(50),
                  child: CupertinoTextField(
                    controller: _textController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                  ),
                ),
                CupertinoSegmentedControl(
                    padding: EdgeInsets.only(bottom: 20, top:20),
                    groupValue: _kindChoice,
                    children: segementWidgets,
                    onValueChanged: _onValueChanged
                ),
                Row(
                  children: [
                    Text('날개가 존재합니까?'),
                    CupertinoSwitch(
                        value: _flyExist,
                        onChanged: _changeFlyExist,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        child: Image.asset('image/cow.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/cow.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/pig.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/pig.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/bee.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/bee.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/cat.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/cat.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/dog.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/dog.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/fox.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/fox.png';
                        },
                      ),
                      GestureDetector(
                        child: Image.asset('image/monkey.png', width: 80),
                        onTap: () {
                          _imagePath = 'image/monkey.png';
                        },
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  child: Text('동물 추가하기'),
                  onPressed: _actionAdd,
                ),
              ],
            ),
          ),
        ),
    );
  }

  _onValueChanged(int? value) {
    setState(() {
      _kindChoice = value!;
    });
  }
  _changeFlyExist(bool value) {
    setState(() {
      _flyExist = value;
    });
  }
  _actionAdd() {
    Animal animal = Animal(animalName: _textController.value.text, kind: getKind(_kindChoice), imagePath: _imagePath, flyExist: _flyExist);
    widget.animalList.add(animal);
  }

  getKind(int kind) {
    switch(kind) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}

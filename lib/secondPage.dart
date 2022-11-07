import 'package:flutter/material.dart';
import 'animalItem.dart';

// class SecondApp extends StatelessWidget {
//   final List<Animal> list;
//   const SecondApp({Key? key, required this.list}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//           child: Text('두번째 페이지'),
//         ),
//       ),
//     );
//   }
// }
class SecondApp extends StatefulWidget {
  final List<Animal> list;
  const SecondApp({Key? key, required this.list}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController();
  int _radioValue = 0;
  bool flyExist = false;
  var _imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
                Row(
                  children: <Widget>[
                    Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange),
                    Text('양서류'),
                    Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
                    Text('파충류'),
                    Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
                    Text('포유류'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                Row(
                  children: [
                    Text('날 수 있나요?'),
                    Checkbox(value: flyExist, onChanged: (check) {
                      setState(() {
                        flyExist = check!;
                      });
                    }),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),

                Container(
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
                ElevatedButton(onPressed: _actionAdd ,  child: Text('추가'),)
              ],
            ),
          ),
      )
    );
  }
   _radioChange(int? value) {
    setState(() {
      _radioValue = value!;
    });
  }
  _actionAdd() {
    var animal = Animal(animalName: nameController.value.text,
        kind: getKind(_radioValue),
        imagePath: _imagePath,
        flyExist: flyExist);
    AlertDialog dialog = AlertDialog(
      title: Text('동물 추가하기'),
      content: Text(
          '이 동물은 ${animal.animalName} 입니다.'
              '동물의 종류는 ${animal.kind} 입니다.\n 이 동물을 추가하시겠습니까? ',
        style: TextStyle(fontSize: 30.0),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          widget.list.add(animal);
          Navigator.of(context).pop();
        }, child: Text("예")),
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("아니요")),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) => dialog);

  }
  getKind(int value) {
    switch(value) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}

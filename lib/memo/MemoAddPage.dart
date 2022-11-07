import 'package:hello/memo/Memo.dart';
import 'package:hello/memo/MemoPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MemoAddPage extends StatefulWidget {
  final DatabaseReference reference;
  const MemoAddPage(this.reference, {Key? key}) : super(key: key);

  @override
  _MemoAddPageState createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 추가'),
      ),
      body : Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                  fillColor: Colors.blueAccent,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  decoration: InputDecoration(labelText: '내용'),
                ),
              ),
              TextButton(onPressed: () {

                print(widget.reference);

                widget.reference
                    .push()
                    .set(Memo(
                  titleController.value.text,
                  contentController.value.text,
                  DateTime.now().toIso8601String()
                ).toJson())
                    .then((_) {
                      print('done');
                      Navigator.of(context).pop();
                });
              },
                  child: Text('저장하기'),
              ),

            ],
          )
        ),
      )
    );
  }
}

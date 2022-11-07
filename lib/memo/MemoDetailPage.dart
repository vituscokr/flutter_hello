import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hello/memo/Memo.dart';

class MemoDetailPage extends StatefulWidget {
  final DatabaseReference reference;
  final Memo memo;
  const MemoDetailPage(this.reference, this.memo, {Key? key}) : super(key: key);

  @override
  _MemoDetailPageState createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.memo.title);
    contentController = TextEditingController(text: widget.memo.content);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                  fillColor: Colors.blueAccent
                ),
              ),
              Expanded(
                  child: TextField(
                    controller: contentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 100,
                    decoration: InputDecoration(labelText: '내용'),
                  )
              ),
              TextButton(
                  onPressed: _actionEdit,
                  child: Text('수정하기'))
            ],
          ),
        ),
      )
    );
  }
  /// 수정하기
  _actionEdit() {
    Memo memo = Memo(
      titleController.value.text,
      contentController.value.text,
      widget.memo.createTime
    );
    widget.reference
    .child(widget.memo.key.toString())
    .set(memo.toJson())
    .then( (_) {
      Navigator.of(context).pop(memo);
    });
  }
}

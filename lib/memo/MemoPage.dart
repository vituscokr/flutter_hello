import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hello/memo/Memo.dart';
import 'package:hello/memo/MemoAddPage.dart';
import 'package:hello/memo/MemoDetailPage.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  _MemoPageState createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  late FirebaseDatabase _database;
  late DatabaseReference reference;
  String _databaseURL = 'https://sample-ab3b0.firebaseio.com/';
  List<Memo> items = [];



  @override
  void initState() {
    super.initState();
    _database =  FirebaseDatabase.instance;
    reference = _database.ref('memos');
    reference.onChildAdded.listen((event) { 
      print(event.snapshot.value.toString());
      setState(() {
        items.add(Memo.fromSnapshot(event.snapshot));
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메모 앱'),
      ),
      body : Container(
        child : Center (
          child: items.length == 0
              ?
          CircularProgressIndicator()
              :
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: GridTile(
                        child: Container(
                          padding: EdgeInsets.only(top:20, bottom: 20),
                          child: SizedBox(
                            child: GestureDetector(
                              onTap: () async {
                                Memo memo = await Navigator.of(context).push(
                                  MaterialPageRoute(builder: (BuildContext context) => MemoDetailPage(reference, items[index]))
                                );
                                if (memo != null) {
                                  setState(() {
                                    items[index].title = memo.title;
                                    items[index].content = memo.content;
                                  });
                                }
                              },
                              onLongPress:  () {
                                showDialog(context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(items[index].title),
                                        content: Text('삭제하시겠습니까?'),
                                        actions: [
                                          TextButton(onPressed: () {
                                            reference
                                                .child(items[index].key.toString())
                                                .remove()
                                                .then((_) {
                                              setState(() {
                                                items.removeAt(index);
                                                Navigator.of(context).pop();
                                              });
                                            });
                                          },
                                              child: Text('예')),
                                          TextButton(onPressed: () {
                                            Navigator.of(context).pop();
                                          }, child: Text('아니요')),
                                        ],
                                      );
                                    });
                              }

                              ,
                              child: Text(items[index].content),
                            ),
                          ),
                        ),
                        header: Text(items[index].title),
                        footer: Text(items[index].createTime.substring(0,10)),
                      ),
                    );
                  },
              itemCount: items.length,)
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MemoAddPage(reference))
          );
        },
        child: Icon(Icons.add),

      ),
    );
  }

}

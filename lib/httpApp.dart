import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';

class HttpApp extends StatefulWidget {
  const HttpApp({Key? key}) : super(key: key);

  @override
  State<HttpApp> createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  late List data = [];
  TextEditingController _editingController = TextEditingController();
  ScrollController _scrollController =  ScrollController();
  int _page = 1;
  @override
  void initState() {
    super.initState();
    data = [];
    //_editingController = TextEditingController();
    _scrollController.addListener(() {
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent &&
      !_scrollController.position.outOfRange) {
        _page++;
        getJSONData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요.'),
        ),
      ),
      body: Container(
        child: Center(
          child:
            data.length == 0
                ?
            Text('데이터가 없습니다.',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            )
                :
                ListView.builder(itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      child: Row(
                        children: [
                          Image.network(
                            data[index]['thumbnail'],
                            height:100,
                            width:100,
                            fit: BoxFit.contain,
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  data[index]['title'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text('저자 : ${data[index]['authors'].toString()}'),
                              Text('가격 : ${data[index]['sale_price'].toString()}'),
                              Text('판매중 : ${data[index]['status'].toString()}'),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );

                },
                itemCount: data.length,
                controller: _scrollController,
                )
          ,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetch,
        child: Icon(Icons.file_download),
      ),
    );
  }
  _download() async {
    var url = Uri.https('www.google.com');
    var response = await http.get(url);
    setState(() {
      result = response.body;
    });
  }
  _fetch() async {
    _page  = 1;
    data.clear();
    getJSONData();
  }
   getJSONData() async {
    var queryParameters = {
      'target': 'title',
      'page': '${_page}',
      'query': '${_editingController.value.text}',
    };
    print(_editingController.value.text);
    var url = Uri.https('dapi.kakao.com','/v3/search/book' , queryParameters);
    var response = await http.get(url,
      headers: {
        "Authorization": "KakaoAK 78c0a30c6c35e6107fa77b814716c427"
      },
    );
    setState(() {
      // result = response.body;
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      print(result);
      data.addAll(result);
    });

  }
}

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFile extends StatefulWidget {
  const LargeFile({Key? key}) : super(key: key);

  @override
  State<LargeFile> createState() => _LargeFileState();
}

class _LargeFileState extends State<LargeFile> {
  final imgUrl = 'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress';
  bool downloading = false;
  var progressString = "";
  var file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Large File Example'),
      ),
      body: Center(
        child:
        downloading
        ?
        Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text('Downloading File : $progressString',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                ),

              ],
            ),
          ),
        )
        :
        FutureBuilder(
          builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return Text('데이터 없음');
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                //return Text('데이터 있음');
                 return Center(
                   child: Column(
                     children: [
                       Image.file(File(file))
                     ],
                   ),
                 );
              }
          }
          return Text('데이터 없음');
        },
        future: downloadWidget(file),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download),
        onPressed: _donwloadFile,
      ),
    );
  }

  _donwloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(
          imgUrl,
          '${dir.path}/myimage.jpg' ,
          onReceiveProgress: (rec, total) {
            print('Rec: $rec, Total : $total'); 
            file = '${dir.path}/myimage.jpg';
            setState(() {
              downloading = true; 
              progressString = ((rec/total) * 100).toStringAsFixed(0) + "%";
            });
          });

    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    print('Download Complted');

  }

  downloadWidget(String? filepath) async {
    File file = File(filepath!);
    bool exist = await file.exists();
    FileImage(file).evict();

    if(exist) {
      return Center(
        child: Column(
          children: [
            Image.file(File(filepath))
          ],
        ),
      );
    } else {
      return Text('No Data');
    }
  }
}

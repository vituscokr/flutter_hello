import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class CustomFirebaseAnalyticsPage extends StatefulWidget {
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  const CustomFirebaseAnalyticsPage(this.analytics, this.observer, {Key? key}) : super(key: key);
  @override
  _CustomFirebaseAnalyticsPageState createState() => _CustomFirebaseAnalyticsPageState(analytics, observer);
}

class _CustomFirebaseAnalyticsPageState extends State<CustomFirebaseAnalyticsPage> {
  final FirebaseAnalyticsObserver observer;
  final FirebaseAnalytics analytics;
  String _message = '';
  _CustomFirebaseAnalyticsPageState(this.analytics, this.observer);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: sendAnalyticsEvent, child: Text('테스트')),
            Text(_message, style: TextStyle(color:Colors.blueAccent)),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.tab), onPressed: () {},
      ),
    );
  }

  setMessage(String message) {
    setState(() {
      _message = message;
    });
  }
  sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String,dynamic> {
        'string': 'hello flutter',
        'int': 100,
      },
    );
    setMessage('Analytics 보내기 성공');
  }
}

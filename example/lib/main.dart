import 'package:flutter/material.dart';
import 'package:phone_call_notifier/phone_call_notifier.dart';

void main() {
  runApp(MyApp());
}

class CallRecord {
  final DateTime time;
  final PhoneCallEvent event;

  CallRecord(this.time, this.event);

  factory CallRecord.now(PhoneCallEvent event) {
    return CallRecord(DateTime.now(), event);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var calls = <CallRecord>[];

  @override
  void initState() {
    super.initState();

    PhoneCallNotifier().listen.forEach((event) {
      setState(() {
        calls.add(CallRecord.now(event));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Phone Call Notifier')),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: calls.length,
          itemBuilder: (context, i) {
            var call = calls[i];
            return ListTile(
              title: Text(call.event.toString()),
              subtitle: Text(call.time.toString()),
            );
          },
        ),
      ),
    );
  }
}

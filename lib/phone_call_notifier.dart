import 'dart:async';

import 'package:flutter/services.dart';

enum PhoneCallEvent { IDLE, RINGING, OFFHOOK }

class PhoneCallNotifier {
  static const _channel = const EventChannel('ir.aligator.phonecallnotifier');

  Stream<PhoneCallEvent> get listen => _channel.receiveBroadcastStream().map(
        (event) => event is int
            ? PhoneCallEvent.values[event]
            : throw event.toString(),
      );
}

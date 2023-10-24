import 'dart:io';

import 'package:flutter/widgets.dart';

class Message {
  final String msgId;
  final String message;
  final File? attachment;
  final DateTime timeStamp;
  final bool isSender;
  Message({
    required this.msgId,
    required this.message,
    this.attachment,
    required this.timeStamp,
    required this.isSender,
  });

  Message copyWith({
    String? msgId,
    String? message,
    ValueGetter<File?>? attachment,
    DateTime? timeStamp,
    bool? isSender,
  }) {
    return Message(
      msgId: msgId ?? this.msgId,
      message: message ?? this.message,
      attachment: attachment != null ? attachment() : this.attachment,
      timeStamp: timeStamp ?? this.timeStamp,
      isSender: isSender ?? this.isSender,
    );
  }
}

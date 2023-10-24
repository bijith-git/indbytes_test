import 'dart:io';

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
}

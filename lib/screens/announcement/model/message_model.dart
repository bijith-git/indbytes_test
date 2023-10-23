import 'dart:io';

class Message {
  final String msgId;
  final String message;
  final File? attachment;
  Message({
    required this.msgId,
    required this.message,
    this.attachment,
  });
}

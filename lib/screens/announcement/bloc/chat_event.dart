part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String message;
  const SendMessageEvent(this.message);
}

class SendFileEvent extends ChatEvent {
  final String filePath;
  const SendFileEvent(this.filePath);
}

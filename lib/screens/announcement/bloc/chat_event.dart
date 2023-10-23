part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String id;
  final File? file;
  final String message;
  SendMessageEvent({
    this.file,
    required this.message,
    required this.id,
  });
}

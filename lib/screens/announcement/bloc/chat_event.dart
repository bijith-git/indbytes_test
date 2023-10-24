part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final Message message;
  const SendMessageEvent({required this.message});
  @override
  List<Object?> get props => [message];
}

class SelectFileFromStorage extends ChatEvent {
  final File? file;
  const SelectFileFromStorage({this.file});
  @override
  List<Object?> get props => [file];
}

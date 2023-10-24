part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class InitialChatState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<Message> messages;
  const ChatLoadedState(this.messages);
  @override
  List<Object> get props => [messages];
}

class SelectedFile extends ChatState {
  final File file;
  const SelectedFile({required this.file});
  @override
  List<Object> get props => [file];
}

class ChatErrorState extends ChatState {
  final String? errorMessages;
  const ChatErrorState({this.errorMessages});
  @override
  List<Object?> get props => [errorMessages];
}

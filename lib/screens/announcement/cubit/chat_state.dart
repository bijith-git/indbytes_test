part of 'chat_cubit.dart';

// Define states
abstract class ChatState {}

class InitialChatState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<String> messages;
  ChatLoadedState(this.messages);
}

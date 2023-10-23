import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _chatController = StreamController<ChatState>.broadcast();
  ChatBloc() : super(InitialChatState()) {
    on<SendMessageEvent>(sendHandler);
  }

  List<Message> _messages = [];

  Stream<ChatState> get chatStream => _chatController.stream;

  void sendHandler(SendMessageEvent event, Emitter<ChatState> emit) async {
    _messages.add(Message(
      msgId: event.id,
      message: event.message,
      attachment: event.file,
    ));

    _chatController.add(ChatLoadedState(List.from(_messages)));
  }

  void dispose() {
    _chatController.close();
  }
}

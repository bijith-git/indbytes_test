import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:indbytes_test/test.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _chatController = StreamController<ChatState>.broadcast();

  List<Message> _messages = [];

  Stream<ChatState> get chatStream => _chatController.stream;
  ChatBloc() : super(InitialChatState()) {
    on<ChatEvent>((event, emit) {});
  }

  void handleEvent(ChatEvent event) async {
    if (event is SendMessageEvent) {
      _messages.add(Message(message: event.message, type: 'String'));
    } else if (event is SendFileEvent) {
      _messages.add(Message(message: event.filePath, type: 'img'));
    }

    _chatController.add(ChatLoadedState(List.from(_messages)));
  }

  void dispose() {
    _chatController.close();
  }
}

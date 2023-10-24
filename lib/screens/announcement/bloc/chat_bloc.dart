import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _chatController = StreamController<ChatState>.broadcast();
  ChatBloc() : super(InitialChatState()) {
    on<SelectFileFromStorage>(callFilePicker);
    on<SendMessageEvent>(sendHandler);
  }

  final List<Message> _messages = [];

  Stream<ChatState> get chatStream => _chatController.stream;

  void sendHandler(SendMessageEvent event, Emitter<ChatState> emit) async {
    _messages.add(event.message);
    emit(ChatLoadedState(_messages));

    _chatController.add(ChatLoadedState(List.from(_messages)));
  }

  callFilePicker(SelectFileFromStorage event, Emitter<ChatState> emit) async {
    emit(SelectedFile(file: event.file!));
  }

  void dispose() {
    _chatController.close();
  }
}

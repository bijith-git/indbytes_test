import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ChatScreen(
      bloc: ChatBloc(),
    ),
  ));
}

class Message {
  final String message;
  final File? attachment;
  final String type;
  Message({
    required this.message,
    this.attachment,
    required this.type,
  });
}

// Define events
abstract class ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  SendMessageEvent(this.message);
}

class SendFileEvent extends ChatEvent {
  final File file;
  final String? message;
  SendFileEvent(this.file, this.message);
}

// Define states
abstract class ChatState {}

class InitialChatState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<Message> messages;

  ChatLoadedState(this.messages);
}

// Define BLoC
class ChatBloc {
  final _chatController = StreamController<ChatState>.broadcast();

  List<Message> _messages = [];

  Stream<ChatState> get chatStream => _chatController.stream;

  void handleEvent(ChatEvent event) async {
    if (event is SendMessageEvent) {
      _messages.add(Message(message: event.message, type: 'String'));
    } else if (event is SendFileEvent) {
      _messages.add(Message(
          message: event.message ?? "", attachment: event.file, type: 'img'));
    }

    _chatController.add(ChatLoadedState(List.from(_messages)));
  }

  void dispose() {
    _chatController.close();
  }
}

// Create the UI
class ChatScreen extends StatefulWidget {
  final ChatBloc bloc;

  ChatScreen({required this.bloc});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: widget.bloc.chatStream,
              initialData: InitialChatState(),
              builder: (context, snapshot) {
                if (snapshot.data is ChatLoadedState) {
                  List<Message> messages =
                      (snapshot.data as ChatLoadedState).messages;

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var msg = messages[index];
                      return msg.attachment != null
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Image.file(
                                msg.attachment!,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerRight,
                              child: Text(messages[index].message),
                            );
                    },
                  );
                }

                return const Center(child: Text("NO Chat "));
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'pdf', 'doc'],
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    widget.bloc.handleEvent(
                        SendFileEvent(file, _messageController.text));
                  } else {
                    // User canceled the picker
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  widget.bloc
                      .handleEvent(SendMessageEvent(_messageController.text));
                  _messageController.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Chat App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: ChatScreen(),
//     );
//   }
// }

// // Events
// abstract class ChatEvent extends Equatable {}

// class SendMessage extends ChatEvent {
//   final String message;
//   SendMessage(this.message);

//   @override
//   List<Object?> get props => [message];
// }

// class SendImage extends ChatEvent {
//   final String imagePath;
//   SendImage(this.imagePath);

//   @override
//   List<Object?> get props => [imagePath];
// }

// // States
// abstract class ChatState extends Equatable {}

// class InitialChatState extends ChatState {
//   @override
//   List<Object> get props => [];
// }

// class ChatLoaded extends ChatState {
//   final List<String> messages;
//   ChatLoaded(this.messages);

//   @override
//   List<Object> get props => [messages];
// }

// // BLoC
// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final List<String> chatList = ['dfsfs'];

//   ChatBloc() : super(InitialChatState());

//   Stream<ChatState> mapEventToState(ChatEvent event) async* {
//     if (event is SendMessage) {
//       chatList.add(event.message);
//       yield ChatLoaded(chatList);
//     } else if (event is SendImage) {
//       // Handle image sending here
//     }
//   }
// }

// class ChatScreen extends StatelessWidget {
//   final TextEditingController messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat App'),
//       ),
//       body: BlocProvider(
//         create: (context) => ChatBloc(),
//         child: BlocBuilder<ChatBloc, ChatState>(
//           builder: (context, state) {
//             if (state is ChatLoaded) {
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: state.messages.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(state.messages[index]),
//                         );
//                       },
//                     ),
//                   ),
//                   _buildMessageInput(context),
//                 ],
//               );
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageInput(BuildContext context) {
//     final chatBloc = BlocProvider.of<ChatBloc>(context);
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: messageController,
//             decoration: InputDecoration(
//               hintText: 'Type a message',
//             ),
//           ),
//         ),
//         IconButton(
//           icon: Icon(Icons.send),
//           onPressed: () {
//             final message = messageController.text;
//             if (message.isNotEmpty) {
//               chatBloc.add(SendMessage(message));
//               messageController.clear();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

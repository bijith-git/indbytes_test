import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indbytes_test/screens/announcement/bloc/chat_bloc.dart';
import 'package:indbytes_test/screens/announcement/model/message_model.dart';
import 'package:indbytes_test/screens/announcement/view/widgets/message_tile.dart';
import 'package:uuid/uuid.dart';

class ChatSection extends StatefulWidget {
  const ChatSection({super.key});

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  File? file;
  TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: BlocProvider.of<ChatBloc>(context).chatStream,
              initialData: InitialChatState(),
              builder: (context, snapshot) {
                if (snapshot.data is ChatLoadedState) {
                  List<Message> messages =
                      (snapshot.data as ChatLoadedState).messages;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var msg = messages[index];
                      return MessageTile(msg: msg);
                    },
                  );
                }

                return const Center(child: Text("Start announcement"));
              },
            ),
          ),
          Positioned(
            bottom: 0,
            // alignment: Alignment.bottomCenter,
            child: BlocListener(
              bloc: BlocProvider.of<ChatBloc>(context),
              listener: (_, state) {
                if (file != null) {}
              },
              listenWhen: (_, state) {
                if (file != null) {
                  return true;
                }
                return true;
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: messageController,
                        validator: (value) {
                          if (value!.isEmpty && file == null) {
                            return 'Enter your message';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your announcement here',
                          fillColor: Colors.grey[300],
                          filled: true,
                        ),
                        maxLines: 4,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                backgroundColor: Colors.grey[500],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 3),
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['jpg', 'pdf', 'doc'],
                              );

                              if (result != null) {
                                file = File(result.files.single.path!);
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.attach_file),
                                Text("Attach file")
                              ],
                            )),
                        file != null
                            ? Container(
                                alignment: Alignment.topLeft,
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(file!),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : const SizedBox(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder()),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<ChatBloc>(context).add(
                                  SendMessageEvent(
                                      id: const Uuid().v4(),
                                      file: file,
                                      message: messageController.text));
                              messageController.clear();
                              file = null;
                            }
                          },
                          child: const Icon(Icons.send_rounded),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: BlocListener(
      //   bloc: BlocProvider.of<ChatBloc>(context),
      //   listener: (_, state) {
      //     if (file != null) {}
      //   },
      //   listenWhen: (_, state) {
      //     if (file != null) {
      //       return true;
      //     }
      //     return true;
      //   },
      //   child: Container(
      //     margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10),
      //       color: Colors.grey[300],
      //     ),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Form(
      //           key: formKey,
      //           child: TextFormField(
      //             controller: messageController,
      //             validator: (value) {
      //               if (value!.isEmpty && file == null) {
      //                 return 'Enter your message';
      //               }
      //               return null;
      //             },
      //             decoration: InputDecoration(
      //               border: InputBorder.none,
      //               hintText: 'Enter your announcement here',
      //               fillColor: Colors.grey[300],
      //               filled: true,
      //             ),
      //             maxLines: 4,
      //           ),
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             ElevatedButton(
      //                 style: ElevatedButton.styleFrom(
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 8, vertical: 5),
      //                     backgroundColor: Colors.grey[500],
      //                     shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(5)),
      //                     elevation: 3),
      //                 onPressed: () async {
      //                   FilePickerResult? result =
      //                       await FilePicker.platform.pickFiles(
      //                     type: FileType.custom,
      //                     allowedExtensions: ['jpg', 'pdf', 'doc'],
      //                   );

      //                   if (result != null) {
      //                     file = File(result.files.single.path!);
      //                   } else {
      //                     // User canceled the picker
      //                   }
      //                 },
      //                 child: const Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     Icon(Icons.attach_file),
      //                     Text("Attach file")
      //                   ],
      //                 )),
      //             file != null
      //                 ? Container(
      //                     alignment: Alignment.topLeft,
      //                     width: 60,
      //                     height: 60,
      //                     decoration: BoxDecoration(
      //                         image: DecorationImage(
      //                             image: FileImage(file!), fit: BoxFit.cover),
      //                         borderRadius: BorderRadius.circular(10)),
      //                   )
      //                 : const SizedBox(),
      //             ElevatedButton(
      //               style:
      //                   ElevatedButton.styleFrom(shape: const CircleBorder()),
      //               onPressed: () {
      //                 if (formKey.currentState!.validate()) {
      //                   BlocProvider.of<ChatBloc>(context).add(SendMessageEvent(
      //                       id: const Uuid().v4(),
      //                       file: file,
      //                       message: messageController.text));
      //                   messageController.clear();
      //                   file = null;
      //                 }
      //               },
      //               child: const Icon(Icons.send_rounded),
      //             ),
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:indbytes_test/main.dart';
import 'package:indbytes_test/screens/announcement/model/message_model.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

class MessageTile extends StatelessWidget {
  final Message msg;
  const MessageTile({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(msg.attachment!.absolute.runtimeType);
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
          minWidth: MediaQuery.of(context).size.width / 2.2,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: mainAppColor.withOpacity(.3),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 5,
                  bottom: 30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      msg.message,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    msg.attachment != null
                        ? InkWell(
                            onTap: () {
                              OpenFilex.open(msg.attachment!.path);
                            },
                            child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width /
                                            2.5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(msg.attachment!),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        msg.attachment!.path.split('/').last,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy hh:mm a').format(msg.timeStamp),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 10, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.done_all,
                      size: 16,
                      color: Colors.white60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

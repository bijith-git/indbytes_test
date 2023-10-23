import 'package:flutter/material.dart';
import 'package:indbytes_test/screens/announcement/model/message_model.dart';

class MessageTile extends StatelessWidget {
  final Message msg;
  const MessageTile({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        // width: MediaQuery.of(context).size.width / 2,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor.withOpacity(.3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            msg.attachment != null
                ? Image.file(
                    msg.attachment!,
                    width: 100,
                    height: 100,
                  )
                : Container(),
            Text(msg.message),
          ],
        ),
      ),
    );
  }
}

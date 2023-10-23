import 'package:flutter/material.dart';
import 'package:indbytes_test/main.dart';
import 'package:indbytes_test/screens/announcement/view/announcement_chat.dart';
import 'package:indbytes_test/screens/announcement/view/widgets/class_drop_down.dart';
import 'package:indbytes_test/screens/announcement/view/widgets/create_announcemnt_widget.dart';

class AnouncementScreen extends StatefulWidget {
  const AnouncementScreen({super.key});

  @override
  State<AnouncementScreen> createState() => _AnouncementScreenState();
}

class _AnouncementScreenState extends State<AnouncementScreen> {
  bool isChat = false;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).primaryColor,
            ),
          ),
          title: Text(
            "Annoucement",
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Row(
              children: [
                Expanded(
                  child: TabBar(
                      indicatorColor: mainAppColor,
                      labelColor: mainAppColor,
                      isScrollable: true,
                      labelStyle: textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold, letterSpacing: .5),
                      unselectedLabelStyle:
                          textTheme.labelLarge!.copyWith(letterSpacing: .5),
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(
                          text: "Announcement",
                        ),
                        Tab(
                          text: "Notes",
                        )
                      ]),
                ),
                const ClassDropDownWidget()
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          Center(
              child: isChat
                  ? const ChatSection()
                  : CreateAnnouncementWidget(
                      title: "You can create announcement to your classes",
                      buttonTitle: "Create announcement",
                      onPressed: () {
                        isChat = !isChat;
                        setState(() {});
                      },
                    )),
          Center(
              child: CreateAnnouncementWidget(
            title: "You can create note to your classes",
            buttonTitle: "Create note",
            onPressed: () {},
          ))
        ]),
      ),
    );
  }
}

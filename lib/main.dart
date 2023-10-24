import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indbytes_test/screens/announcement/bloc/chat_bloc.dart';
import 'package:indbytes_test/screens/announcement/view/announcement.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(),
      child: MaterialApp(
        title: 'Indbytes machine test',
        theme: ThemeData(
            primaryColor: mainAppColor,
            primarySwatch: mainAppColor,
            useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    foregroundColor: Colors.white,
                    backgroundColor: mainAppColor))),
        home: const AnouncementScreen(),
      ),
    );
  }
}

MaterialColor mainAppColor = const MaterialColor(
  0xff763879,
  <int, Color>{
    50: Color(0xff763879),
    100: Color(0xff763879),
    200: Color(0xff763879),
    300: Color(0xff763879),
    400: Color(0xff763879),
    500: Color(0xff763879),
    600: Color(0xff763879),
    700: Color(0xff763879),
    800: Color(0xff763879),
    900: Color(0xff763879),
  },
);

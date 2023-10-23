import 'package:flutter/material.dart';

class ClassDropDownWidget extends StatelessWidget {
  const ClassDropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[400],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "Class",
            style: textTheme.labelSmall,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "Grade 1A english",
            style: textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}

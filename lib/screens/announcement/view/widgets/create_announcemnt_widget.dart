import 'package:flutter/material.dart';

class CreateAnnouncementWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String buttonTitle;
  const CreateAnnouncementWidget({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.buttonTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: textTheme.bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

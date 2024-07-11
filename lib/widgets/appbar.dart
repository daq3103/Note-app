import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      title: const Padding(
        padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Note.d",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Enjoy note taking with friends",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/avt.png"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

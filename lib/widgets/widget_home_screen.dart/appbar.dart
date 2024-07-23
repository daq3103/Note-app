import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarHomeSreen extends ConsumerWidget implements PreferredSizeWidget  {
  const AppBarHomeSreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =
        ref.watch(themeNotifierProvider); // Đọc theme từ ThemeNotifier
    return AppBar(
      toolbarHeight: 70,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
        child: Row(
          children: [
// title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// text appbar
                Text(
                  "Note.d",
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 32),
                ),
                Text(
                  "Enjoy note taking with friends",
                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                ),
              ],
            ),
            const Spacer(),
            const Row(
              children: [
// avatar
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
  
  @override
  Size get preferredSize => const Size.fromHeight(70);
}

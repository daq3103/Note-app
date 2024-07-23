import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/note_riverpod.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarContent extends HookConsumerWidget implements PreferredSizeWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTheme = ref.watch(themeNotifierProvider);
    final isFont = useState<bool>(true);
    final setTheme = ref.read(themeNotifierProvider.notifier);
    return AppBar(
      title: Row(
        children: [
          const Text(
            'Back',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
// select picture
          IconButton(
            onPressed: () {
              ref.read(noteNotifierProvider.notifier).selectImage();
            },
            icon: Image.asset(
              'assets/images/picture_icon.png',
              color: getTheme.iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/file_icon.png',
              color: getTheme.iconTheme.color,
            ),
          ),
// select font-family
          IconButton(
            onPressed: () {
              isFont.value = !isFont.value;
              setTheme.toggleFont(isFont.value);
            },
            icon: Image.asset(
              'assets/images/font_icon.png',
              color: getTheme.iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
   @override
  Size get preferredSize => const Size.fromHeight(70);
}

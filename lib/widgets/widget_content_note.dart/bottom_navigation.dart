import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigation extends HookConsumerWidget {
  const BottomNavigation({
    super.key,
    required this.onSave,
  });
  final VoidCallback onSave;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTheme = ref.watch(themeNotifierProvider);
    final isTheme = useState<bool>(false);
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                isTheme.value = !isTheme.value;
                ref
                    .read(themeNotifierProvider.notifier)
                    .toggleTheme(isTheme.value);
              },
              icon: Image.asset(
                'assets/images/darkmode_icon.png',
                color: getTheme.iconTheme.color,
              ),
            ),
            IconButton(
              onPressed: () {
                onSave();
              },
              icon: Image.asset(
                'assets/images/storage_icon.png',),
            ),
          ],
        ),
      ),
    );
  }
}

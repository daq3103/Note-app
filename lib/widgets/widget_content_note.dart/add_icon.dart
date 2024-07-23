import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/note_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddIcon extends ConsumerWidget {
  const AddIcon({super.key, required this.addText, required this.onPressed});
  final void Function(BuildContext context, NoteNotifier notifier) onPressed;
  final String addText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(noteNotifierProvider.notifier);
    return Row(
      children: [
        IconButton(
          onPressed: () {
            onPressed(context, notifier);
          },
          icon: Image.asset('assets/images/add_icon.png'),
        ),
        Text(
          addText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xff98A2B3),
          ),
        ),
      ],
    );
  }
}

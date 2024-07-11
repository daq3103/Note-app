import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/notes_riverpod.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteListNotifierProvider);
    final theme =
        ref.watch(themeNotifierProvider); // Đọc theme từ ThemeNotifier
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
          child: Row(
            children: [
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
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(21, 24, 21, 0),
        child: MasonryGridView.builder(
          // itemCount + 1 để thêm 1 item mới
          // Ví dụ: itemCount = 3 thì sẽ có 4 item
          // 3 item từ notes và 1 item mới
          itemCount: notes.length + 1,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                height: 171,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  border: Border.all(
                    color: const Color(0xffB9E6FE),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/contentScreen');
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    const Text("New Note"),
                  ],
                ),
              );
            }
            final note = notes[index - 1];
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(
                  color: const Color(0xffE4E7EC),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    note.title,
                    style: theme.textTheme.bodyMedium!.copyWith(fontSize: 20),
                  ),
                  Text(
                    note.content,
                  ),
                  // hiển thị text new line
                  if (note.additionalContents != null) 
                  Text(note.additionalContents.toString()),
                  if (note.image != null)
                    Image.file(
                      File(note.image!),
                      width: 50,
                      height: 100,
                    ),
                  if (note.link != null) 
                  Text(note.link.toString()),
                  Text(
                    note.time,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

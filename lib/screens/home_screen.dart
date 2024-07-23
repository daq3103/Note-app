import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/custom_animation.dart';
import 'package:flutter_application_1/riverpod/notes_riverpod.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_application_1/screens/update_note_screen.dart';
import 'package:flutter_application_1/widgets/widget_home_screen.dart/add_container.dart';
import 'package:flutter_application_1/widgets/widget_home_screen.dart/appbar.dart';
import 'package:flutter_application_1/widgets/widget_home_screen.dart/delete_note.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getnotes = ref.watch(noteListNotifierProvider);
    final setnotes = ref.read(noteListNotifierProvider.notifier);
    return Scaffold(
      appBar: const AppBarHomeSreen(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(21, 24, 21, 0),
        child: MasonryGridView.builder(
          itemCount: getnotes.length + 1,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
          itemBuilder: (context, index) {
            if (index == 0) {
// shows add_button
              return const ContainerAddNote();
            }
           final note = getnotes[index - 1];
    
// shows note
            return GestureDetector(
              onLongPress: () {
// shows remove note
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        ConfirmDeleteDialog(onConfirm: () {
                          setnotes.remove(note);
                        }));
              },
// select note display
              child: InkWell(
                onTap: () {
                  final selectNote = setnotes.selectNote(note);
                  // use custom animation
                  ref.read(customAnimationProvider.notifier).navigateWithCustomAnimation(
                    context,
                    DisPlayContentScreen(note: selectNote),
                  );
                  ref.read(noteListNotifierProvider.notifier).getLstNote();
                },
                child: Container(
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
// Display Note Title
                      Text(
                        note.title,
                        style: ref
                            .watch(themeNotifierProvider)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 20),
                      ),

// Display Note Content
                      Text(
                        note.content,
                      ),
// Display Text New Line
                      note.additionalContents != null ?
                        Text(note.additionalContents.toString()) : Container(),
// Display Image if have
                      if (note.image != null)
                        Image.file(
                          File(note.image!),
                          width: 50,
                          height: 100,
                        ),
// Display textLink if have
                      if (note.link != null) Text(note.link.toString()),
                      Text(
                        note.time,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

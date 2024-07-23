import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/riverpod/note_riverpod.dart';
import 'package:flutter_application_1/riverpod/notes_riverpod.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_application_1/widgets/widget_content_note.dart/add_icon.dart';
import 'package:flutter_application_1/widgets/widget_content_note.dart/bottom_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DisPlayContentScreen extends HookConsumerWidget {
  DisPlayContentScreen({super.key, required this.note});
  final Note note;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTheme = ref.watch(themeNotifierProvider);
    final setTheme = ref.read(themeNotifierProvider.notifier);
    final titleController = useTextEditingController(text: note.title);
    final contentController = useTextEditingController(text: note.content);
    final getNote = ref.watch(noteNotifierProvider);
    final isFont = useState<bool>(true);
    // gán giá trị mặc định cho TextEditingController
    final listNewLineText = useState<List<TextEditingController>>(note
            .additionalContents
            ?.map((toElement) => TextEditingController(text: toElement))
            .toList() ??
        []);
// add new line
    void addNewLine() {
      listNewLineText.value = [
        ...listNewLineText.value,
        TextEditingController()
      ];
    }
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(21, 24, 21, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
// title TextFormField
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    style: getTheme.textTheme.bodyLarge!.copyWith(fontSize: 32),
                    controller: titleController,

                    decoration: const InputDecoration(
                      hintText: 'title',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    maxLines: null, // Cho phép mở rộng không giới hạn dòng
                    minLines: 1,
                  ),
                ),
// content TextFormField
                Padding(
                  padding: const EdgeInsets.only(bottom: 86),
                  child: TextFormField(
                    style: getTheme.textTheme.bodyLarge!.copyWith(fontSize: 18),
                    controller: contentController,
                    decoration: const InputDecoration(
                      hintText: 'Content',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some content';
                      }
                      return null;
                    },
                    maxLines: null,
                    minLines: 1,
                  ),
                ),
// new line TextFormField
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      ...List.generate(listNewLineText.value.length, (index) {
                        final controller = listNewLineText.value[index];
                        return Dismissible(
                          background: Container(
                            color: Colors.red,
                          ),
                          key: ValueKey(listNewLineText.value[index]),
                          onDismissed: (DismissDirection direction) {
                            listNewLineText.value.removeAt(index);
                          },
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: 'New ${index + 1}',
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            minLines: 1,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
// display image if have
                note.image != null
                    ? Image.file(
                        File(note.image!),
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      )
                    : Container(),
// display link
                note.link != null
                    ? InkWell(
                        onTap: () {
                          ref
                              .read(noteNotifierProvider.notifier)
                              .launchUrlGoogle(note.link.toString());
                        },
                        child: Text(note.link.toString()))
                    : Container(),
// Button add
                Column(
                  children: [
// add new line
                    AddIcon(
                      addText: 'Add a new line',
                      onPressed: (context, notifier) {
                        addNewLine();
                      },
                    ),
// add new link
                    AddIcon(
                        addText: 'Add a link',
                        onPressed: (context, notifier) {
                          ref
                              .read(noteNotifierProvider.notifier)
                              .showTextInputDialog(context);
                        }),
// add picture
                    AddIcon(
                      addText: 'Add a featured photo',
                      onPressed: (context, notifier) {
                        ref.read(noteNotifierProvider.notifier).selectImage();
                      },
                    ),
                    AddIcon(
                      addText: 'Add a new emoji',
                      onPressed: (context, notitier) {
                        // Thực hiện hành động cho "Add a new emoji"
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 180,
                ),
              ],
            ),
          ),
        ),
      ),
// add note , theme
      bottomNavigationBar: BottomNavigation(
        onSave: () {
          if (_formKey.currentState!.validate()) {
            final String title = titleController.text;
            final String content = contentController.text;
            List<String> additionalContents = listNewLineText.value
                .map((controller) => controller.text)
                .toList();
            ref.read(noteListNotifierProvider.notifier).updateNote(
                  Note(
                      idNote: note.idNote,
                      title: title,
                      content: content,
                      image: getNote?.image == null ? null : getNote!.image,
                      link: getNote?.link == null ? null : getNote!.link,
                      additionalContents: additionalContents),
                );
            Navigator.pop(context, 'Note update');
          }
        },
      ),
    );
  }
}

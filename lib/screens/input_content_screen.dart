import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/riverpod/note_riverpod.dart';
import 'package:flutter_application_1/riverpod/notes_riverpod.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_application_1/widgets/widget_content_note.dart/NewLine_TextFormField.dart';
import 'package:flutter_application_1/widgets/widget_content_note.dart/add_icon.dart';
import 'package:flutter_application_1/widgets/widget_content_note.dart/appbar_content.dart';
import 'package:flutter_application_1/widgets/widget_content_note.dart/bottom_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ContentScreen extends HookConsumerWidget {
  ContentScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final FocusNode _titleFocusNode = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getTheme = ref.watch(themeNotifierProvider);
    final titleController = useTextEditingController();
    final contentController = useTextEditingController();
    final getNote = ref.watch(noteNotifierProvider);
    final listNewLineText = useState<List<TextEditingController>>([]);
// add new line
    void addNewLine() {
      listNewLineText.value = [
        ...listNewLineText.value,
        TextEditingController()
      ];
    }

    useEffect(() {
      // neu co anh thi xoa anh khi khởi tạo màn hình
      if (getNote?.image != null) {
        getNote?.image = null;
      }
      return null;
    }, []);
    return Scaffold(
      appBar: const AppBarContent(),
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
                    focusNode: _titleFocusNode,
                    decoration: const InputDecoration(
                      hintText: 'Title',
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
                        return NewLineTextFormField(
                          controller: controller,
                          onDismissed: () {
                            listNewLineText.value.removeAt(index);
                          },
                        );
                      }),
                    ],
                  ),
                ),
// hiển thị ảnh đã chọn
                getNote?.image != null
                    ? Image.file(
                        File(getNote!.image!),
                        height: 200,
                        width: double.infinity,
                      )
                    : Container(),
// hiển thị link nếu có
                // hiển thị link nếu có
                getNote?.link != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(noteNotifierProvider.notifier)
                                    .launchUrlGoogle(getNote.link!);
                              },
                              child: Text(
                                getNote!.link!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(noteNotifierProvider.notifier)
                                  .deleteLink();
                            },
                            icon: const Icon(Icons.delete),
                            iconSize: 20,
                          ),
                        ],
                      )
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
// Display Theme Icon, Save Icon
      bottomNavigationBar: BottomNavigation(
        onSave: () {
          if (_formKey.currentState!.validate()) {
            final String title = titleController.text;
            final String content = contentController.text;
            List<String> additionalContents = listNewLineText.value
                .map((controller) => controller.text)
                .toList();
            ref.read(noteListNotifierProvider.notifier).addNote(
                  Note(
                      title: title,
                      content: content,
                      image: getNote?.image == null ? null : getNote!.image,
                      link: getNote?.link == null ? null : getNote!.link,
                      additionalContents: additionalContents),
                );
            Navigator.pop(
              context,
            );
          }
        },
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter_application_1/models/note.dart'; // Replace with actual import path
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class NoteNotifier extends StateNotifier<Note?> {
  NoteNotifier() : super(null);

// Function to add an image
  Future<File?> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      if (state != null) {
        state = state!.updateNote(image: image.path);
      } else {
        state = Note(
          title: 'New Note',
          content: 'New Content',
          image: image.path,
        );
      }
      return file;
    }
    return null;
  }

// Function to launch Google search URL
  Future<void> launchUrlGoogle(String query) async {
    final Uri url = Uri.parse(query);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

// Function to show input dialog
  Future<void> showTextInputDialog(BuildContext context) async {
    TextEditingController textEditingController = TextEditingController();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Link'),
            content: TextField(
              controller: textEditingController,
              decoration:
                  const InputDecoration(hintText: "Type your link here"),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  final String linkText = textEditingController.text;
                  if (linkText.isNotEmpty) {
                    if (state != null) {
                      state =
                          state?.updateNote(link: textEditingController.text);
                    } else {
                      state = Note(
                        title: 'New Note',
                        content: 'New Content',
                        link: textEditingController.text,
                      );
                    }
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }
// function delete link
  deleteLink() {
    if (state != null) {
       state = state!.link = null;
    }
   
  }
}

final noteNotifierProvider =
    StateNotifierProvider<NoteNotifier, Note?>((ref) => NoteNotifier());

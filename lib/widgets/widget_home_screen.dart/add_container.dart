import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/notes_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContainerAddNote extends ConsumerWidget {
  const ContainerAddNote({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Navigator.pushNamed(context, '/contentScreen').then((val) {

               // ref.read(noteListNotifierProvider.notifier).getLstNote();
              });
            },
            icon: const Icon(Icons.add_circle_outline),
          ),
          const Text("New Note"),
        ],
      ),
    );
  }
}


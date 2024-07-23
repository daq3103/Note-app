import 'package:flutter/material.dart';

class NewLineTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onDismissed;

  const NewLineTextFormField({
    super.key,
    required this.controller,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: ValueKey(controller),
      onDismissed: (direction) => onDismissed(),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'New Line',
          border: InputBorder.none,
        ),
        maxLines: null,
        minLines: 1,
      ),
    );
  }
}

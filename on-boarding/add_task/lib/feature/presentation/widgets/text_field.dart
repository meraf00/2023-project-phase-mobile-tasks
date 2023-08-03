import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  const MyTextField(
      {Key? key,
      required this.label,
      this.keyboardType,
      this.maxLines,
      this.minLines,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.surface.withOpacity(.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                TextField(
                  keyboardType: keyboardType,
                  minLines: minLines,
                  maxLines: maxLines,
                  maxLength: maxLength,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

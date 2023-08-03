import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
        padding: const EdgeInsets.all(15),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}

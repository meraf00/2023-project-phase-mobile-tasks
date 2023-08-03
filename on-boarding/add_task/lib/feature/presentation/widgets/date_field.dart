import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final String label;

  const DateField({
    Key? key,
    required this.label,
  }) : super(key: key);

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
                Positioned(
                    right: 20,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )),
              ],
            )),
      ],
    );
  }
}

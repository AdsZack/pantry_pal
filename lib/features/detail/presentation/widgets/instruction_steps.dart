import 'package:flutter/material.dart';

class InstructionSteps extends StatelessWidget {
  const InstructionSteps({super.key, required this.text});

  final String text;

  static final _stepLabel = RegExp(r'step\s*\d+\W*$', caseSensitive: false);

  List<String> _split() {
    return text
      .split(RegExp(r'\r?\n'))
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty && !_stepLabel.hasMatch(line))
      .toList();
  }

  @override
  Widget build(BuildContext context) {
    final steps = _split();
    if (steps.isEmpty) {
      return const Text('No instruction available.');
    }

    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 1; i < steps.length; i++)
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: scheme.primaryContainer,
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(steps[i])),
              ],
            ),
          )
      ],
    );
  }
}
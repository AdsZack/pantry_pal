import 'package:flutter/material.dart';


class MessageView extends StatelessWidget {
  const MessageView({super.key, required this.icon, required this.text, this.action});

  final IconData icon;
  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(icon, size: 48),
          const SizedBox(height: 12),
          Text(text),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    );
  }
}
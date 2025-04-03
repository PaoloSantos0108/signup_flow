import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const ScreenWrapper({
    Key? key,
    required this.title,
    this.subtitle,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 24, // Slightly smaller for mobile view
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16, // Slightly smaller for mobile view
                    ),
                  ),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Studio Cursor Follower Widget for Desktop Web.
class StudioCursorFollower extends StatelessWidget {
  final Widget child;
  final bool enableFollower;

  const StudioCursorFollower({
    super.key,
    required this.child,
    this.enableFollower = kIsWeb,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

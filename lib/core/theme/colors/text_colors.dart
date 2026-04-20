import 'package:flutter/material.dart';

/// Text color tokens.
abstract class TextColors {
  const TextColors({
    required this.primary,
    required this.secondary,
    required this.grey,
  });

  final Color primary;
  final Color secondary;
  final Color grey;
}

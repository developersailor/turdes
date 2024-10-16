// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.color,
    this.textStyle,
    this.borderRadius,
    this.padding,
  });
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ??
            Theme.of(context)
                .primaryColor, // Varsayılan olarak tema rengini kullanır
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 8.0,
          ), // Varsayılan köşeler 8px
        ),
      ),
      child: Text(
        label,
        style: textStyle ??
            Theme.of(context)
                .textTheme
                .labelLarge, // Varsayılan olarak tema yazı stilini kullanır
      ),
    );
  }
}

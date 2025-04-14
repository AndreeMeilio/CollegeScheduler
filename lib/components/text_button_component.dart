import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/pages/register_page.dart';
import 'package:flutter/material.dart';

class TextButtonComponent extends StatelessWidget {
  TextButtonComponent({
    super.key,
    void Function()? onTap,
    required String label
  }) : _onTap = onTap,
       _label = label;

  final void Function()? _onTap;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onTap,
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      child: Text(
        _label,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: ColorConfig.mainColor,
        ),
      ),
    );
  }
}
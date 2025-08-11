
import 'package:college_scheduler/config/color_config.dart';
import 'package:flutter/material.dart';

class SwitchComponent extends StatelessWidget {
  const SwitchComponent({
    super.key,
    required this.value,
    required this.onChanged
  });

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: ColorConfig.mainColor,
      inactiveThumbColor: ColorConfig.greyColor,
      trackOutlineColor: WidgetStateColor.resolveWith((states) {
        return ColorConfig.mainColor;
      },),
    );
  }
}
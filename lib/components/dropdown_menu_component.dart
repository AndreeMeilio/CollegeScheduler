import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class DropdownMenuComponent<T> extends StatelessWidget {
  DropdownMenuComponent({
    super.key,
    required String label,
    required TextEditingController controller,
    T? value,
    required List<DropdownMenuEntry> menu,
    void Function(dynamic)? onSelected,
    EdgeInsets? margin,
    bool? enabled = true
  }) : _label = label,
       _controller = controller,
       _value = value,
       _menu = menu,
       _onSelected = onSelected,
       _margin = margin,
       _enabled = enabled;

  final String _label;
  final TextEditingController _controller;
  final T? _value;
  final List<DropdownMenuEntry> _menu;
  final void Function(dynamic)? _onSelected;
  final EdgeInsets? _margin;
  final bool? _enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: _margin ?? const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            _label,
            style: (_enabled ?? false) ? TextStyleConfig.body1 : TextStyleConfig.body1.copyWith(
              color: ColorConfig.greyColor
            )
          ),
        ),
        const SizedBox(height: 8.0,),
        Container(
          decoration: BoxDecoration(
            color: ColorConfig.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          margin: _margin ?? const EdgeInsets.symmetric(horizontal: 24.0),
          child: DropdownMenu(
            controller: _controller,
            initialSelection: _value,
            dropdownMenuEntries: _menu,
            width: MediaQuery.sizeOf(context).width,
            enabled: _enabled ?? false,
            onSelected: _onSelected,
            textStyle: (_enabled ?? false) ? TextStyleConfig.body1 : TextStyleConfig.body1.copyWith(
              color: ColorConfig.greyColor
            ),
            menuStyle: MenuStyle(
              fixedSize: WidgetStatePropertyAll(Size.fromWidth(MediaQuery.sizeOf(context).width * 0.5)),
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.0)),
              backgroundColor: WidgetStatePropertyAll(ColorConfig.mainColor),
              alignment: Alignment.centerLeft,
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              isCollapsed: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: ColorConfig.mainColor, width: 1.5)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: ColorConfig.mainColor, width: 1.5)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: ColorConfig.mainColor, width: 1.5)
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: ColorConfig.redColor, width: 1.5)
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: ColorConfig.mainColor, width: 1.5)
              ),
              fillColor: ColorConfig.mainColor,
            ),
          ),
        )
      ],
    );
  }
}
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
    EdgeInsets? margin
  }) : _label = label,
       _controller = controller,
       _value = value,
       _menu = menu,
       _onSelected = onSelected,
       _margin = margin;

  final String _label;
  final TextEditingController _controller;
  final T? _value;
  final List<DropdownMenuEntry> _menu;
  final void Function(dynamic)? _onSelected;
  final EdgeInsets? _margin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: _margin ?? const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            _label,
            style: TextStyleConfig.body1
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
            onSelected: _onSelected,
            inputDecorationTheme: InputDecorationTheme(
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
              fillColor: ColorConfig.mainColor,
            ),
          ),
        )
      ],
    );
  }
}
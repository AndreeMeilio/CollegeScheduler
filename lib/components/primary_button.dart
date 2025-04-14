import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class PrimaryButtonComponent extends StatelessWidget {
  PrimaryButtonComponent({
    super.key,
    required Function()? onTap,
    required String label,
    double? height,
    double? width,
    Alignment? alignment,
    bool? isLoading,
    Color? color,
    Color? borderColor,
    EdgeInsets? margin
  }) : _onTap = onTap,
       _label = label,
       _height = height,
       _width = width,
       _alignment = alignment,
       _isLoading = isLoading,
       _color = color,
       _borderColor = borderColor,
       _margin = margin;

  final Function()? _onTap;
  final String _label;
  final double? _height;
  final double? _width;
  final Alignment? _alignment;
  final bool? _isLoading;
  final Color? _color;
  final Color? _borderColor;
  final EdgeInsets? _margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
      alignment: _alignment,
      decoration: BoxDecoration(
        color: _color ?? ColorConfig.mainColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: _borderColor ?? ColorConfig.whiteColor, width: 1.5)
      ),
      margin: _margin ?? const EdgeInsets.symmetric(horizontal: 24.0),
      child: _isLoading ?? false
        ? Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 11.0),
          child: SizedBox(
            height: 24.0,
            width: 24.0,
            child: CircularProgressIndicator(
              
            ),
          )
        )
        : Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _onTap,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              splashColor: ColorConfig.whiteTransparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                alignment: Alignment.center,
                child: Text(
                  _label,
                  style: TextStyleConfig.body1bold
                ),
              ),
            ),
          ),
    );
  }
}
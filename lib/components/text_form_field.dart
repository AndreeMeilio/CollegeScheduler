import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key, 
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType inputType = TextInputType.text,
    bool obsureText = false,
    String? Function(String?)? validator,
    bool isPassword = false,
    void Function()? suffixIconOnPressed,
    void Function(String?)? onChanged,
    int maxLines = 1,
    bool readonly = false,
    void Function()? onTap,
    bool? isRequired = false,
    Function(String)? onSubmited,
    EdgeInsets? margin
  }) : _controller = controller,
       _label = label, 
       _hint = hint,
       _inputType = inputType,
       _obsureText = obsureText,
       _validator = validator,
       _isPassword = isPassword,
       _suffixIconOnPressed = suffixIconOnPressed,
       _onChanged = onChanged,
       _maxLines = maxLines,
       _readOnly = readonly,
       _onTap = onTap,
       _isRequired = isRequired,
       _onSubmited = onSubmited,
       _margin = margin;

  final TextEditingController _controller;
  final String _label;
  final String _hint;
  final TextInputType _inputType;
  final bool _obsureText;
  final bool _isPassword;
  final void Function()? _suffixIconOnPressed;
  final String? Function(String?)? _validator;
  final void Function(String?)? _onChanged;
  final int _maxLines;
  final bool _readOnly;
  final void Function()? _onTap;
  final bool? _isRequired;
  final Function(String)? _onSubmited;
  final EdgeInsets? _margin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label == "" || _label.isEmpty ? const SizedBox.shrink() : Container(
          margin: _margin ?? const EdgeInsets.symmetric(horizontal: 24.0),
          child: RichText(
            text: TextSpan(
              text: _label,
              style: TextStyleConfig.body2,
              children: _isRequired ?? false ? [
                TextSpan(
                  text: " *",
                  style: TextStyleConfig.body2.copyWith(color: ColorConfig.redColor)
                )
              ] : null
            ),
          )
        ),
        _label == "" || _label.isEmpty ? const SizedBox.shrink() : const SizedBox(height: 8.0,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          margin: _margin ?? const EdgeInsets.symmetric(horizontal: 24.0),
          child: TextFormField(
            decoration: InputDecoration(
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
                borderSide: BorderSide(color: ColorConfig.redColor, width: 1.5),
              ),
              fillColor: ColorConfig.whiteColor,
              filled: true,
              hintText: _hint,
              hintStyle: TextStyleConfig.body2.copyWith(
                color: ColorConfig.blackTransparent
              ),
              errorStyle: TextStyleConfig.body2.copyWith(color: ColorConfig.redColor),
              suffixIcon: _isPassword 
                ? IconButton(
                  onPressed: _suffixIconOnPressed,
                  icon: Icon(_obsureText ? Icons.visibility : Icons.visibility_off)
                )
                : null
            ),
            validator: _validator,
            keyboardType: _inputType,
            controller: _controller,
            obscureText: _obsureText,
            onChanged: _onChanged,
            maxLines: _maxLines,
            readOnly: _readOnly,
            onFieldSubmitted: _onSubmited,
            onTap: _onTap,
          ),
        )
      ],
    );
  }
}
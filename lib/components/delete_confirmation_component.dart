
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class BottomSheetConfirmationWidget extends StatelessWidget {
  const BottomSheetConfirmationWidget({
    super.key,
    required this.onCancel,
    required this.onProcceed,
    this.title,
    this.description,
    this.leftButtonLabel,
    this.rightButtonLabel
  });

  final dynamic Function()? onCancel;
  final dynamic Function()? onProcceed;
  final String? title;
  final String? description;
  final String? leftButtonLabel;
  final String? rightButtonLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              title ?? "",
              style: TextStyleConfig.body1bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              description ?? "",
              style: TextStyleConfig.body1,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButtonComponent(
                  label: leftButtonLabel ?? "",
                  color: ColorConfig.greyColor,
                  onTap: onCancel
                ),
              ),
              Expanded(
                child: PrimaryButtonComponent(
                  label: rightButtonLabel ?? "",
                  color: ColorConfig.mainColor,
                  onTap: onProcceed
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
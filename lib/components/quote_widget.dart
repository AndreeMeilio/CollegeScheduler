import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0)
        ),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "\"THE BEST TIME TO GROW A TREE IS 20 YEARS AGO, THE SECOND BEST TIME IS NOW\"",
            style: TextStyleConfig.heading1.copyWith(
              fontStyle: FontStyle.italic
            ),
          ),
          Text(
            "~ Chinese Proverb",
            style: TextStyleConfig.body1.copyWith(
              fontStyle: FontStyle.italic
            ),
          ),
        ],
      )
    );
  }
}
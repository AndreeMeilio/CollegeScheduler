
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/utils/date_format_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class LogsItemComponent extends StatelessWidget {
  const LogsItemComponent({
    super.key,
    required this.name,
    required this.createdAt,
    required this.description
  });

  final String name;
  final DateTime createdAt;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: ColorConfig.whiteColor,
        border: Border.all(color: ColorConfig.mainColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 16.0,
            children: [
              Text(
                name,
                style: TextStyleConfig.body1bold,
              ),
              Expanded(
                child: Text(
                  DateFormatUtils.dateFormatddMMMMyhhiiss(date: createdAt),
                  style: TextStyleConfig.body1,
                ),
              )
            ],
          ),
          Text(
            description,
            style: TextStyleConfig.body2,
            textAlign: TextAlign.justify,
          )
        ],
      )
    );
  }
}

class LogsItemLoadingComponent extends StatelessWidget {
  const LogsItemLoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: ColorConfig.whiteColor,
        border: Border.all(color: ColorConfig.mainColor, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            spacing: 16.0,
            children: [
              Shimmer.fromColors(
                baseColor: ColorConfig.greyColor,
                highlightColor: ColorConfig.whiteColor,
                child: Container(
                  color: ColorConfig.greyColor,
                  height: 10.0,
                  width: MediaQuery.sizeOf(context).width * 0.2,
                ),
              ),
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: ColorConfig.greyColor,
                  highlightColor: ColorConfig.whiteColor,
                  child: Container(
                    color: ColorConfig.greyColor,
                    height: 10.0,
                    width: MediaQuery.sizeOf(context).width * 0.2,
                  ),
                ),
              )
            ],
          ),
          Shimmer.fromColors(
            baseColor: ColorConfig.greyColor,
            highlightColor: ColorConfig.whiteColor,
            child: Container(
              color: ColorConfig.greyColor,
              height: 25.0,
              width: MediaQuery.sizeOf(context).width,
            ),
          ),
        ],
      )
    );
  }
}
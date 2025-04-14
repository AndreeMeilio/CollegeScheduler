import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:college_scheduler/utils/date_format_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({
    super.key,
    required this.data
  });

  final EventModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.detailEventTitle ?? "Detail Event",
          style: TextStyleConfig.body1,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(24.0),
              child: Text(
                data.title ?? "",
                style: TextStyleConfig.heading1bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorConfig.mainColor
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: 4.0,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.dateOfEventsLabel ?? "Date Of Event",
                          style: TextStyleConfig.body1bold,
                        ),
                        Text(
                          DateFormatUtils.dateFormatddMMMMy(date: data.dateOfEvent ?? DateTime.parse("0000-00-00")),
                          style: TextStyleConfig.body1,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 4.0,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.startHourLabel ?? "Start Hour",
                          style: TextStyleConfig.body1bold,
                        ),
                        Text(
                          "${data.startHour?.hour}:${data.startHour?.minute}",
                          style: TextStyleConfig.body1,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 4.0,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.endHourLabel ?? "End Hour",
                          style: TextStyleConfig.body1bold,
                        ),
                        Text(
                          "${data.endHour?.hour}:${data.endHour?.minute}",
                          style: TextStyleConfig.body1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0,),
            Container(
              decoration: BoxDecoration(
                color: ColorConfig.backgroundColor,
                border: Border.symmetric(horizontal: BorderSide(
                  color: ColorConfig.mainColor,
                  width: 1.5
                ))
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: 4.0,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.priorityLabel ?? "Priority",
                          style: TextStyleConfig.body1bold,
                        ),
                        Text(
                          (data.priority?.name ?? "").toUpperCase(),
                          style: TextStyleConfig.body1,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 4.0,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.statusLabel ?? "Status",
                          style: TextStyleConfig.body1bold,
                        ),
                        Text(
                          (data.status?.name ?? "").toUpperCase(),
                          style: TextStyleConfig.body1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0,),
            Container(
              decoration: BoxDecoration(
                color: ColorConfig.mainColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)?.locationLabel ?? "Location",
                    style: TextStyleConfig.body1bold,
                  ),
                  Text(
                    data.location ?? "-",
                    style: TextStyleConfig.body1,
                  )
                ],
              ),
            ),
            const SizedBox(height: 8.0,),
            Container(
              decoration: BoxDecoration(
                color: ColorConfig.backgroundColor,
                border: Border.symmetric(horizontal: BorderSide(
                  color: ColorConfig.mainColor,
                  width: 1.5
                ))
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)?.classNameLabel ?? "Class Name",
                    style: TextStyleConfig.body1bold,
                  ),
                  Text(
                    data.className ?? "-",
                    style: TextStyleConfig.body1,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConfig.mainColor, width: 1.5),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8.0,
                    children: [
                      Text(AppLocalizations.of(context)?.descriptionLabel ?? "Description", style: TextStyleConfig.body1bold,),
                      Text(data.description ?? "", style: TextStyleConfig.body1, textAlign: TextAlign.justify,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
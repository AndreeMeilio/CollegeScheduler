import 'dart:async';

import 'package:college_scheduler/components/delete_confirmation_component.dart';
import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/event/priority_events_cubit.dart';
import 'package:college_scheduler/cubit/menu/base_menu_cubit.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/cubit/event/list_event_cubit.dart';
import 'package:college_scheduler/cubit/event/status_events_cubit.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:college_scheduler/pages/data_class_page.dart';
import 'package:college_scheduler/pages/data_events_page.dart';
import 'package:college_scheduler/pages/data_lecturer_page.dart';
import 'package:college_scheduler/pages/detail_event_page.dart';
import 'package:college_scheduler/utils/date_format_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // QuoteWidget(),
            GreetingWidget(),
            ShortcutMenuWidget(),
            StatusDashboardWidget(),
            RecentDataEventWidget(),
          ],
        ),
      ),
    );
  }
}

class GreetingWidget extends StatefulWidget {
  const GreetingWidget({super.key});

  @override
  State<GreetingWidget> createState() => _GreetingWidgetState();
}

class _GreetingWidgetState extends State<GreetingWidget> {
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TimeTickingWidget(now: _now,),
                  Text(DateFormatUtils.dateFormatddMMMMy(date: _now), style: TextStyleConfig.heading1bold,)
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              AppLocalizations.of(context)?.greetingFriend("My Friend") ?? "Welcome Back! \nMy Friend",
              style: TextStyleConfig.heading1bold,
            ),
          )
        ],
      ),
    );
  }
}

class StatusDashboardWidget extends StatefulWidget {
  const StatusDashboardWidget({super.key});

  @override
  State<StatusDashboardWidget> createState() => _StatusDashboardWidgetState();
}

class _StatusDashboardWidgetState extends State<StatusDashboardWidget> {
  
  late StatusEventsCubit _statusCubit;
  late PriorityEventsCubit _priorityCubit;

  @override
  void initState() {
    super.initState();

    _statusCubit = BlocProvider.of<StatusEventsCubit>(context, listen: false);
    _priorityCubit = BlocProvider.of<PriorityEventsCubit>(context, listen: false);

    _statusCubit.getStatusAllEvents();
    _priorityCubit.getPriorityAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.0,
            children: [
              Text(
                AppLocalizations.of(context)?.dataStatusTitle ?? "Data Status",
                style: TextStyleConfig.body1bold,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: ColorConfig.whiteColor, width: 1.5),
                  color: ColorConfig.mainColor,
                ),
                child: BlocBuilder<StatusEventsCubit, StateGeneral<StatusEventsState, Map<String, int>>>(
                  builder: (context, state) {
                    if (state.state is StatusEventsFailedState){
                      return Center(
                        child: Text(
                          state.message ?? "",
                          style: TextStyleConfig.body1bold,
                        ),
                      );
                    } else if (state.state is StatusEventsLoadedState){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8.0,
                        children: [
                          const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Text( AppLocalizations.of(context)?.idleStatus ?? "IDLE", style: TextStyleConfig.body1bold,),
                                Text("${state.data?['idleCount']}", style: TextStyleConfig.body1bold,),
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.whiteColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Text( AppLocalizations.of(context)?.progressStatus ?? "PROGRESS", style: TextStyleConfig.body1bold,),
                                Text("${state.data?['progressCount']}", style: TextStyleConfig.body1bold,),
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.whiteColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Text(AppLocalizations.of(context)?.doneStatus ?? "DONE", style: TextStyleConfig.body1bold,),
                                Text("${state.data?['doneCount']}", style: TextStyleConfig.body1bold,),
                              ],
                            ),
                          ),
                          const SizedBox(),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8.0,
                        children: [
                          const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                    color: ColorConfig.greyColor,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: 24.0,
                                    color: ColorConfig.greyColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.whiteColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                    color: ColorConfig.greyColor,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: 24.0,
                                    color: ColorConfig.greyColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.whiteColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                    color: ColorConfig.greyColor,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: 24.0,
                                    color: ColorConfig.greyColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(),
                        ],
                      );
                    }
                  }
                ),
              ),
            ],
          ),
          // const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.0,
            children: [
              Text(
                AppLocalizations.of(context)?.dataPriorityTitle ?? "Data Priority",
                style: TextStyleConfig.body1bold,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: ColorConfig.whiteColor,
                  border: Border.all(color: ColorConfig.mainColor, width: 1.5)
                ),
                child: BlocBuilder<PriorityEventsCubit, PriorityEventsStateType>(
                  builder: (context, state) {
                    if (state.state is PriorityEventsFailedState){
                      return Center(
                        child: Text(
                          state.message ?? "",
                          style: TextStyleConfig.body1bold,
                        ),
                      );
                    } else if (state.state is PriorityEventsLoadedState){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8.0,
                        children: [
                          const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Text(AppLocalizations.of(context)?.lowPriority ?? "LOW", style: TextStyleConfig.body1bold,),
                                Text("${state.data?['lowCount']}", style: TextStyleConfig.body1bold,),
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.mainColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Text(AppLocalizations.of(context)?.mediumPriority ?? "MEDIUM", style: TextStyleConfig.body1bold,),
                                Text("${state.data?['mediumCount']}", style: TextStyleConfig.body1bold,),
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.mainColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Text(AppLocalizations.of(context)?.highPriority ?? "HIGH", style: TextStyleConfig.body1bold,),
                                Text("${state.data?['highCount']}", style: TextStyleConfig.body1bold,),
                              ],
                            ),
                          ),
                          const SizedBox(),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8.0,
                        children: [
                          const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                    color: ColorConfig.greyColor,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: 24.0,
                                    color: ColorConfig.greyColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.whiteColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                    color: ColorConfig.greyColor,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: 24.0,
                                    color: ColorConfig.greyColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Divider(color: ColorConfig.whiteColor, height: 0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 16.0,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: MediaQuery.sizeOf(context).width * 0.25,
                                    color: ColorConfig.greyColor,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: ColorConfig.greyColor,
                                  highlightColor: ColorConfig.whiteColor,
                                  child: Container(
                                    height: 16.0,
                                    width: 24.0,
                                    color: ColorConfig.greyColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(),
                        ],
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}

class ShortcutMenuWidget extends StatelessWidget {
  const ShortcutMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            AppLocalizations.of(context)?.coreMenuTitle ?? "Core Menu",
            style: TextStyleConfig.body1bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: ColorConfig.whiteColor,
            border: Border.all(color: ColorConfig.mainColor, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          context.push(ConstantsRouteValue.events);
                        },
                        splashColor: ColorConfig.blackTransparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            AppLocalizations.of(context)?.dataEventsTitle ?? "Data Events",
                            style: TextStyleConfig.body1bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: ColorConfig.mainColor, 
                  thickness: 1.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          context.push(ConstantsRouteValue.clasess);
                        },
                        splashColor: ColorConfig.blackTransparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            AppLocalizations.of(context)?.dataClassTitle ?? "Data Class",
                            style: TextStyleConfig.body1bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: ColorConfig.mainColor, 
                  thickness: 1.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConfig.whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          context.push(ConstantsRouteValue.lecturer);
                        },
                        splashColor: ColorConfig.blackTransparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            AppLocalizations.of(context)?.dataLecturerTitle ?? "Data Lecturer",
                            style: TextStyleConfig.body1bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimeTickingWidget extends StatefulWidget {
  TimeTickingWidget({
    super.key,
    required DateTime now
  }) : _now = now;

  DateTime _now;

  @override
  State<TimeTickingWidget> createState() => _TimeTickingWidgetState();
}

class _TimeTickingWidgetState extends State<TimeTickingWidget> with WidgetsBindingObserver{


  late bool _continueTimeTicking;

  late DateTime _timeOutput;

  late Timer _timerTicker;

  @override
  void initState() {
    super.initState();

    _continueTimeTicking = true;
    _timeOutput = widget._now;

    timeTickingSec();
  }

  @override
  void dispose() {
    super.dispose();

    _timerTicker.cancel();
  }

  void timeTickingSec(){
    _timerTicker = Timer.periodic(const Duration(seconds: 1), (_){
      setState(() {
        _timeOutput = _timeOutput.add(const Duration(seconds: 1));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text("${DateFormatUtils.dateFormatjms(date: _timeOutput)}", style: TextStyleConfig.heading1bold,);
  }
}

class RecentDataEventWidget extends StatefulWidget {
  const RecentDataEventWidget({super.key});

  @override
  State<RecentDataEventWidget> createState() => _RecentDataEventWidgetState();
}

class _RecentDataEventWidgetState extends State<RecentDataEventWidget> {

  late ListEventCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<ListEventCubit>(context, listen: false);
    _cubit.getAllEvent(limit: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,
        children: [
          Text(
            AppLocalizations.of(context)?.recentDataEvents ?? "Recent Data Events",
            style: TextStyleConfig.body1bold,
          ),
          BlocBuilder<ListEventCubit, StateGeneral>(
            builder: (context, state){
              if (state.state is ListEventFailedState){
                return Center(
                  child: Text(
                    state.message ?? "",
                    style: TextStyleConfig.body1bold,
                  ),
                );
              } else if (state.state is ListEventLoadedState){
                if (state.data?.isNotEmpty ?? false){
                  return ListView.builder(
                    itemCount: state.data?.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: ListItemEventDataWidget(
                          data: state.data?[index],
                          cubit: _cubit,
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      state.message ?? "",
                      style: TextStyleConfig.body1bold,
                    ),
                  );
                }
              } else {
                return ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return ListItemEventDataLoadingWidget();
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}

import 'package:college_scheduler/components/logs_item_component.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/logs/event_logs_cubit.dart';
import 'package:college_scheduler/data/models/logs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventHistoryPage extends StatefulWidget {
  const EventHistoryPage({super.key});

  @override
  State<EventHistoryPage> createState() => _EventHistoryPageState();
}

class _EventHistoryPageState extends State<EventHistoryPage> {

  late EventsLogsCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<EventsLogsCubit>(context, listen: false);

    _cubit.getLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.eventHistory ?? "Event History",
          style: TextStyleConfig.body1,
        ),
        backgroundColor: ColorConfig.backgroundColor,
        surfaceTintColor: ColorConfig.backgroundColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        child: BlocBuilder<EventsLogsCubit, StateGeneral<EventsLogsState, List<LogsModel?>?>>(
          builder: (context, state){
            if (state.state is EventsLogsLoadedState){

              if (state.data?.isNotEmpty ?? false){
                return ListView.builder(
                  itemCount: state.data?.length,
                  itemBuilder: (context, index){
                    return LogsItemComponent(
                      name: state.data?[index]?.actionName ?? "",
                      description: state.data?[index]?.description ?? "",
                      createdAt: state.data?[index]?.createdAt ?? DateTime.parse("0000-00-00"),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)?.gettingDataEmpty(AppLocalizations.of(context)?.eventHistory ?? "") ?? "You don't have data on Event History",
                    style: TextStyleConfig.body1bold,
                  ),
                );
              }
            } else if (state.state is EventsLogsFailedState){
              return Center(
                child: Text(
                  state.message ?? "",
                  style: TextStyleConfig.body1bold,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index){
                  return LogsItemLoadingComponent();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
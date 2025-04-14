
import 'package:college_scheduler/components/logs_item_component.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/logs/login_logs_cubit.dart';
import 'package:college_scheduler/data/models/logs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class LoginHistoryPage extends StatefulWidget {
  const LoginHistoryPage({super.key});

  @override
  State<LoginHistoryPage> createState() => _LoginHistoryPageState();
}

class _LoginHistoryPageState extends State<LoginHistoryPage> {

  late LoginLogsCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<LoginLogsCubit>(context, listen: false);

    _cubit.getAllLoginLogs();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.loginHistoryTitle ?? "Login History",
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
        child: BlocBuilder<LoginLogsCubit, StateGeneral<LoginLogsState, List<LogsModel?>?>>(
          builder: (context, state){
            if (state.state is LoginLogsLoadedState){
              if (state.data?.isNotEmpty ?? false){
              return ListView.builder(
                itemCount: state.data?.length,
                itemBuilder: (context, index){
                  return LoginHistoryItemWidget(
                    logsModel: state.data?[index],
                  );
                },
              );
            } else {
              return Container(
                margin: const EdgeInsets.all(24.0),
                alignment: Alignment.center,
                child: Text(
                  state.message ?? "",
                  style: TextStyleConfig.body1bold,
                ),
              );
            }
            } else if (state.state is LoginLogsFailedState){
              return Center(
                child: Text(
                  AppLocalizations.of(context)?.gettingDataProblem(AppLocalizations.of(context)?.loginHistoryTitle ?? "") ?? "There's a problem when getting login history data",
                  style: TextStyleConfig.body1,
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
      )
    );
  }
}

class LoginHistoryItemWidget extends StatelessWidget {
  const LoginHistoryItemWidget({
    super.key,
    required this.logsModel
  });

  final LogsModel? logsModel;

  @override
  Widget build(BuildContext context) {
    return LogsItemComponent(
      name: logsModel?.actionName ?? "",
      description: logsModel?.description ?? "",
      createdAt: logsModel?.createdAt ?? DateTime.parse("0000-00-00"),
    );
  }
}
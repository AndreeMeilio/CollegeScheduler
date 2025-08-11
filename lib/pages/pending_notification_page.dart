import 'package:college_scheduler/components/delete_confirmation_component.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/notification_config.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/notification/list_reminder_pending_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class PendingNotificationPage extends StatefulWidget {
  const PendingNotificationPage({super.key});

  @override
  State<PendingNotificationPage> createState() => _PendingNotificationPageState();
}

class _PendingNotificationPageState extends State<PendingNotificationPage> {

  late ListReminderPendingCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = BlocProvider.of<ListReminderPendingCubit>(context, listen: false);
    _cubit.getReminderPending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.menuPendingNotification ?? "Pending Notification",
          style: TextStyleConfig.body1,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 24.0),
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        child: BlocBuilder<ListReminderPendingCubit, ListReminderPendingStateType>(
          builder: (context, state) {
            if (state.state is ListReminderPendingLoadedState){
              return state.data?.isNotEmpty ?? false ? ListView.builder(
                itemCount: state.data?.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    child: Slidable(
                      key: ValueKey(state.data?[index].id),
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        extentRatio: 1/3,
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            spacing: 8.0,
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            onPressed: (context) async{
                              // await cubit.deleteEvent(data: data);
                              showModalBottomSheet(
                                context: context,
                                builder: (context){
                                  return BottomSheetConfirmationWidget(
                                    title: "Delete Confirmation!",
                                    description: "The deleted data cannot be restored, Are you sure you want to delete it?",
                                    leftButtonLabel: "Cancel",
                                    rightButtonLabel: "Yes, Delete It",
                                    onCancel: (){
                                      context.pop();
                                    },
                                    onProcceed: () async{
                                      await NotificationConfig.cancelEventNotification(id: state.data?[index].id ?? 0);

                                      _cubit.getReminderPending();
                                      if (context.mounted){
                                        context.pop();
                                      }
                                    },
                                  );
                                }
                              );
                            },
                            label: AppLocalizations.of(context)?.deleteButton ?? "Delete",
                            backgroundColor: ColorConfig.redColor,
                            icon: Icons.edit,
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConfig.mainColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: ColorConfig.backgroundColor
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 8.0,
                          children: [
                            Text("${state.data?[index].title}", style: TextStyleConfig.body1bold,),
                            Text("${state.data?[index].body}", style: TextStyleConfig.body1,)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ) : Center(
                child: Text("You don't have Pending Reminder", style: TextStyleConfig.body1bold,)
              );
            } else if (state.state is ListReminderPendingFailedState){
              return Center(
                child: Text("There's a problem when getting reminder pending", style: TextStyleConfig.body1bold,)
              );
            }

            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConfig.mainColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: ColorConfig.backgroundColor
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8.0,
                    children: [
                      Shimmer.fromColors(
                        baseColor: ColorConfig.greyColor,
                        highlightColor: ColorConfig.whiteColor,
                        child: Container(
                          color: ColorConfig.greyColor,
                          height: 25.0,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: ColorConfig.greyColor,
                        highlightColor: ColorConfig.whiteColor,
                        child: Container(
                          color: ColorConfig.greyColor,
                          height: 25.0,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
            
          },
        )
      ),
    );
  }
}
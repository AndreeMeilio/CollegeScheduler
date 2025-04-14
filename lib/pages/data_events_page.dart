
import 'package:college_scheduler/components/delete_confirmation_component.dart';
import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/menu/base_menu_cubit.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/cubit/event/list_event_cubit.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:college_scheduler/pages/detail_event_page.dart';
import 'package:college_scheduler/utils/date_format_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class DataEventsPage extends StatefulWidget {
  const DataEventsPage({super.key});

  @override
  State<DataEventsPage> createState() => _DataEventsPageState();
}

class _DataEventsPageState extends State<DataEventsPage> {
  
  late TextEditingController _searchController;

  late TextEditingController _filterPriorityController;
  late TextEditingController _filterStatusController;
  late TextEditingController _filterDateOfEventController;

  late PRIORITY _filterSelectedPriority;
  late STATUS _filterSelectedStatus;

  late ListEventCubit _cubit;

  late DateTimeRange? _filterDateRangeEvent;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _filterPriorityController = TextEditingController(text: "Select Priority");
    _filterStatusController = TextEditingController(text: "Select Status");
    _filterDateOfEventController = TextEditingController();

    _filterDateRangeEvent = null;

    _filterSelectedPriority = PRIORITY.selectPriority;
    _filterSelectedStatus = STATUS.selectStatus;

    _cubit = BlocProvider.of<ListEventCubit>(context, listen:false);

    _cubit.getAllEvent();
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
    _filterPriorityController.dispose();
    _filterStatusController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.dataEventsTitle ?? "Data Events",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.0,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: _searchController,
                    label: "",
                    hint: AppLocalizations.of(context)?.searchItemByTitle ?? "Search item by Title",
                    onSubmited: (value) async{
                      await _cubit.getAllEvent(
                        searchItem: value,
                        priorty: _filterSelectedPriority,
                        status: _filterSelectedStatus
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 24.0),
                  decoration: BoxDecoration(
                    color: ColorConfig.whiteColor,
                    border: Border.all(color: ColorConfig.mainColor, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  // padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: ColorConfig.blackTransparent,
                      onTap: () async{
                        showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return Container(
                              padding: const EdgeInsets.all(24.0),
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.5,
                              child: Column(
                                spacing: 16.0,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        spacing: 16.0,
                                        children: [
                                          Divider(
                                            color: ColorConfig.mainColor,
                                            thickness: 4,
                                            indent: 125.0,
                                            endIndent: 125.0,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)?.filterEvents ?? "Filter Events",
                                            style: TextStyleConfig.body1bold,
                                          ),
                                          CustomTextFormField(
                                            controller: _filterDateOfEventController,
                                            margin: const EdgeInsets.all(0.0),
                                            label: AppLocalizations.of(context)?.dateOfEventsLabel ?? "Date Of Event",
                                            hint: AppLocalizations.of(context)?.dateOfEventsHint ?? "Please input Date Of Event",
                                            readonly: true,
                                            onTap: () async{
                                              final dateByUsers = await showDateRangePicker(
                                                context: context, 
                                                firstDate: DateTime(DateTime.now().year - 1),
                                                lastDate: DateTime(DateTime.now().year + 1),
                                                selectableDayPredicate: (DateTime day, DateTime? selectedStartDay, DateTime? selectedEndTime){
                                                  if (day.isAfter(DateTime.now().subtract(const Duration(days: 1)))){
                                                    return true;
                                                  }
        
                                                  return false;
                                                },
                                                initialDateRange: _filterDateRangeEvent
                                              );
        
                                              if (dateByUsers != null){
                                                _filterDateOfEventController.text = "${DateFormatUtils.dateFormatyMMdd(date: dateByUsers.start)} to ${DateFormatUtils.dateFormatyMMdd(date: dateByUsers.end)}";
                                                _filterDateRangeEvent = dateByUsers;
                                              }
                                            },
                                            validator: (value){
                                              if (value?.isEmpty ?? false){
                                                return AppLocalizations.of(context)?.dateOfEventsHint ?? "Please input date of the event";
                                              }
        
                                              return null;
                                            },
                                          ),
                                          Row(
                                            spacing: 16.0,
                                            children: [
                                              Expanded(
                                                child: DropdownMenuComponent(
                                                  margin: const EdgeInsets.all(0.0),
                                                  label: AppLocalizations.of(context)?.priorityLabel ?? "Data Priority",
                                                  controller: _filterPriorityController,
                                                  value: _filterSelectedPriority,
                                                  menu: [
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.prioritySelect ?? "Select Priority",
                                                      value: PRIORITY.selectPriority,
                                                      enabled: false
                                                    ),
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.lowPriority ?? "LOW",
                                                      value: PRIORITY.low,
                                                    ),
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.mediumPriority ?? "MEDIUM",
                                                      value: PRIORITY.medium,
                                                    ),
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.highPriority ?? "HIGH",
                                                      value: PRIORITY.high,
                                                    ),
                                                  ],
                                                  onSelected: (value){
                                                    _filterSelectedPriority = value;
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: DropdownMenuComponent(
                                                  margin: const EdgeInsets.all(0.0),
                                                  label: AppLocalizations.of(context)?.dataStatusTitle ?? "Data Status",
                                                  controller: _filterStatusController,
                                                  value: _filterSelectedStatus,
                                                  menu: [
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.statusSelect ?? "Select Status",
                                                      value: STATUS.selectStatus,
                                                      enabled: false
                                                    ),
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.idleStatus ?? "IDLE",
                                                      value: STATUS.idle,
                                                    ),
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.progressStatus ?? "PROGRESS",
                                                      value: STATUS.progress,
                                                    ),
                                                    DropdownMenuEntry(
                                                      label: AppLocalizations.of(context)?.doneStatus ?? "DONE",
                                                      value: STATUS.done,
                                                    ),
                                                  ],
                                                  onSelected: (value){
                                                    _filterSelectedStatus = value;
                                                  },
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    spacing: 16.0,
                                    children: [
                                      Expanded(
                                        child: PrimaryButtonComponent(
                                          onTap: (){
                                            _filterDateRangeEvent = null;
                                            _filterDateOfEventController.clear();
        
                                            _filterPriorityController.text = AppLocalizations.of(context)?.prioritySelect ?? "Select Priority";
                                            _filterStatusController.text = AppLocalizations.of(context)?.statusSelect ?? "Select Status";
                                            _filterSelectedPriority = PRIORITY.selectPriority;
                                            _filterSelectedStatus = STATUS.selectStatus;
                                          },
                                          margin: const EdgeInsets.all(0.0),
                                          label: AppLocalizations.of(context)?.clearButton ?? "Clear",
                                          color: ColorConfig.greyColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: PrimaryButtonComponent(
                                          onTap: () async{
                                            await _cubit.getAllEvent(
                                              searchItem: _searchController.text,
                                              priorty: _filterSelectedPriority,
                                              status: _filterSelectedStatus,
                                              dateRangeEvent: _filterDateRangeEvent
                                            );
        
                                            if (context.mounted){
                                              context.pop();
                                            }
        
                                          },
                                          margin: const EdgeInsets.all(0.0),
                                          label: AppLocalizations.of(context)?.submitButton ?? "Submit",
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            );
                          }
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.filter_alt, color: ColorConfig.mainColor,),
                      ),
                    ),
                  )
                )
              ],
            ),
            BlocBuilder<ListEventCubit, StateGeneral>(
              builder: (context, state){
                if (state.state is ListEventLoadedState){
                  if (state.data.isNotEmpty){
                    return ListView.builder(
                      itemCount: state.data.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 16.0),
                          child: ListItemEventDataWidget(
                            data: state.data[index],
                            cubit: _cubit,
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        AppLocalizations.of(context)?.gettingDataEmpty(AppLocalizations.of(context)?.dataEventsTitle ?? "") ?? "You Don't Have Data On Events",
                        style: TextStyleConfig.body1bold,
                      ),
                    );
                  }
                } else if (state.state is ListEventFailedState){
                  return Container(
                    margin: const EdgeInsets.only(top: 24.0),
                    alignment: Alignment.center,
                    child: Text(
                      state.message ?? "",
                      style: TextStyleConfig.body1bold,
                    ),
                  );
                } else {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 0.0,
                        thickness: 8.0,
                        color: ColorConfig.mainColor,
                      );
                    },
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ListItemEventDataLoadingWidget(),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class ListItemEventDataWidget extends StatelessWidget {
  ListItemEventDataWidget({
    super.key,
    required this.data,
    required this.cubit
  });

  EventModel data;
  ListEventCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(data.id),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            onPressed: (context) async{
              final cubitBaseMenu = BlocProvider.of<BaseMenuCubit>(context, listen: false);
              final cubitCreateEventMenu = BlocProvider.of<CreateAndUpdateEventCubit>(context, listen: false);
              cubitCreateEventMenu.setTempDataEvent(data: data);

              cubitBaseMenu.changeIndexActiveMenu(1);
            },
            label: "Edit",
            backgroundColor: ColorConfig.mainColor,
            icon: Icons.edit,
          ),
          SlidableAction(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            onPressed: (context) async{
              // await cubit.deleteEvent(data: data);
              showModalBottomSheet(
                context: context,
                builder: (context){
                  return DeleteConfirmationComponent(
                    onCancel: (){
                      context.pop();
                    },
                    onProcceed: () async{
                      await cubit.deleteEvent(data: data);

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
          color: ColorConfig.mainColor,
          border: Border.all(color: ColorConfig.whiteColor, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(8.0))
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: ColorConfig.blackTransparent,
            onTap: (){
              context.push("${ConstantsRouteValue.events}/${ConstantsRouteValue.detailEvents}", extra: data);
            },
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    data.title ?? "",
                    style: TextStyleConfig.body1bold,
                  ),
                  const SizedBox(height: 8.0,),
                  Text(
                    "${AppLocalizations.of(context)?.deadlineLabel} : ${DateFormatUtils.dateFormatddMMMMy(date: data.dateOfEvent ?? DateTime.parse("0000-00-00"))}",
                    style: TextStyleConfig.body2,
                  ),
                  const SizedBox(height: 32.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)?.priorityLabel} : ${data.priority?.name.toUpperCase()}",
                        style: TextStyleConfig.body2,
                      ),
                      Text(
                        "${AppLocalizations.of(context)?.statusLabel} : ${data.status?.name.toUpperCase()}",
                        style: TextStyleConfig.body2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListItemEventDataLoadingWidget extends StatelessWidget {
  const ListItemEventDataLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConfig.whiteColor
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: ColorConfig.blackTransparent,
          onTap: (){

          },
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: ColorConfig.greyColor.withAlpha(150),
                  highlightColor: ColorConfig.whiteColor,
                  child: Container(
                    color: ColorConfig.greyColor,
                    height: 10.0,
                    width: MediaQuery.sizeOf(context).width * 0.75,
                  )
                ),
                const SizedBox(height: 8.0,),
                Shimmer.fromColors(
                  baseColor: ColorConfig.greyColor.withAlpha(150),
                  highlightColor: ColorConfig.whiteColor,
                  child: Container(
                    color: ColorConfig.greyColor,
                    height: 10.0,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                  ),
                ),
                const SizedBox(height: 32.0,),
                Shimmer.fromColors(
                  baseColor: ColorConfig.greyColor.withAlpha(150),
                  highlightColor: ColorConfig.whiteColor,
                  child: Container(
                    color: ColorConfig.greyColor,
                    height: 10.0,
                    width: MediaQuery.sizeOf(context).width * 0.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
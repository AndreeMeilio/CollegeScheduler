import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/quote_widget.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/class/list_data_class_cubit.dart';
import 'package:college_scheduler/cubit/event/create_event_cubit.dart';
import 'package:college_scheduler/data/models/class_model.dart';
import 'package:college_scheduler/data/models/event_model.dart';
import 'package:college_scheduler/utils/date_format_utils.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

class InputDataPage extends StatelessWidget {
  const InputDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          spacing: 24.0,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // QuoteWidget(),
            const SizedBox(height: 8.0,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Create Event Schedule",
                style: TextStyleConfig.heading1,
              ),
            ),
            FormInputDataWidget()
          ],
        ),
      ),
    );
  }
}

class FormInputDataWidget extends StatefulWidget {
  const FormInputDataWidget({super.key});

  @override
  State<FormInputDataWidget> createState() => _FormInputDataWidgetState();
}

class _FormInputDataWidgetState extends State<FormInputDataWidget> {

  late GlobalKey<FormState> _formKey;

  late DateTime _dateEvent;
  late TimeOfDay? _startHour;
  late TimeOfDay? _endHour;

  late TextEditingController _dateEventController;
  late TextEditingController _titleEventController;
  late TextEditingController _startHourController;
  late TextEditingController _endHourController;
  late TextEditingController _descriptionController;
  late TextEditingController _priorityController;
  late TextEditingController _statusController;
  late TextEditingController _locationController;
  late TextEditingController _classController;

  late PRIORITY _priority;
  late STATUS _status;

  late CreateAndUpdateEventCubit _cubit;
  late ListDataClassCubit _classCubit;

  late List _itemLecturer;
  late ClassModel _selectedClass;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>();

    _dateEvent = DateTime.now();
    _startHour = TimeOfDay(hour: 0, minute: 0);
    _endHour = TimeOfDay(hour: 0, minute: 0);

    _dateEventController = TextEditingController();
    _titleEventController = TextEditingController();
    _descriptionController = TextEditingController();
    _startHourController = TextEditingController();
    _endHourController = TextEditingController();
    _priorityController = TextEditingController();
    _statusController = TextEditingController();
    _locationController = TextEditingController();
    _classController = TextEditingController();

    _priority = PRIORITY.low;
    _status = STATUS.idle;

    _cubit = BlocProvider.of<CreateAndUpdateEventCubit>(context, listen: false);
    _classCubit = BlocProvider.of<ListDataClassCubit>(context, listen: false);

    _classCubit.getAllData();

    if (_cubit.tempDataEvent != null){
      final data = _cubit.tempDataEvent;

      _dateEventController.text = DateFormatUtils.dateFormatyMMdd(date: data?.dateOfEvent ?? DateTime.parse("0000-00-00"));
      _titleEventController.text = data?.title ?? "";
      _descriptionController.text = data?.description ?? "";
      _startHourController.text = "${data?.startHour?.hour}:${data?.startHour?.minute}:00";
      _endHourController.text = "${data?.endHour?.hour}:${data?.endHour?.minute}:00";
      _locationController.text = data?.location ?? "";
      _classController.text = data?.className == "" ? "Select Class" : data?.className ?? "";
      
      _dateEvent = data?.dateOfEvent ?? DateTime.now();
      _startHour = data?.startHour ?? TimeOfDay.now();
      _endHour = data?.endHour ?? TimeOfDay.now();

      _priority = data?.priority ?? PRIORITY.low;
      _status = data?.status ?? STATUS.idle;
      _selectedClass = ClassModel(
        name: "Select Class"
      );
    }
  }

  @override
  void dispose() {
    super.dispose();

    _dateEventController.dispose();
    _titleEventController.dispose();
    _descriptionController.dispose();
    _startHourController.dispose();
    _endHourController.dispose();
    _priorityController.dispose();
    _statusController.dispose();
    _locationController.dispose();
    _classController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.0,
        children: [
          CustomTextFormField(
            controller: _dateEventController,
            isRequired: true,
            label: AppLocalizations.of(context)?.dateOfEventsLabel ?? "Date Of Event",
            hint: AppLocalizations.of(context)?.dateOfEventsHint ?? "Please input Date Of Event",
            readonly: true,
            onTap: () async{
              final dateByUsers = await showDatePicker(
                context: context, 
                firstDate: DateTime(DateTime.now().year - 1),
                lastDate: DateTime(DateTime.now().year + 1),
                selectableDayPredicate: (DateTime day){
                  if (day.isAfter(DateTime.now().subtract(const Duration(days: 1)))){
                    return true;
                  }

                  return false;
                },
                initialDate: _dateEvent
              );

              _dateEventController.text = dateByUsers != null ? DateFormatUtils.dateFormatyMMdd(date: dateByUsers) : "";
              _dateEvent = dateByUsers ?? DateTime.now();
            },
            validator: (value){
              if (value?.isEmpty ?? false){
                return AppLocalizations.of(context)?.dateOfEventsHint ?? "Please input date of the event";
              }

              return null;
            },
          ),
          CustomTextFormField(
            isRequired: true,
            controller: _titleEventController,
            label: AppLocalizations.of(context)?.titleLabel ?? "Title Event",
            hint: AppLocalizations.of(context)?.titleHint ?? "Please input Title Event",
            validator: (value){
              if (value?.isEmpty ?? false){
                return AppLocalizations.of(context)?.titleHint ?? "Please input the title event";
              }

              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: _startHourController,
                  label: AppLocalizations.of(context)?.startHourLabel ?? "Start Hour",
                  hint: "",
                  readonly: true,
                  onTap: () async{
                    final startHourByUsers = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input
                    );

                    _startHourController.text = startHourByUsers != null ? "${startHourByUsers.hour}:${startHourByUsers.minute}:00" : "";
                    _startHour = startHourByUsers;
                  },
                ),
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: _endHourController,
                  label: AppLocalizations.of(context)?.endHourLabel ?? "End Hour",
                  hint: "",
                  readonly: true,
                  onTap: () async{
                    final endHourByUsers = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input
                    );

                    _endHourController.text = endHourByUsers != null ? "${endHourByUsers.hour}:${endHourByUsers.minute}:00" : "";
                    _endHour = endHourByUsers;
                  },
                ),
              )
            ],
          ),
          BlocBuilder<ListDataClassCubit, StateGeneral>(
            builder: (context, state){
              if (state.state is ListDataClassLoadedState){
                _classController.text = AppLocalizations.of(context)?.selectClassLabel ?? "Select Class";
                _selectedClass = ClassModel(
                  name: AppLocalizations.of(context)?.selectClassLabel ?? "Select Class"
                );
                _itemLecturer = List.from([
                  ClassModel(
                    name: AppLocalizations.of(context)?.selectClassLabel ?? "Select Class"
                  )
                ]);
                if (state.data.isNotEmpty){
                  _itemLecturer.addAll(List.from(state.data));
                }
                return DropdownMenuComponent(
                  label: AppLocalizations.of(context)?.dataClassTitle ?? "Data Class",
                  controller: _classController,
                  value: _selectedClass,
                  menu: _itemLecturer.map((data){
                    return DropdownMenuEntry(
                      label: data?.name ?? "",
                      value: data,
                      enabled: !(data?.name == (AppLocalizations.of(context)?.lecturerLabel ?? "Select Class"))
                    );
                  }).toList(),
                  onSelected: (value){
                    _selectedClass = value;
                  },
                );
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    spacing: 8.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.dataClassTitle ?? "Data Class",
                        style: TextStyleConfig.body1
                      ),
                      Shimmer.fromColors(
                        baseColor: ColorConfig.greyColor,
                        highlightColor: ColorConfig.whiteColor,
                        child: Container(
                          color: ColorConfig.greyColor,
                          height: 50.0,
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      )
                    ],
                  ),
                );
              } 
            },
          ),
          CustomTextFormField(
            controller: _locationController,
            label: AppLocalizations.of(context)?.locationLabel ?? "Location",
            hint: "",
          ),
          CustomTextFormField(
            controller: _descriptionController,
            label: AppLocalizations.of(context)?.descriptionLabel ?? "Description",
            hint: "",
            maxLines: 5,
          ),
          DropdownMenuComponent(
            controller: _priorityController,
            label: AppLocalizations.of(context)?.dataPriorityTitle ?? "Priority",
            menu: [
              DropdownMenuEntry(
                value: PRIORITY.low,
                label: AppLocalizations.of(context)?.lowPriority ?? "LOW",
              ),
              DropdownMenuEntry(
                value: PRIORITY.medium,
                label: AppLocalizations.of(context)?.mediumPriority ?? "MEDIUM",
              ),
              DropdownMenuEntry(
                value: PRIORITY.high,
                label: AppLocalizations.of(context)?.highPriority ?? "HIGH",
              ),
            ],
            value: _priority, 
            onSelected: (value){
              _priority = value;
            },
          ),
          DropdownMenuComponent(
            controller: _statusController,
            label: AppLocalizations.of(context)?.dataStatusTitle ?? "Status",
            menu: [
              DropdownMenuEntry(
                value: STATUS.idle,
                label: AppLocalizations.of(context)?.idleStatus ?? "IDLE",
              ),
              DropdownMenuEntry(
                value: STATUS.progress,
                label: AppLocalizations.of(context)?.progressStatus ?? "PROGRESS",
              ),
              DropdownMenuEntry(
                value: STATUS.done,
                label: AppLocalizations.of(context)?.doneStatus ?? "DONE",
              ),
            ],
            value: _status, 
            onSelected: (value){
              _status = value;
            },
          ),
          Row(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: PrimaryButtonComponent(
                  label: AppLocalizations.of(context)?.clearButton ?? "Clear",
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  color: ColorConfig.greyColor,
                  onTap: (){
                    _priority = PRIORITY.low;
                    _status = STATUS.idle;
                    _dateEvent = DateTime.now();
                    _startHour = TimeOfDay.now();
                    _endHour = TimeOfDay.now();
                
                    _dateEventController.clear();
                    _titleEventController.clear();
                    _descriptionController.clear();
                    _startHourController.clear();
                    _endHourController.clear();
                    _priorityController.text = _priority.name.toUpperCase();
                    _statusController.text = _status.name.toUpperCase();
                    _locationController.clear();
                    _classController.text = AppLocalizations.of(context)?.selectClassLabel ?? "Select Class";
                    _selectedClass = ClassModel(
                      name: AppLocalizations.of(context)?.selectClassLabel ?? "Select Class"
                    );
                
                    _cubit.clearTempDataEvent();
                  },
                ),
              ),
              Expanded(
                child: BlocConsumer<CreateAndUpdateEventCubit, StateGeneral>(
                  builder: (context, state){
                    return PrimaryButtonComponent(
                      isLoading: state.state is CreateAndUpdateEventLoadingState,
                      onTap: () async{
                        if (_formKey.currentState?.validate() ?? false){
                          await _cubit.insertAndUpdateEvent(
                            dateOfEvent: _dateEvent,
                            title: _titleEventController.text,
                            startHour: _startHour ?? TimeOfDay(hour: 0, minute: 0),
                            endHour: _endHour ?? TimeOfDay(hour: 0, minute: 0),
                            location: _locationController.text,
                            className: _classController.text == (AppLocalizations.of(context)?.selectClassLabel ?? "Select Class") ? "" : _classController.text,
                            description: _descriptionController.text,
                            priority: _priority,
                            status: _status,
                            isEdit: _cubit.tempDataEvent != null,
                            idEvent: _cubit.tempDataEvent?.id
                          );
                          _cubit.clearTempDataEvent();
                        } else {
                          ToastNotifUtils.showError(
                            context: context,
                            title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.createEventSchedule ?? "") ?? "Create Event Schedule Failed",
                            description: AppLocalizations.of(context)?.emptyFieldError ?? "Please fill the required data"
                          );
                        }
                      },
                      label: AppLocalizations.of(context)?.submitButton ?? "Submit",
                      width: MediaQuery.sizeOf(context).width * 0.25,
                    );
                  }, 
                  listener: (context, state){
                    if (state.state is CreateAndUpdateEventSuccessState){
                      ToastNotifUtils.showSuccess(
                        context: context,
                        title: AppLocalizations.of(context)?.actionFeatureSuccess(AppLocalizations.of(context)?.createEventSchedule ?? "") ?? "Create Event Schedule Successfully",
                        description: state.message ?? ""
                      );
                
                      _priority = PRIORITY.low;
                      _status = STATUS.idle;
                      _dateEvent = DateTime.now();
                
                      _dateEventController.clear();
                      _titleEventController.clear();
                      _descriptionController.clear();
                      _startHourController.clear();
                      _endHourController.clear();
                      _priorityController.text = _priority.name.toUpperCase();
                      _statusController.text = _status.name.toUpperCase();
                
                      _locationController.clear();
                      _classController.text = (AppLocalizations.of(context)?.selectClassLabel ?? "Select Class");
                      _selectedClass = ClassModel(
                        name: (AppLocalizations.of(context)?.selectClassLabel ?? "Select Class")
                      );
                      
                    } else if (state.state is CreateAndUpdateEventFailedState){
                      ToastNotifUtils.showError(
                        context: context,
                        title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.createEventSchedule ?? "") ?? "Create Event Schedule Failed",
                        description: state.message ?? ""
                      );
                    }
                  }
                ),
              ),
            ],
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
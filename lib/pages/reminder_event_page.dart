import 'package:college_scheduler/components/dropdown_menu_component.dart';
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/switch_component.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/notification/create_reminder_setting_cubit.dart';
import 'package:college_scheduler/cubit/notification/get_reminder_setting_cubit.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ReminderEventPage extends StatefulWidget {
  const ReminderEventPage({super.key});

  @override
  State<ReminderEventPage> createState() => _ReminderEventPageState();
}

class _ReminderEventPageState extends State<ReminderEventPage> {

  late bool _isReminderOn;
  
  late TextEditingController _hoursDaysController;
  late TextEditingController _countController;
  late TextEditingController _hoursTypeController;

  late String? _valueHoursDaysController;

  late CreateReminderSettingCubit _createCubit;
  late GetReminderSettigCubit _listCubit;

  late bool _isDoneLoadData;

  @override
  void initState() {
    super.initState();
    _isReminderOn = false;

    _hoursDaysController = TextEditingController();
    _countController = TextEditingController();
    _hoursTypeController = TextEditingController(text: "Start Hour");

    _valueHoursDaysController = "Hours";

    _createCubit = BlocProvider.of<CreateReminderSettingCubit>(context, listen: false);
    _listCubit = BlocProvider.of<GetReminderSettigCubit>(context, listen: false);

    _isDoneLoadData = false;

    _listCubit.getDataReminderSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(AppLocalizations.of(context)?.menuSettingsLabel("menuReminderEvent") ?? "Reminder Event", style: TextStyleConfig.body1,),
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
          spacing: 24.0,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<GetReminderSettigCubit, GetReminderSettingStateType>(
                  builder: (context, state) {
                    print(state.state);
                    if (state.state is GetReminderSettingLoadedState){
                      if (!_isDoneLoadData){
                        _isReminderOn = state.data?.isNotificationOn ?? false;
                        _countController.text = state.data?.numberBeforeType.toString() ?? "";
                        _valueHoursDaysController = state.data?.typeNotification;
                        _hoursDaysController.text = state.data?.typeNotification ?? "Hours";
                        _hoursTypeController.text = state.data?.typeHour ?? "Start Hour";

                        _isDoneLoadData = true;
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 24.0,
                        children: [
                          const SizedBox(),
                          ReminderEventActionStatusWidget(
                            isReminderOn: _isReminderOn,
                            onChanged: (value){
                              setState(() {
                                _isReminderOn = value;
                              });
                            },
                          ),
                          _isReminderOn ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 16.0,
                              children: [
                                Row(
                                  spacing: 24.0,
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        controller: _countController,
                                        label: "Notice Me Before",
                                        hint: "0",
                                        inputType: TextInputType.number,
                                        margin: const EdgeInsets.all(0.0),
                                      ),
                                    ),
                                    Expanded(
                                      child: DropdownMenuComponent(
                                        label: "",
                                        margin: const EdgeInsets.all(0.0),
                                        controller: _hoursDaysController,
                                        onSelected: (value){

                                        },
                                        menu: [
                                          DropdownMenuEntry(
                                            value: "Hours",
                                            label: "Hours",
                                          ),
                                          DropdownMenuEntry(
                                            value: "Days",
                                            label: "Days",
                                          ),
                                        ],
                                        value: "Hours",
                                      ),
                                    ),
                                  ],
                                ),
                                DropdownMenuComponent(
                                  controller: _hoursTypeController,
                                  label: "From",
                                  margin: const EdgeInsets.all(0.0),
                                  menu: [
                                    DropdownMenuEntry(
                                      value: "Start Hour",
                                      label: "Start Hour",
                                    ),
                                    DropdownMenuEntry(
                                      value: "End Hour",
                                      label: "End Hour",
                                    ),
                                  ],
                                  value: _hoursTypeController.text, 
                                  onSelected: (value){
                                    _hoursTypeController.text = value;
                                  },
                                ),
                              ],
                            )
                          ) : const SizedBox(),
                          const SizedBox(),
                          _isReminderOn ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              "The reminder will notify you the exact time you set before the date of the event. If the date of the event you set have less time than the notify date for example you set the date event only a day after, and the notify you set 2 days before, the notify will eventually notify you the day of the event.",
                              style: TextStyleConfig.body1,
                              textAlign: TextAlign.center,
                            ),
                          ) : const SizedBox()
                        ],
                      );
                    } else if (state.state is GetReminderSettingFailedState){
                      return Center(
                        child: Text(
                          state.message.toString(),
                          style: TextStyleConfig.body1,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 24.0,
                      children: [
                        const SizedBox(),
                        Row(
                          children: [
                            Expanded(
                              child: Shimmer.fromColors(
                                baseColor: ColorConfig.greyColor,
                                highlightColor: ColorConfig.whiteColor,
                                child: Container(
                                  height: 32.0,
                                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                                  width: MediaQuery.sizeOf(context).width * 0.25,
                                  color: ColorConfig.greyColor,
                                ),
                              ),
                            ),

                            Shimmer.fromColors(
                              baseColor: ColorConfig.greyColor,
                              highlightColor: ColorConfig.whiteColor,
                              child: Container(
                                height: 32.0,
                                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                                width: MediaQuery.sizeOf(context).width * 0.15,
                                color: ColorConfig.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                )
              ),
            ),
            BlocConsumer<CreateReminderSettingCubit, CreateReminderSettingStateType>(
              builder: (context, state) {
                return PrimaryButtonComponent(
                  label: AppLocalizations.of(context)?.submitButton ?? "Submit",
                  isLoading: state.state is CreateReminderSettingLoadingState,
                  onTap: () async{
                    print("${_countController.text} - ${_hoursDaysController.text}");
                    if (_countController.text == "" || _countController.text == "0"){
                      ToastNotifUtils.showError(
                        context: context,
                        title: "Setting Reminder Event Failed",
                        description: "Please insert how many number you would like to notify"
                      );
                    } else {
                      await _createCubit.createReminderSetting(
                        isNotificationOn: _isReminderOn, 
                        numberNoticeBefore: _isReminderOn ? int.parse(_countController.text) : 0, 
                        notificationType: _hoursDaysController.text,
                        hoursType: _hoursTypeController.text
                      );
                    }
                  },
                );
              }, 
              listener: (context, state) {
                if (state.state is CreateReminderSettingSuccessState){
                  ToastNotifUtils.showSuccess(
                    context: context,
                    title: "Reminder Event Setting Success",
                    description: state.message ?? ""
                  );
                } else if (state.state is CreateReminderSettingFailedState){
                  ToastNotifUtils.showError(
                    context: context,
                    title: "Reminder Event Setting Failed",
                    description: state.message ?? ""
                  );
                }
              },
            ),
            const SizedBox()
          ]
        )
      ),
    );
  }
}

class ReminderEventActionStatusWidget extends StatelessWidget {
  const ReminderEventActionStatusWidget({super.key, required this.isReminderOn, required this.onChanged});

  final bool isReminderOn;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Turn on Notification Reminder Event",
              style: TextStyleConfig.body1,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 24.0),
            child: SwitchComponent(
              value: isReminderOn,
              onChanged: onChanged,
            )
          ),
        )
      ],
    );
  }
}

import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/lecturer/create_lecturer_cubit.dart';
import 'package:college_scheduler/data/models/lecturer_model.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

class InputDataLecturerPage extends StatefulWidget {
  const InputDataLecturerPage({
    super.key,
    LecturerModel? data
  }) : _data = data;

  final LecturerModel? _data;

  @override
  State<InputDataLecturerPage> createState() => _InputDataLecturerPageState();
}

class _InputDataLecturerPageState extends State<InputDataLecturerPage> {

  late GlobalKey<FormState> _key;
  late TextEditingController _nameController;
  late CreateLecturerCubit _cubit;

  @override
  void initState() {
    super.initState();

    _key = GlobalKey<FormState>();

    _nameController = TextEditingController();
    _cubit = BlocProvider.of<CreateLecturerCubit>(context, listen: false);

    if (widget._data != null){
      _nameController.text = widget._data!.name ?? "";
    }
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.inputDataLecturerTitle ?? "Input Data Lecturer",
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
          spacing: 24.0,
          children: [
            const SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        controller: _nameController,
                        hint: AppLocalizations.of(context)?.lecturerNameHint ?? "Input Lecturer Name",
                        label: AppLocalizations.of(context)?.lecturerNameLabel ?? "Lecturer Name",
                        validator: (value){
                          if (value?.isEmpty ?? false){
                            return AppLocalizations.of(context)?.lecturerNameEmpty ?? "Please input the name of lecturer";
                          }
        
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<CreateLecturerCubit, StateGeneral>(
              builder: (context, state){
                return PrimaryButtonComponent(
                  label: AppLocalizations.of(context)?.submitButton ?? "Submit",
                  isLoading: state.state is CreateLecturerLoadingState,
                  onTap: () async{
                    if (_key.currentState?.validate() ?? false){
                      if (widget._data != null){
                        await _cubit.createLecturer(
                          lecturerName: _nameController.text,
                          idLecturer: widget._data?.id,
                          isEditData: true
                        );
                      } else {
                        await _cubit.createLecturer(lecturerName: _nameController.text);
                      }
                    } else {
                      ToastNotifUtils.showError(
                        context: context,
                        title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.createDataLecturer ?? "") ?? "Create Data Lecturer Failed",
                        description: AppLocalizations.of(context)?.emptyFieldError ?? "Please fill the required data"
                      );
                    }
                  },
                );
              },
              listener: (context, state){
                if (state.state is CreateLecturerSuccessState){
                  ToastNotifUtils.showSuccess(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureSuccess(AppLocalizations.of(context)?.createDataLecturer ?? "") ?? "Create Data Lecturer Success",
                    description: state.message ?? ""
                  );
        
                  _nameController.clear();
                } else if (state.state is CreateLecturerFailedState){
                  ToastNotifUtils.showError(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.createDataLecturer ?? "") ?? "Create Data Lecturer Failed",
                    description: state.message ?? ""
                  );
                }
              },
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
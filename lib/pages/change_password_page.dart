
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/users/change_password_cubit.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  late GlobalKey<FormState> _key;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  late bool isOldPasswordObscure;
  late bool isNewPasswordObscure;
  late bool isConfirmNewPasswordObscure;

  late ChangePasswordCubit _cubit;

  @override
  void initState() {
    super.initState();

    _key = GlobalKey<FormState>();

    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    isOldPasswordObscure = true;
    isNewPasswordObscure = true;
    isConfirmNewPasswordObscure = true;

    _cubit = BlocProvider.of<ChangePasswordCubit>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();

    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.changePasswordTitle ?? "Change Password",
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    spacing: 24.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        controller: _oldPasswordController,
                        label: AppLocalizations.of(context)?.oldPasswordLabel ?? "Old Password",
                        hint: AppLocalizations.of(context)?.oldPasswordHint ?? "Input your old password",
                        isPassword: true,
                        isRequired: true,
                        obsureText: isOldPasswordObscure,
                        suffixIconOnPressed: (){
                          setState(() {
                            isOldPasswordObscure = !isOldPasswordObscure;
                          });
                        },
                        validator: (value){
                          if (!(value?.isNotEmpty ?? false)){
                            return AppLocalizations.of(context)?.passwordEmptyError ?? "Please input your Password";
                          }
                        },
                      ),
                      CustomTextFormField(
                        controller: _newPasswordController,
                        label: AppLocalizations.of(context)?.newPaswordLabel ?? "New Password",
                        hint: AppLocalizations.of(context)?.newPasswordHint ?? "Input your new password",
                        isPassword: true,
                        isRequired: true,
                        obsureText: isNewPasswordObscure,
                        suffixIconOnPressed: (){
                          setState(() {
                            isNewPasswordObscure = !isNewPasswordObscure;
                          });
                        },
                        validator: (value){
                          if (!(value?.isNotEmpty ?? false)){
                            return AppLocalizations.of(context)?.passwordEmptyError ?? "Please input your Password";
                          } else if (!(_newPasswordController.text.length >= 8)){
                            return AppLocalizations.of(context)?.passwordUpTo8 ?? "Password Must Up To 8 Characters";
                          } else if (!(_newPasswordController.text.contains(RegExp(r'[0-9]+')))) {
                            return AppLocalizations.of(context)?.passwordContainNumber ?? "Password Must Contain Atleats One Number";
                          } else if (!(_newPasswordController.text.contains(RegExp(r'[^\w\s]')))){
                            return AppLocalizations.of(context)?.passwordContainerSymbol ?? "Password Must Contain Symbol";
                          }
                      
                          return null;
                        },
                        onChanged: (value){
                          setState(() {
                            
                          });
                        },
                      ),
                      PasswordRuleChecker(
                        password: _newPasswordController.text,
                      ),
                      CustomTextFormField(
                        controller: _confirmNewPasswordController,
                        label: AppLocalizations.of(context)?.confirmNewPasswordLabel ?? "Confirm New Password",
                        hint: AppLocalizations.of(context)?.confirmNewPasswordHint ?? "Input confirmation of new password",
                        isPassword: true,
                        isRequired: true,
                        obsureText: isConfirmNewPasswordObscure,
                        suffixIconOnPressed: (){
                          setState(() {
                            isConfirmNewPasswordObscure = !isConfirmNewPasswordObscure;
                          });
                        },
                        validator: (value){
                          if (!(value?.isNotEmpty ?? false)){
                            return AppLocalizations.of(context)?.confirmationPasswordEmpty ?? "Please input your confirmation password";
                          } else if (value != _newPasswordController.text){
                            return AppLocalizations.of(context)?.passwordAndConfirmationDontMatch ?? "Your password and confirmation password doesn't match";
                          }

                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<ChangePasswordCubit, StateGeneral>(
              builder: (context, state){
                return PrimaryButtonComponent(
                  label: AppLocalizations.of(context)?.submitButton ?? "Submit",
                  isLoading: state.state is ChangePasswordLoadingState,
                  onTap: () async{
                    if (_key.currentState?.validate() ?? false){
                      await _cubit.changePassword(
                        oldPassword: _oldPasswordController.text, 
                        newPassword: _newPasswordController.text
                      );
                    } else {
                      ToastNotifUtils.showError(
                        context: context,
                        title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.changePasswordTitle ?? "") ?? "Change Password Failed",
                        description: AppLocalizations.of(context)?.emptyFieldError ?? "Please fill the required field"
                      );
                    }
                  },
                );
              },
              listener: (context, state) async{
                if (state.state is ChangePasswordSuccessState){
                  ToastNotifUtils.showSuccess(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureSuccess(AppLocalizations.of(context)?.changePasswordTitle ?? "") ?? "Change Password Success",
                    description: state.message ?? ""
                  );
        
                  final prefs = SharedPreferenceConfig();
        
                  await prefs.clearShared();
        
                  if (context.mounted){
                    context.pushReplacement(ConstantsRouteValue.login);
                  }
                } else if (state.state is ChangePasswordFailedState){
                  ToastNotifUtils.showError(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.changePasswordTitle ?? "") ?? "Change Password Failed",
                    description: state.message ?? ""
                  );
                }
              },
            ),
            const SizedBox()
          ],
        ),
      )
    );
  }
}

class PasswordRuleChecker extends StatelessWidget {
  PasswordRuleChecker({
    super.key,
    required String password
  }) : _password = password;

  final Map<String, dynamic> _passwordRule = Map.from({
    "firstRule" : Map.from({
      "label": "passwordUpTo8",
      "activate" : false
    }),
    "secondRule" : Map.from({
      "label" : "passwordContainNumber",
      "activate" : false
    }),
    "thirdRule" : Map.from({
      "label" : "passwordContainerSymbol",
      "activate" : false 
    }),
  });

  final String _password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _passwordRule.keys.map<Widget>((key){
          if (key == "firstRule"){
            _passwordRule[key]["activate"] = _password.length >= 8;
          } else if (key == "secondRule") {
            _passwordRule[key]["activate"] = _password.contains(RegExp(r'[0-9]+'));
          } else if (key == "thirdRule") {
            _passwordRule[key]["activate"] = _password.contains(RegExp(r'[^\w\s]'));
          }
          
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, color: _passwordRule[key]["activate"] ? ColorConfig.mainColor : ColorConfig.blackTransparent,),
                const SizedBox(width: 16.0,),
                Expanded(
                  child: Text(
                    changeLabelPassword(context, _passwordRule[key]["label"]),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: _passwordRule[key]["activate"] ? ColorConfig.mainColor : ColorConfig.blackTransparent,
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList()
      )
    );
  }

  String changeLabelPassword(BuildContext context, String label){
    String result = "";
    switch(label){
      case "passwordUpTo8":
        result = AppLocalizations.of(context)?.passwordUpTo8 ?? "Password Must Up To 8 Characters";
        break;
      case "passwordContainNumber":
        result = AppLocalizations.of(context)?.passwordContainerSymbol ?? "Password Must Contain At least One Number";
        break;
      case "passwordContainerSymbol":
        result = AppLocalizations.of(context)?.passwordContainerSymbol ?? "Password Must Contain Symbol";
        break;
    }

    return result;
  }
}
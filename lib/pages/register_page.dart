import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_button_component.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/users/login_cubit.dart';
import 'package:college_scheduler/cubit/users/register_cubit.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late GlobalKey<FormState> _formRegister;
  late TextEditingController _fullnameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late bool _isObscure;
  late bool _isConfirmationObscure;

  late RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();

    _formRegister = GlobalKey<FormState>();
    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _isObscure = true;
    _isConfirmationObscure = true;

    _cubit = BlocProvider.of<RegisterCubit>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();

    _fullnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.registerAccount ?? "Register Account",
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
          spacing: 16.0,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formRegister,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 24.0,
                    children: [
                      CustomTextFormField(
                        controller: _fullnameController,
                        label: AppLocalizations.of(context)?.fullnameLabel ?? "Fullname",
                        hint: AppLocalizations.of(context)?.fullnameHint ?? "Input your Fullname",
                        validator: (value){
                          if (!(value?.isNotEmpty ?? false)){
                            return AppLocalizations.of(context)?.fullnameEmpty ?? "Please input your Fullname";
                          }
                      
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: _usernameController,
                        label: AppLocalizations.of(context)?.usernameLabel ?? "Username",
                        hint: AppLocalizations.of(context)?.usernameHint ?? "Input your Username",
                        validator: (value){
                          if (!(value?.isNotEmpty ?? false)){
                            return AppLocalizations.of(context)?.usernameEmpty ?? "Please input your Username";
                          }
                      
                          return null;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 16.0,
                        children: [
                          CustomTextFormField(
                            controller: _passwordController,
                            label: AppLocalizations.of(context)?.passwordLabel ?? "Password",
                            hint: AppLocalizations.of(context)?.passwordHint ?? "Input your Password",
                            isPassword: true,
                            obsureText: _isObscure,
                            suffixIconOnPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            validator: (value){
                              if (!(value?.isNotEmpty ?? false)){
                                return AppLocalizations.of(context)?.passwordEmpty ?? "Please input your Password";
                              } else if (!(_passwordController.text.length >= 8)){
                                return AppLocalizations.of(context)?.passwordUpTo8 ?? "Password Must Up To 8 Characters";
                              } else if (!(_passwordController.text.contains(RegExp(r'[0-9]+')))) {
                                return AppLocalizations.of(context)?.passwordContainNumber ?? "Password Must Contain Atleats One Number";
                              } else if (!(_passwordController.text.contains(RegExp(r'[^\w\s]')))){
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
                            password: _passwordController.text,
                          ),
                          CustomTextFormField(
                            controller: _confirmPasswordController,
                            label: AppLocalizations.of(context)?.confirmationPasswordTitle ?? "Confirmation Password",
                            hint: AppLocalizations.of(context)?.confirmationPasswordHint ?? "Input your Confirmation Password",
                            isPassword: true,
                            obsureText: _isConfirmationObscure,
                            suffixIconOnPressed: (){
                              setState(() {
                                _isConfirmationObscure = !_isConfirmationObscure;
                              });
                            },
                            validator: (value){
                              if (!(value?.isNotEmpty ?? false)){
                                return AppLocalizations.of(context)?.confirmationPasswordEmpty ?? "Please input your confirmation Password";
                              } else if (_passwordController.text != _confirmPasswordController.text){
                                return AppLocalizations.of(context)?.passwordAndConfirmationDontMatch ?? "Your password and confirmation password doesn't match";
                              }
                          
                              return null;
                            },
                            onChanged: (value){
                              setState(() {
                                
                              });
                            },
                          ),
                        ]
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<RegisterCubit, StateGeneral>(
              builder: (context, state) {
                return PrimaryButtonComponent(
                  isLoading: state.state is RegisterLoadingState,
                  onTap: () async{
                    if (_formRegister.currentState?.validate() ?? false){
        
                      await _cubit.registerAccount(
                        fullname: _fullnameController.text,
                        username: _usernameController.text,
                        password: _passwordController.text
                      );
                    } else {
                      ToastNotifUtils.showError(
                        context: context,
                        title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.registerAccount ?? "") ?? "Register Failed",
                        description: AppLocalizations.of(context)?.emptyFieldError ?? "Please fill the required data"
                      );
                    }
                  },
                  label: AppLocalizations.of(context)?.registerAccount ?? "Register Account",
                );
              },
              listener: (context, state) {
                if (state.state is RegisterSuccessState){
                  ToastNotifUtils.showSuccess(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureSuccess(AppLocalizations.of(context)?.registerAccount ?? "") ?? "Register Success",
                    description: state.message ?? ""
                  );
        
                  context.pop();
                } else if (state.state is RegisterFailedState){
                  ToastNotifUtils.showError(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.registerAccount ?? "") ?? "Register Failed",
                    description: state.message ?? ""
                  );
                }
              },
            ),
            GestureDetector(
              onTap: (){
                
                context.pop();
              },
              child: Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)?.alreadyHaveAccount ?? "Already Have Account? ",
                    style: TextStyleConfig.body1.copyWith(
                      color: ColorConfig.blackColor
                    ),
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)?.loginHere ?? "Login Here!",
                        style: TextStyleConfig.body1bold.copyWith(
                          color: ColorConfig.mainColor
                        )
                      )
                    ]
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0,),
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

  String passwordLocalization(BuildContext context, String label){
    String result = "";

    switch(label){
      case "passwordUpTo8":
        result = AppLocalizations.of(context)?.passwordUpTo8 ?? "Password Must Up To 8 Characters";
        break;
      case "passwordContainNumber":
        result = AppLocalizations.of(context)?.passwordContainNumber ?? "Password Must Contain At least One Number";
        break;
      case "passwordContainerSymbol":
        result = AppLocalizations.of(context)?.passwordContainerSymbol ?? "Password Must Contain Symbol";
        break;
    }

    return result;
  }

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
                    passwordLocalization(context, _passwordRule[key]["label"]),
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
}
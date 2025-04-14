import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_button_component.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/state_general.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/users/login_cubit.dart';
import 'package:college_scheduler/pages/base_page.dart';
import 'package:college_scheduler/pages/register_page.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  late bool _isPassword;
  late bool _obsureText;

  late LoginCubit _cubit;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    _isPassword = true;
    _obsureText = true;

    _cubit = BlocProvider.of<LoginCubit>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background_image.png"),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16.0,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 24.0,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24.0),
                          height: MediaQuery.sizeOf(context).height * 0.25,
                          decoration: BoxDecoration(
                            color: ColorConfig.mainColor,
                            border: Border.all(color: ColorConfig.whiteColor, width: 1.5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(24.0),
                              bottomRight: Radius.circular(24.0)
                            )
                          ),
                          child: Column(
                            spacing: 16.0,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)?.quoteDante ?? "\"THE PATH TO PARADISE BEGINS IN HELL\"",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                              Text(
                                "~ Dante Alighieri",
                                style: TextStyleConfig.heading1.copyWith(
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            AppLocalizations.of(context)?.title ?? "College Scheduler",
                            style: TextStyleConfig.heading1bold
                          ),
                        ),
                        CustomTextFormField(
                          controller: _usernameController,
                          hint: AppLocalizations.of(context)?.usernameHint ?? "Input your username",
                          label: AppLocalizations.of(context)?.usernameLabel ?? "Username",
                          validator: (value){
                            if (!(value?.isNotEmpty ?? false)){
                              return AppLocalizations.of(context)?.usernameEmpty ?? "Please input your account username";
                            }
                  
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: _passwordController,
                          hint: AppLocalizations.of(context)?.passwordHint ?? "Input your password",
                          label: AppLocalizations.of(context)?.passwordLabel ?? "Password",
                          obsureText: _obsureText,
                          validator: (value){
                            if (!(value?.isNotEmpty ?? false)){
                              return AppLocalizations.of(context)?.passwordEmpty ?? "Please input your account password";
                            }
                  
                            return null;
                          },
                          isPassword: _isPassword,
                          suffixIconOnPressed: (){
                            setState(() {
                              _obsureText = !_obsureText;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16.0,
                  children: [
                    BlocConsumer<LoginCubit, StateGeneral>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: PrimaryButtonComponent(
                                isLoading: state.state is LoginLoadingState,
                                onTap: () async{
                                  if (_formKey.currentState?.validate() ?? false){
                                    await _cubit.login(
                                      username: _usernameController.text, 
                                      password: _passwordController.text
                                    );                        
                                  } else {
                                    ToastNotifUtils.showError(
                                      context: context,
                                      title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.loginLabel ?? "Login") ?? "Login Failed",
                                      description: AppLocalizations.of(context)?.loginEmpty ?? "Please input your credentials"
                                    );
                                  }
                                },
                                label: AppLocalizations.of(context)?.loginLabel ?? "Login",
                              ),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     color: ColorConfig.mainColor
                            //   ),
                            //   child: Material(
                            //     color: Colors.transparent,
                            //     child: InkWell(
                            //       onTap: () async{
                            //         await _cubit.loginFingerprint();
                            //       },
                            //       splashColor: ColorConfig.greyColor,
                            //       borderRadius: BorderRadius.all(Radius.circular(50)),
                            //       child: Container(
                            //         padding: const EdgeInsets.all(12.0),
                            //         child: Icon(Icons.fingerprint),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 24.0,)
                          ],
                        );
                      },
                      listener: (context, state){
                        if (state.state is LoginSuccessState){
                          ToastNotifUtils.showSuccess(
                            context: context,
                            title: AppLocalizations.of(context)?.actionFeatureSuccess(AppLocalizations.of(context)?.loginLabel ?? "Login") ?? "Login Successfully",
                            description: state.message ?? ""
                          );
        
                          context.pushReplacement(ConstantsRouteValue.baseMenu);
                        } else if (state.state is LoginFailedState){
                          ToastNotifUtils.showError(
                            context: context,
                            title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.loginLabel ?? "Login") ?? "Login Failed",
                            description: state.message ?? ""
                          );
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: (){
                        context.push(ConstantsRouteValue.register);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context)?.noAccount ?? "Don't Have Account? ",
                            style: TextStyleConfig.body1.copyWith(
                              color: ColorConfig.blackColor
                            ),
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)?.registerHere ?? "Register Here",
                                style: TextStyleConfig.body1bold.copyWith(
                                  color: ColorConfig.mainColor
                                )
                              )
                            ]
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
                const SizedBox(height: 24.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
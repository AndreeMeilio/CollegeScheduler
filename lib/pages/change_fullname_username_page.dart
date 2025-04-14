
import 'package:college_scheduler/components/primary_button.dart';
import 'package:college_scheduler/components/text_form_field.dart';
import 'package:college_scheduler/config/color_config.dart';
import 'package:college_scheduler/config/constants_route_value.dart';
import 'package:college_scheduler/config/generated/app_localizations.dart';
import 'package:college_scheduler/config/shared_preference.dart';
import 'package:college_scheduler/config/text_style_config.dart';
import 'package:college_scheduler/cubit/users/change_fullname_username_cubit.dart';
import 'package:college_scheduler/pages/login_page.dart';
import 'package:college_scheduler/utils/toast_notif_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toastification/toastification.dart';

class ChangeFullnameUsernamePage extends StatefulWidget {
  const ChangeFullnameUsernamePage({super.key});

  @override
  State<ChangeFullnameUsernamePage> createState() => _ChangeFullnameUsernamePageState();
}

class _ChangeFullnameUsernamePageState extends State<ChangeFullnameUsernamePage> {

  late GlobalKey<FormState> _key;
  late TextEditingController _fullnameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  late bool _isObscure;

  late ChangeFullnameUsernameCubit _cubit;

  @override
  void initState() {
    super.initState();

    _key = GlobalKey<FormState>();

    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    _isObscure = true;

    _cubit = BlocProvider.of<ChangeFullnameUsernameCubit>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();

    _fullnameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorConfig.backgroundColor,
        backgroundColor: ColorConfig.backgroundColor,
        title: Text(
          AppLocalizations.of(context)?.changeFullnameOrUsernameTitle ?? "Change Fullname Or Username",
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
          spacing: 24.0,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        controller: _fullnameController,
                        label: AppLocalizations.of(context)?.fullnameLabel ?? "Fullname",
                        hint: AppLocalizations.of(context)?.fullnameNewhint ?? "Input your new Fullname",
                        isRequired: true,
                        validator: (value){
                          if (value?.isEmpty ?? false){
                            return AppLocalizations.of(context)?.fullnameNewEmptyError ?? "Please input your new fullname";
                          }
        
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: _usernameController,
                        label: AppLocalizations.of(context)?.usernameLabel ?? "Username",
                        hint: AppLocalizations.of(context)?.usernameNewHint ?? "Input your new Username",
                        isRequired: true,
                        validator: (value){
                          if (value?.isEmpty ?? false){
                            return AppLocalizations.of(context)?.usernameNewEmptyError ?? "Please input your new username";
                          }
        
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        controller: _passwordController,
                        label: AppLocalizations.of(context)?.passwordLabel ?? "Password",
                        hint: AppLocalizations.of(context)?.passwordChangeFullnameUsernameHint ?? "Input your password for validation account",
                        isRequired: true,
                        isPassword: true,
                        obsureText: _isObscure,
                        suffixIconOnPressed: (){
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        validator: (value){
                          if (value?.isEmpty ?? false){
                            return AppLocalizations.of(context)?.passwordEmptyError ?? "Please input your password for security purpose";
                          }
        
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          AppLocalizations.of(context)?.changingFullnameUsernamePasswordDisclamer ?? "For security purpose, please insert your account password, so that we can know this is you who trying to change the username",
                          style: TextStyleConfig.body1,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            BlocConsumer<ChangeFullnameUsernameCubit, ChangeFullnameUsernameStateType>(
              builder: (context, state){
                return PrimaryButtonComponent(
                  onTap: () async{
                    if (_key.currentState?.validate() ?? false){
                      await _cubit.changeFullnameUsername(
                        fullname: _fullnameController.text,
                        username: _usernameController.text,
                        password: _passwordController.text
                      );
        
                      final prefs = SharedPreferenceConfig();
        
                      await prefs.clearShared();
        
                      if (context.mounted){
                        context.pushReplacement(ConstantsRouteValue.login);
                      }
                    } else {
                      ToastNotifUtils.showError(
                        context: context,
                        title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.changeFullnameOrUsernameTitle ?? "") ?? "Change Fullname or Username Failed",
                        description: AppLocalizations.of(context)?.emptyFieldError ?? "Please fill the required data"
                      );
                    }
                  },
                  label: AppLocalizations.of(context)?.submitChange ?? "Submit Changes",
                );
              },
              listener: (context, state){
                if (state.state is ChangeFullnameUsernameSuccessState){
                  ToastNotifUtils.showSuccess(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureSuccess(AppLocalizations.of(context)?.changeFullnameOrUsernameTitle ?? "") ?? "Change Fullname or Username Success",
                    description: state.message ?? ""
                  );
                } else if (state.state is ChangeFullnameUsernameFailedState){
                  ToastNotifUtils.showError(
                    context: context,
                    title: AppLocalizations.of(context)?.actionFeatureFailed(AppLocalizations.of(context)?.changeFullnameOrUsernameTitle ?? "") ?? "Change Fullname or Username Failed",
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
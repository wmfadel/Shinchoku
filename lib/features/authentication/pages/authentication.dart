import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/core/constants/strings.dart';
import 'package:shinchoku/core/enums/dialogs_enum.dart';
import 'package:shinchoku/core/utils/validators.dart';
import 'package:shinchoku/core/widgets/button_loading.dart';
import 'package:shinchoku/core/widgets/custom_dialog.dart';
import 'package:shinchoku/core/widgets/custom_fom_field.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
import 'package:shinchoku/features/authentication/widgets/auth_page_blueprint.dart';
import 'package:shinchoku/features/authentication/widgets/social_media_button.dart';
import 'package:shinchoku/router/routes_info.dart';

/// 1) ✅ add auth flow pages
///   1.1) ✅ check if user already registered
///   1.2) ✅ redirect new users to register page
///   1.3) ✅ redirect registered users to login/add password page
///   1.4) ✅ add info to [RoutesInfo] class
///   1.5) ✅ add initial navigation handling
/// 2) ✅ implement email signup
/// 3) ✅ implement email login
/// 4) ✅ implement google auth
/// 5) ✅ implement twitter auth
/// 6) TODO add facebook auth placeholder
/// 7) TODO add apple auth placeholder
/// 8) TODO add logout button somewhere for now.

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  late final GlobalKey<FormState> _authIntroFormKey;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _authIntroFormKey = GlobalKey();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authIntroFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthPagesBlueprint(
        form: Form(
            key: _authIntroFormKey,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthNewUser) {
                  context.goNamed(
                    RoutesInfo.registerName,
                    queryParams: {'email': state.email},
                  );
                } else if (state is AuthOldUser) {
                  context.goNamed(
                    RoutesInfo.loginName,
                    queryParams: {'email': state.email},
                  );
                } else if (state is AuthError) {
                  context.showShiDialog(
                    type: DialogType.error,
                    message: state.message,
                  );
                } else if (state is AuthCompleted) {
                  context.showShiDialog(
                    type: DialogType.success,
                    message: 'Welcome ${state.userName}!',
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 15),
                    CustomFormField(
                      label: 'Email',
                      controller: _emailController,
                      enabled: state is! AuthLoading,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.emailAddress,
                      validate: FormsValidators.validateEmailField,
                    ),
                    const SizedBox(height: 15),
                    MaterialButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () async {
                              bool isValid =
                                  _authIntroFormKey.currentState!.validate();
                              if (isValid) {
                                AuthBloc.get(context).add(
                                    CheckUser(_emailController.text.trim()));
                              } else {
                                context.showShiDialog(
                                    type: DialogType.info,
                                    message: Strings.incompleteFormMessage);
                              }
                            },
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      textColor: Colors.white,
                      height: 58,
                      minWidth: double.maxFinite,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: state is AuthLoading
                          ? const ShiLoading()
                          : const Text('Continue'),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: Text(
                        'or',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SocialMediaButton(
                      image: Images.authGoogle,
                      platformName: 'Google',
                      onPressed: state is AuthLoading
                          ? null
                          : () => AuthBloc.get(context).add(CreateGoogleUser()),
                    ),
                    const SizedBox(height: 15),
                    SocialMediaButton(
                      image: Images.authTwitter,
                      platformName: 'Twitter',
                      onPressed: state is AuthLoading
                          ? null
                          : () =>
                              AuthBloc.get(context).add(CreateTwitterUser()),
                    ),
                    const SizedBox(height: 15),
                    SocialMediaButton(
                      image: Images.authGithub,
                      platformName: 'Github',
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              context.showShiDialog(
                                  type: DialogType.warning,
                                  message: Strings.providerNotImplemented);
                            },
                    ),
                    const SizedBox(height: 15),
                    SocialMediaButton(
                      image: Images.authFacebook,
                      platformName: 'Facebook',
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              context.showShiDialog(
                                  type: DialogType.warning,
                                  message: Strings.providerNotImplemented);
                            },
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Forgot your password?',
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .secondary),
                    ),
                    const SizedBox(height: 25),
                  ],
                );
              },
            )),
      ),
    );
  }
}

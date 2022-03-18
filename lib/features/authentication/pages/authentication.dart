import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/core/utils/validators.dart';
import 'package:shinchoku/core/widgets/button_loading.dart';
import 'package:shinchoku/core/widgets/custom_fom_field.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
import 'package:shinchoku/features/authentication/widgets/social_media_button.dart';
import 'package:shinchoku/features/authentication/widgets/auth_page_blueprint.dart';
import 'package:shinchoku/router/routes_info.dart';
import 'package:go_router/go_router.dart';

/// 1) ✅ add auth flow pages
///   1.1) ✅ check if user already registered
///   1.2) ✅ redirect new users to register page
///   1.3) ✅ redirect registered users to login/add password page
///   1.4) ✅ add info to [RoutesInfo] class
///   1.5) ✅ add initial navigation handling
/// 2) ✅ implement email signup
/// 3) TODO implement email login
/// 4) TODO implement google auth
/// 5) TODO implement twitter auth
/// 6) TODO add facebook auth placeholder
/// 7) TODO add apple auth placeholder

/// TODO: Change to Stateful Widget
class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _authIntroFormKey = GlobalKey();
  static final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthPagesBlueprint(
        form: Form(
            key: _authIntroFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 15),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CustomFormField(
                      label: 'Email',
                      controller: _emailController,
                      enabled: state is! AuthLoading,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.emailAddress,
                      validate: FormsValidators.validateEmailField,
                    );
                  },
                ),
                const SizedBox(height: 15),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthNewUser) {
                      context.goNamed(RoutesInfo.registerName,
                          queryParams: {'email': state.email});
                    } else if (state is AuthOldUser) {
                      context.goNamed(RoutesInfo.loginName,
                          queryParams: {'email': state.email});
                    }
                  },
                  builder: (context, state) {
                    return MaterialButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () async {
                              bool isValid =
                                  _authIntroFormKey.currentState!.validate();
                              if (isValid) {
                                AuthBloc.get(context).add(
                                    CheckUser(_emailController.text.trim()));
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
                          ? const ButtonLoading()
                          : const Text('Continue'),
                    );
                  },
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
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                SocialMediaButton(
                  image: Images.authTwitter,
                  platformName: 'Twitter',
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                SocialMediaButton(
                  image: Images.authFacebook,
                  platformName: 'Facebook',
                  onPressed: () {},
                ),
                const SizedBox(height: 15),
                Text(
                  'Forgot your password?',
                  style: Theme.of(context).textTheme.button!.copyWith(
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.secondary),
                ),
                const SizedBox(height: 25),
              ],
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/core/constants/strings.dart';
import 'package:shinchoku/core/enums/dialogs_enum.dart';
import 'package:shinchoku/core/utils/validators.dart';
import 'package:shinchoku/core/widgets/button_loading.dart';
import 'package:shinchoku/core/widgets/custom_dialog.dart';
import 'package:shinchoku/core/widgets/custom_fom_field.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
import 'package:shinchoku/features/authentication/widgets/auth_page_blueprint.dart';
import 'package:shinchoku/router/routes_info.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _loginFormKey;
  late final TextEditingController _passwordController;
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    _loginFormKey = GlobalKey();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authBloc = AuthBloc.get(context);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _loginFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      body: AuthPagesBlueprint(
        form: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.goNamed(RoutesInfo.authName),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    Text(
                      'Log in',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ShiImage(authBloc.appUser!.image!),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            authBloc.appUser!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            authBloc.appUser!.email!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CustomFormField(
                      controller: _passwordController,
                      label: 'Password',
                      enabled: state is! AuthLoading,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      isSecretValue: true,
                      validate: FormsValidators.validatePasswordField,
                    );
                  },
                ),
                const SizedBox(height: 15),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      context.showShiDialog(
                        type: DialogType.error,
                        message: state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    return MaterialButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              bool isValid =
                                  _loginFormKey.currentState!.validate();
                              if (!isValid) {
                                context.showShiDialog(
                                    type: DialogType.info,
                                    message: Strings.incompleteFormMessage);
                                return;
                              }
                              authBloc.add(LoginUser(_passwordController.text));
                            },
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      textColor: Colors.white,
                      height: 58,
                      minWidth: double.maxFinite,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: state is AuthLoading
                          ? const ShiLoading()
                          : const Text('Continue'),
                    );
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  'Forgot your password?',
                  style: Theme.of(context).textTheme.button,
                ),
                const SizedBox(height: 25),
              ],
            )),
      ),
    );
  }
}

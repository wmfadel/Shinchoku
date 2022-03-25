import 'package:flutter/gestures.dart';
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
import 'package:go_router/go_router.dart';
import 'package:shinchoku/router/routes_info.dart';

class RegisterPage extends StatefulWidget {
  final String email;

  const RegisterPage({required this.email, Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final GlobalKey<FormState> _registerFormKey;

  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;

  String get email => widget.email;

  @override
  void initState() {
    super.initState();
    _registerFormKey = GlobalKey();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _nameController.dispose();
    _registerFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      body: AuthPagesBlueprint(
        form: Form(
            key: _registerFormKey,
            child: SingleChildScrollView(
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
                        'Sign up!',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (_, current) {
                            return current is AuthEditingName;
                          },
                          builder: (context, state) {
                            final String name =
                                ((state is AuthEditingName) ? state.name : '')
                                    .replaceAll(' ', '_');
                            return ShiImage(
                                'https://avatars.dicebear.com/api/avataaars/$name.svg');
                          },
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Looks like you don\'t have an account. Lets create a new account for\n\n ${widget.email}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomFormField(
                        label: 'Name',
                        controller: _nameController,
                        enabled: state is! AuthLoading,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onChanged: (String? name) {
                          AuthBloc.get(context).add(EditingName(name ?? ''));
                        },
                        validate: FormsValidators.validateNameField,
                      );
                    },
                  ),
                  const SizedBox(height: 15),
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
                  RichText(
                    text: TextSpan(
                        text:
                            'By selecting Agree and continue below, i agree to\n',
                        children: [
                          TextSpan(
                            text: 'Terms of Services and Policy',
                            style: Theme.of(context).textTheme.button,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                /// TODO add a privacy policy link
                              },
                          )
                        ]),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return MaterialButton(
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                                bool? isValid =
                                    _registerFormKey.currentState?.validate();
                                if (isValid != true) {
                                  context.showShiDialog(
                                      type: DialogType.info,
                                      message: Strings.incompleteFormMessage);
                                  return;
                                }
                                AuthBloc.get(context).add(CreateUser(
                                  email: widget.email,
                                  password: _passwordController.text,
                                  name: _nameController.text.trim(),
                                ));
                              },
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .secondary,
                        textColor: Colors.white,
                        height: 58,
                        minWidth: double.maxFinite,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: state is AuthLoading
                            ? const ShiLoading()
                            : const Text('Agree and continue'),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            )),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinchoku/core/utils/validators.dart';
import 'package:shinchoku/core/widgets/button_loading.dart';
import 'package:shinchoku/core/widgets/custom_fom_field.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';
import 'package:shinchoku/features/authentication/controllers/auth_bloc.dart';
import 'package:shinchoku/features/authentication/widgets/auth_page_blueprint.dart';

class RegisterPage extends StatelessWidget {
  final String email;

  const RegisterPage({required this.email, Key? key}) : super(key: key);

  static final GlobalKey<FormState> _key = GlobalKey();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: false,
      body: AuthPagesBlueprint(
        form: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign up!',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
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
                                (state is AuthEditingName) ? state.name : '';
                            return ShiImage(
                                'https://avatars.dicebear.com/api/avataaars/$name.svg');
                          },
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Looks like you don\'t have an account. Lets create a new account for\n\n $email',
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
                                bool? isValid = _key.currentState?.validate();
                                if (isValid != true) return;
                                AuthBloc.get(context).add(CreateUser(
                                  email: email,
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
                            ? const ButtonLoading()
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

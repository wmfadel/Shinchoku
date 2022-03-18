import 'package:flutter/material.dart';
import 'package:shinchoku/core/utils/validators.dart';
import 'package:shinchoku/core/widgets/custom_fom_field.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';
import 'package:shinchoku/features/authentication/widgets/auth_page_blueprint.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> _loginFormKey;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _loginFormKey = GlobalKey();
    _passwordController = TextEditingController();
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
                Text(
                  'Log in',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      height: 100,
                      child: ShiImage(
                        /// TODO replace NAME_PLACEHOLDER with actual user name
                        'https://avatars.dicebear.com/api/avataaars/NAME_PLACEHOLDER.svg',
                      ),
                    ),
                    Text(
                      /// TODO replace EMAIL_PLACEHOLDER with user email
                      'Looks like you don\'t have an account.\nLets create a new account for\n\nEMAIL_PLACEHOLDER',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: _passwordController,
                  label: 'Password',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  isSecretValue: true,
                  validate: FormsValidators.validatePasswordField,
                  onSave: (_) {},
                ),
                const SizedBox(height: 15),
                MaterialButton(
                  /// TODO disable if loading
                  onPressed: () {
                    /// TODO validate and save form
                  },
                  color: Theme.of(context).primaryColor,
                  height: 58,
                  minWidth: double.maxFinite,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),

                  /// TODO update child if loading
                  child: const Text('Continue'),
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

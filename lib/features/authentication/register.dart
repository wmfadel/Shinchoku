import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shinchoku/core/utils/validators.dart';
import 'package:shinchoku/core/widgets/custom_fom_field.dart';
import 'package:shinchoku/core/widgets/shi_image.dart';
import 'package:shinchoku/features/authentication/widgets/auth_page_blueprint.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _key = GlobalKey();
  static final TextEditingController _passwordController =
      TextEditingController();

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
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(
                        width: 100,
                        height: 100,
                        child: ShiImage(

                            /// TODO replace NAME_PLACEHOLDER with user name
                            'https://avatars.dicebear.com/api/avataaars/NAME_PLACEHOLDER.svg'),
                      ),
                      Text(
                        /// TODO replace EMAIL_PLACEHOLDER with user name
                        'Looks like you don\'t have an account.\nLets create a new account for\n\n EMAIL_PLACEHOLDER',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomFormField(
                    label: 'Name',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onChanged: (String? name) {
                      /// TODO update form name
                    },
                    validate: FormsValidators.validateNameField,
                    onSave: (String? name) {
                      /// TODO handle saving name field
                    },
                  ),
                  const SizedBox(height: 15),
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
                  MaterialButton(
                    onPressed: () {
                      /// TODO validate and save form
                    },
                    color: Theme.of(context).primaryColor,
                    height: 58,
                    minWidth: double.maxFinite,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),

                    /// TODO listen to loading state and update content
                    child: const Text('Agree and continue'),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            )),
      ),
    );
  }
}

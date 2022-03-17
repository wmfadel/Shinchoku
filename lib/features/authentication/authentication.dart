import 'package:flutter/material.dart';
import 'package:shinchoku/core/constants/images.dart';
import 'package:shinchoku/core/utils/validators.dart';
import 'package:shinchoku/core/widgets/custom_fom_field.dart';
import 'package:shinchoku/core/widgets/social_media_button.dart';
import 'package:shinchoku/features/authentication/widgets/auth_page_blueprint.dart';

/// 1) TODO add auth flow pages
/// 2) TODO implement email signup
/// 3) TODO implement email login
/// 4) TODO implement google auth
/// 5) TODO implement twitter auth
/// 6) TODO add facebook auth placeholder
/// 7) TODO add apple auth placeholder

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _authIntroFormKey = GlobalKey();

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
                CustomFormField(
                  label: 'Email',
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String? email) {
                    /// TODO handle text update
                  },
                  validate: FormsValidators.validateEmailField,
                  onSave: (String? email) {
                    /// TODO handle saving field data
                  },
                ),
                const SizedBox(height: 15),
                MaterialButton(
                  onPressed: () {},
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                  textColor: Colors.white,
                  height: 58,
                  minWidth: double.maxFinite,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Continue'),
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

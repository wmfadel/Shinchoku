import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:shinchoku/core/constants/keys.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /// TODO: Customize Page UI
      body: SignInScreen(
        providerConfigs: [
          /// TODO: Add Fields Customization
          EmailProviderConfiguration(),
          GoogleProviderConfiguration(clientId: Keys.googleClientID),

          /// TODO: Complete Twitter Configuration
          TwitterProviderConfiguration(
              apiSecretKey: '', apiKey: '', redirectUri: ''),

          /// TODO: Add Facebook Configurations to Firebase Console
          /// FacebookProviderConfiguration(clientId: 'clientId'),
        ],
      ),
    );
  }
}

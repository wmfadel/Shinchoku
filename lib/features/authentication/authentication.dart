import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

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

          /// TODO: Complete Google Auth Configuration
          GoogleProviderConfiguration(clientId: 'clientId'),

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

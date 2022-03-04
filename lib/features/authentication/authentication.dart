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
          EmailProviderConfiguration(),
          GoogleProviderConfiguration(clientId: Keys.googleClientID),
          TwitterProviderConfiguration(
              apiKey: Keys.twitterApiKey,
              apiSecretKey: Keys.twitterApiSecretKey,
              redirectUri: Keys.twitterRedirectUri),

          /// TODO: Add Facebook Configurations to Firebase Console
          /// FacebookProviderConfiguration(clientId: 'clientId'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// 1) TODO add auth flow pages
/// 2) TODO implement email signup
/// 3) TODO implement email login
/// 4) TODO implement google auth
/// 5) TODO implement twitter auth
/// 6) TODO add facebook auth placeholder
/// 7) TODO add apple auth placeholder

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('AUTH WILL BE HERE'),
      ),


      // body: SignInScreen(
      //   headerBuilder: (BuildContext context, BoxConstraints constraints,
      //       double shrinkOffset) {
      //     return Padding(
      //       padding: const EdgeInsets.all(16),
      //       child: FlutterLogo(
      //         duration: const Duration(milliseconds: 500),
      //         curve: Curves.easeIn,
      //         style: FlutterLogoStyle.horizontal,
      //         size: constraints.biggest.height,
      //       ),
      //     );
      //   },
      //   providerConfigs: const [
      //     EmailProviderConfiguration(),
      //     GoogleProviderConfiguration(clientId: Keys.googleClientID),
      //     TwitterProviderConfiguration(
      //         apiKey: Keys.twitterApiKey,
      //         apiSecretKey: Keys.twitterApiSecretKey,
      //         redirectUri: Keys.twitterRedirectUri),
      //
      //     /// TODO: Add Facebook Configurations to Firebase Console
      //     FacebookProviderConfiguration(clientId: 'clientId'),
      //
      //     /// TODO: Add Apple Configurations to Firebase Console
      //     AppleProviderConfiguration(),
      //   ],
      // ),
    );
  }
}

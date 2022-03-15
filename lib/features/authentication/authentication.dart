import 'package:flutter/material.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('AUTH WILL BE HERE'),
      ),

      /// TODO: Customize Page UI
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

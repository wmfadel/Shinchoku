import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shinchoku/shinchoku_app.dart';

void main() async {
  if (kIsWeb) {
    await bootstrap();
  } else {
    runZonedGuarded<Future<void>>(
      () async {
        await bootstrap();
      },
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
    );
  }
}

bootstrap() async {
  Logger().wtf('bootstrap');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(ShinchokuApp(key:const ValueKey('__app_key__'),));
  if (!kIsWeb) _errorListener();
}

_errorListener() {
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first, errorAndStacktrace.last,
        reason: 'From main._errorListener');
  }).sendPort);
}

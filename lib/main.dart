import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shinchoku/shinchoku_app.dart';
import 'package:logging/logging.dart';

void main() async {
  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.ALL;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
  });

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

Logger _log = Logger('main.dart');


bootstrap() async {
  _log.finer('bootstrap');
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

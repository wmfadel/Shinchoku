import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shinchoku/shinchoku_app.dart';

/// TODO: Add Web Firebase Integration
/// TODO: Revisit Firebase UI, if not customizable implement native Auth

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const ShinchokuApp());
    _errorListener();
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

_errorListener() {
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first, errorAndStacktrace.last,
        reason: 'From main._errorListener');
  }).sendPort);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract final class AppPlatform {
  static bool get isCupertino => switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => true,
    _ => false,
  };
}

Route<T> platformRoute<T>({
  required WidgetBuilder builder,
  RouteSettings? settings,
}) {
  if (AppPlatform.isCupertino) {
    return CupertinoPageRoute<T>(settings: settings, builder: builder);
  }
  return MaterialPageRoute<T>(settings: settings, builder: builder);
}

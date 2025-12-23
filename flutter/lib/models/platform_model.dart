import 'native_model.dart' if (dart.library.html) 'web_model.dart';
// RustdeskImpl is imported via native_model.dart or web_model.dart
import 'package:flutter_hbb/generated_bridge.dart' show RustdeskImpl
    if (dart.library.html) 'package:flutter_hbb/web/bridge.dart' show RustdeskImpl;

final platformFFI = PlatformFFI.instance;
final localeName = PlatformFFI.localeName;

RustdeskImpl get bind => platformFFI.ffiBind;

String ffiGetByName(String name, [String arg = '']) {
  return PlatformFFI.getByName(name, arg);
}

void ffiSetByName(String name, [String value = '']) {
  PlatformFFI.setByName(name, value);
}

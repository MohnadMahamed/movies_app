import 'package:get/get.dart';
import 'package:movies_app/core/utils/lang/ar.dart';
import 'package:movies_app/core/utils/lang/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}

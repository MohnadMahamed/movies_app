import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies/data/datasource/cashe_helper.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    // AppLocalStorage localStorage = AppLocalStorage();
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeMode());
    } else {
      // isDark = !isDark;

      // GetStorage().write('mode', isDark).then((value) {
      //   emit(AppChangeMode());
      // });
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeMode());
      });
    }
  }

  // bool isSerach = false;
  // void searchToggle() {
  //   isSerach != isSerach;
  //   emit(SearchToggleState());
  // }
  //  var appLanguage = 'en';

}

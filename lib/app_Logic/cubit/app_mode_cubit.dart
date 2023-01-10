import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/app_Logic/network/local/cache_helper.dart';

part 'app_mode_state.dart';

class AppModeCubit extends Cubit<AppModeStates> {
  AppModeCubit() : super(AppModeInitial());
  static AppModeCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null)
      isDark = fromShared;
    else
      isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeAppModeState());
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit2/states2.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIniState());

  static AppCubit get(context) => BlocProvider.of(context);


  bool isDark=false;
  void changeTheme({ bool? fromShared}){
    if(fromShared!= null){
      isDark=fromShared;
      emit(AppChangeModeState());
    }else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
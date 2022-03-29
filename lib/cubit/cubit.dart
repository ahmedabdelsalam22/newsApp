import 'package:bloc/bloc.dart';
import 'package:flutter_app/cubit/states.dart';
import 'package:flutter_app/shared/networks/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialStates());


 static AppCubit get(context)=>BlocProvider.of(context);


  // theme mode

  bool isDark =true;

  void changeMode({bool fromshared})
{

  if(fromshared !=null) {
    isDark =fromshared;
    emit(AppChangeModeState());
  } else {
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value){
      emit(AppChangeModeState());
    });
  }

  }


}
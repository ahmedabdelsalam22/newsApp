import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/layout/news_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/news_layout/cubit/states.dart';
import 'package:flutter_app/layout/news_layout/news_layout.dart';
import 'package:flutter_app/shared/networks/local/cache_helper.dart';
import 'package:flutter_app/shared/networks/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool isDark =CacheHelper.getBoolean(key: 'isDark');


  runApp(MyApp(isDark));

}

class MyApp extends StatelessWidget {

  final bool isDark;

    MyApp(this.isDark) ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()),
        BlocProvider(create: (context)=>AppCubit()..changeMode(fromshared: isDark))
      ],

        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){

            var cubit =AppCubit.get(context);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              //light theme
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20,
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                    iconTheme:IconThemeData(
                        color: Colors.deepOrange
                    ) ,
                    titleTextStyle: TextStyle(
                        color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    )
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    elevation: 20.0
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )
                ),
              ),
              //dark theme
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme:  AppBarTheme(
                  titleSpacing: 20,
                  elevation: 0.0,
                  backgroundColor: HexColor('333739'),
                  iconTheme:const IconThemeData(
                      color: Colors.deepOrange
                  ) ,
                  titleTextStyle: const TextStyle(
                      color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
                bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                    backgroundColor:HexColor('333739') ,
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    elevation: 20.0
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )
                ),


              ),
              themeMode: cubit.isDark? ThemeMode.dark : ThemeMode.light,
              home: const NewsLayout(),
            );
          },
        ),
      );
  }
}

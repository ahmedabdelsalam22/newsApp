import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/layout/news_layout/cubit/states.dart';
import 'package:flutter_app/modules/business/business_screen.dart';
import 'package:flutter_app/modules/science/science_screen.dart';
import 'package:flutter_app/modules/sports/sports_screen.dart';
import 'package:flutter_app/shared/networks/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context)=>BlocProvider.of(context);


  // bottom nav bar

  int currentIndex =0;

  void bottomNavBarTap(index){
    currentIndex = index;
    if(index==1) {
      getScience();
    }

    if(index==2) {
      getSports();
    }

    emit(NewsBottomNavBarTapStates());
  }

  List<Widget> screens=[
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen()
  ];

  /// get business data

  List<dynamic> business =[];

 void getBusiness(){
   emit(NewsGetBusinessLoadingState());
   DioHelper.getData(
       url: 'v2/top-headlines',
       query: {
         'country':'us',
         'category':'business',
         'apiKey':'528ad7d2b1f8484c81339cdb788b8ccd'
       }
   ).then((value) {
    // print(value.data['articles'][0]['title']);

     business =value.data['articles'];
     emit(NewsGetBusinessSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(NewsGetBusinessErrorState(error.toString()));
   });
 }

 /// get Science data

  List<dynamic> science =[];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apiKey':'528ad7d2b1f8484c81339cdb788b8ccd'
          }
      ).then((value) {
       // print(value.data['articles'][0]['title']);

        science =value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }


  ///get sports

  List<dynamic> sports =[];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'sports',
            'apiKey':'528ad7d2b1f8484c81339cdb788b8ccd'
          }
      ).then((value) {
        //print(value.data['articles'][0]['title']);

        sports =value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }


  // search

  List<dynamic> search =[];

  void getSearch(value){
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'528ad7d2b1f8484c81339cdb788b8ccd'
        }
    ).then((value) {
      //print(value.data['articles'][0]['title']);

      search =value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }




}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/modules/business_screen/business_screen.dart';
import 'package:news_app/models/modules/science_screen/science_screen.dart';
import 'package:news_app/models/modules/settings_screen/settings_screen.dart';
import 'package:news_app/models/modules/sports_screen/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';

import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'science',
    ),

  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),

  ];
  int currentIndex = 0;
  void changeIndex(int index) {

    if(index==1)
      getSports();
    if(index==2)
      getScience();
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
      },
    ).then((value) {
      //  print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
//113d674c0e024c219734dbef88a486f3
  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
        },
      ).then((value) {
        //  print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
        },
      ).then((value) {
        //  print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }
  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        //'sortBy':'popularity',
        'q': '$value',
        'apiKey': 'f8fcf96ebefa4fbfa62ef46fc85c3aaa',
      },
    ).then((value) {
      //  print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
     emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}

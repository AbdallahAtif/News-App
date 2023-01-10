import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_Logic/cubit/states.dart';
import 'package:news_app/app_Logic/network/remote/dio_helper.dart';
import 'package:news_app/presentation/screens/business_screen.dart';
import 'package:news_app/presentation/screens/sciences_screen.dart';
import 'package:news_app/presentation/screens/settings_screen.dart';
import 'package:news_app/presentation/screens/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.work_outline,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
  ];
  void ChangeBottomNavBar(index) {
    currentIndex = index;
    if (index == 1) getSciences();
    if (index == 2) getSports();

    emit(NewsBottomNavState());
  }

  List<Widget> Screens = [
    BusinessScreen(),
    SciencesScreen(),
    SportsScreen(),
  ];

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'cd4fef25bfa748829a3d43dea59a1c26',
    }).then((value) {
      //print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];
  void getSciences() {
    emit(NewsGetSciencesLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'cd4fef25bfa748829a3d43dea59a1c26',
      }).then((value) {
        //print(value.data.toString());
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetSciencesSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSciencesErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSciencesSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'cd4fef25bfa748829a3d43dea59a1c26',
      }).then((value) {
        //print(value.data.toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    search = [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'cd4fef25bfa748829a3d43dea59a1c26',
    }).then((value) {
      //print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/states.dart';
import '../components/constants.dart';
import '../../models/article_model.dart';
import '../../modules/sports/sports.dart';
import '../network/remote/dio_helper.dart';
import '../network/local/cache_helper.dart';
import '../../modules/science/science.dart';
import '../../modules/business/business.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  /// get object from cubit class
  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);

  /// screens
  final List<Object> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<Article> businessArticles = [];
  List<Article> sportArticles = [];
  List<Article> scienceArticles = [];
  List<Article> searchArticles = [];
  int selectedPageIndex = 0;
  int articleSelected = 0;

  /// tabs for nav bar
  List<BottomNavigationBarItem> getBottomNavBarList(BuildContext context) {
    List<BottomNavigationBarItem> bottomItem = [
      BottomNavigationBarItem(
        icon: Icon(Icons.business_center_rounded),
        label: 'Business',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball_rounded),
        label: 'Sports',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science',
      ),
    ];
    return bottomItem;
  }

  /// change number for pages
  void changeIndex(int index) {
    selectedPageIndex = index;
    if (index == 0) {
      getBusiness();
      articleSelected = 0;
    } else if (index == 1) {
      getSports();
      articleSelected = 0;
    } else if (index == 2) {
      getScience();
      articleSelected = 0;
    }

    emit(NewsBottomNavBarState());
  }

  /// Change the state of the selected item
  void changeItemSelectedState({required int index}) {
    articleSelected = index;
    emit(NewsItemSelectedState());
  }

  /// operation (get business data)
  void getBusiness() {
    if (businessArticles.length == 0) {
      emit(NewsGetBusinessLoadingState());

      DioHelper.getDataFromApi(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'business',
          'apiKey': '$kApiKey',
        },
      ).then((value) {
        businessArticles = value;
        emit(NewsGetBusinessSuccessState());
      }).catchError((onError) {
        emit(NewsGetBusinessErrorState(onError.toString()));
      });
    }
  }

  /// operation (get sport data)
  void getSports() {
    if (sportArticles.length == 0) {
      emit(NewsGetSportsLoadingState());

      DioHelper.getDataFromApi(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '$kApiKey',
        },
      ).then((value) {
        sportArticles = value;
        emit(NewsGetSportsSuccessState());
      }).catchError((onError) {
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    }
  }

  /// operation (get science data)
  void getScience() {
    if (scienceArticles.length == 0) {
      emit(NewsGetScienceLoadingState());

      DioHelper.getDataFromApi(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '$kApiKey',
        },
      ).then((value) {
        scienceArticles = value;

        emit(NewsGetScienceSuccessState());
      }).catchError((onError) {
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    }
  }

  /// search for any key word
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getDataFromApi(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '$kApiKey',
      },
    ).then((value) {
      searchArticles = value;

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  /// when ending with search
  void clearList({required bool navigator}) {
    searchArticles = [];
    if (!navigator) emit(NewsGetSearchDoneState());
  }
}

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  // get object from cubit class
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  bool isDark = false;

  //change theme mode
  void changeAppMode({required SharedPreferences sharedPref}) {
    isDark = !isDark;
    CacheHelper.saveMode(mode: isDark, sharedPre: sharedPref)
        .then((value) => emit(AppChangeModeState()));
  }

  //get theme mode
  void getAppMode({required SharedPreferences sharedPref}) {
    CacheHelper.getMode(sharedPref: sharedPref).then((value) {
      isDark = value;
      emit(AppChangeModeState());
    });
  }
}

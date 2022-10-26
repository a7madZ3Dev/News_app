// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';

class Home extends StatelessWidget {
  final SharedPreferences sharedPref;
  const Home({
    Key? key,
    required this.sharedPref,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, NewsStates state) {},
        builder: (BuildContext context, NewsStates state) {
          NewsCubit newsCubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search_rounded,
                  ),
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: () {
                    BlocProvider.of<AppCubit>(context)
                        .changeAppMode(sharedPref: sharedPref);
                  },
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: newsCubit.businessArticles.length > 0,
              builder: (context) =>
                  newsCubit.screens[newsCubit.selectedPageIndex] as Widget,
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: newsCubit.changeIndex,
              currentIndex: newsCubit.selectedPageIndex,
              items: newsCubit.getBottomNavBarList(context),
            ),
          );
        });
  }
}

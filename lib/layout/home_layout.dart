import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';

class Home extends StatelessWidget {
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
                    navigateTo(context, SearchScreen(),);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: () {
                    BlocProvider.of<AppCubit>(context).changeAppMode();
                  },
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: newsCubit.businessArticles.length > 0 ,
              builder: (context) =>
                  newsCubit.screens[newsCubit.selectedPageIndex],
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

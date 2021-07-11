import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).searchArticles;

        return WillPopScope(
          onWillPop: () async {
            searchController.clear();
            Navigator.of(context).pop();
            NewsCubit.get(context).clearList(navigator: true);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    searchController.clear();
                    Navigator.of(context).pop();
                    NewsCubit.get(context).clearList(navigator: true);
                  }),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    onChange: (String value) {
                      if (value != null && value.isNotEmpty)
                        BlocProvider.of<NewsCubit>(context).getSearch(value);
                      else
                        NewsCubit.get(context).clearList(navigator: false);
                    },
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    fillColor: BlocProvider.of<AppCubit>(context).isDark
                        ? Colors.white
                        : Colors.black12,
                  ),
                ),
                Expanded(
                  child: articleBuilder(
                    list,
                    context,
                    isSearch: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

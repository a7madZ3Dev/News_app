import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsCubit newsCubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ScreenTypeLayout(
          mobile: articleBuilder(
            newsCubit.scienceArticles,
            context,
          ),
          tablet: articleBuilderDeskTop(
            newsCubit.scienceArticles,
            context,
          ),
          desktop: articleBuilderDeskTop(
            newsCubit.scienceArticles,
            context,
          ),
        );
      },
    );
  }
}

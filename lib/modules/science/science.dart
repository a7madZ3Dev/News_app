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
          breakpoints:
              ScreenBreakpoints(watch: 150.0, desktop: 660.0, tablet: 480.0),
          mobile: articleBuilder(
            newsCubit.scienceArticles,
            context,
          ),
          tablet: articleBuilderTablet(
            newsCubit.scienceArticles,
            context,
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child:
                    articleBuilderDeskTop(newsCubit.scienceArticles, context),
              ),
              if(newsCubit.scienceArticles.isNotEmpty) Expanded(
                flex: 1,
                child: articleBuilderDeskTopDetailes(
                    context: context, topic: 'science'),
              )
            ],
          ),
        );
      },
    );
  }
}

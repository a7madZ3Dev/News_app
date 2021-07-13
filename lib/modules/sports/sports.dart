import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsCubit newsCubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ScreenTypeLayout(
          /// height and width
          breakpoints:
              ScreenBreakpoints(watch: 150.0, desktop: 620.0, tablet: 480.0),

          mobile: articleBuilder(
            newsCubit.sportArticles,
            context,
          ),
          tablet: articleBuilderTablet(
            newsCubit.sportArticles,
            context,
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: articleBuilderDeskTop(newsCubit.sportArticles, context),
              ),
              if(newsCubit.sportArticles.isNotEmpty) Expanded(
                flex: 1,
                child: articleBuilderDeskTopDetailes(
                    context: context, topic: 'sport'),
              )
            ],
          ),
        );
      },
    );
  }
}

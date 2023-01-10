import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_Logic/cubit/app_mode_cubit.dart';
import 'package:news_app/app_Logic/cubit/cubit.dart';
import 'package:news_app/app_Logic/cubit/states.dart';
import 'package:news_app/app_Logic/network/remote/dio_helper.dart';
import 'package:news_app/constants/app_mode.dart';
import 'package:news_app/presentation/screens/search_screen.dart';
import 'package:news_app/presentation/widgets/navigate_to.dart';

class NewsLayout extends StatefulWidget {
  NewsLayout({Key? key}) : super(key: key);

  @override
  State<NewsLayout> createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getSciences(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'News App',
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SearchScreen());
                      },
                      icon: Icon(
                        Icons.search,
                      )),
                  IconButton(
                      onPressed: () {
                        AppModeCubit.get(context).changeAppMode();
                      },
                      icon: Icon(
                        Icons.brightness_4_outlined,
                      )),
                ],
              ),
              body: cubit.Screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.ChangeBottomNavBar(index);
                },
                items: cubit.bottomItems,
              ),
            );
          }),
    );
  }
}

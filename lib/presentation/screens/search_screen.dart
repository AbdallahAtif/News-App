import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_Logic/cubit/cubit.dart';
import 'package:news_app/app_Logic/cubit/states.dart';
import 'package:news_app/presentation/widgets/build_article_item.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: TextFormField(
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Search News',
                        prefixIcon: Icon(
                          Icons.search_rounded,
                        )),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) =>
                        buildArticleItem(list[index], context),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

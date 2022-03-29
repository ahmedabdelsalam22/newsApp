import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/layout/news_layout/cubit/cubit.dart';
import 'package:flutter_app/layout/news_layout/cubit/states.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

//  var formKey =GlobalKey<FormState>();
  var searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list =NewsCubit.get(context).search;
        var cubit =NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  labelText: 'search',
                  prefix: Icons.search,
                  OnChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                  child: ConditionalBuilder(
                      condition:list.isNotEmpty,
                      builder: (context){
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index){
                              return buildArticleItem(list[index],context);
                            },
                            separatorBuilder: (context,index){
                              return separatedDivider();
                            },
                            itemCount: cubit.search.length
                        );
                      },
                      fallback:(context)=> const Center(child: CircularProgressIndicator())
                  )
              )
            ],
          ),
        );
      },
    );
  }
}





/*

Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  OnChange: (value){
                    NewsCubit.get(context).getSearch(value);
                  },
                  labelText: 'search',
                  prefix: Icons.search,
                  validate: (value){
                    if(value.isEmpty){
                      return 'Please Enter Any Text';
                    } return null;
                  }
                ),
              ),
              Expanded(
                  child: buildArticleItem(list, context),
              ),
            ],
          ),


 */

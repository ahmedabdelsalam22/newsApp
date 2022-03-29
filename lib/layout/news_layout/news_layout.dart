import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/cubit.dart';
import 'package:flutter_app/layout/news_layout/cubit/states.dart';
import 'package:flutter_app/modules/search/search_screen.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){

        var cubit =NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title:const Text('NewsApp'),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context,SearchScreen());
                  },
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: (){
                  AppCubit.get(context).changeMode();
                  },
                  icon: const Icon(Icons.brightness_4)
              )
            ],
          ),

          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.bottomNavBarTap(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),label: 'Business'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science),label: 'Science'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports),label: 'Sports'
              ),
            ],
          ),
        );
      },
    );
  }
}

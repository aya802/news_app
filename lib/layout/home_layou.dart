import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/modules/search_screen/search_screen.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/cubit2/cubit2.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class HomeLayout extends StatelessWidget {
//  const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder:(context,state) {
        var cubit = NewsCubit.get(context);
       return Scaffold(
          appBar: AppBar(
              title: Text('News App'),
              actions: [
               IconButton(
                   onPressed:(){
                   navigateTo(context,SearchScreen());
                   },
                   icon:Icon(Icons.search)
               ),
                IconButton(
                    onPressed:(){
                    AppCubit.get(context).changeTheme();
                    },
                    icon:Icon(Icons.brightness_4_outlined)
                ),
              ],

            ),


          bottomNavigationBar: BottomNavigationBar(
            items:cubit.bottomItem ,
             currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
          ),
         body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

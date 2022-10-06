import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/cubit2/cubit2.dart';
import 'package:news_app/shared/cubit2/states2.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'layout/home_layou.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
await  CacheHelper.init();
bool? isDark = CacheHelper.getBool(key: 'isDark');
  runApp((MyApp(isDark)));
}


class MyApp extends StatelessWidget {
//  const MyApp({Key? key}) : super(key: key);
   bool? isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness(),),
        BlocProvider(create: (context) => AppCubit()..changeTheme(fromShared: isDark,),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                //   backwardsCompatibility: false,

                  titleSpacing: 20.0,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      systemNavigationBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.dark,

                  ),

                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  iconTheme: IconThemeData(color: Colors.black)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20,
                  backgroundColor: Colors.white
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  elevation: 0.0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                    // systemNavigationBarColor: HexColor('333739')
                  ),
                  backgroundColor: HexColor('333739'),
                  titleTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
            ),
            themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/componants/componants.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
 // const ({Key? key}) : super(key: key);
var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list =NewsCubit.get(context).search;
        return  Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    textOfValidation: 'search must not be empty',
                    lable: 'search',
                    prefix: Icons.search,
                  onChange: (value){
                     NewsCubit.get(context).getSearch(value);
                  }
                ),
              ),
        Expanded(child: articalBuilder(list, context)),
            ],
          ),
        );
      },
    );
  }
}

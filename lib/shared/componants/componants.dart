import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/modules/web_view/web_view.dart';


Widget buildArticalItem(artical,context)=> InkWell(

  onTap: (){
    navigateTo(context, WebViewScreen(artical['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

      child:  Row(
          children: [
           (artical['urlToImage']!=null)? Container(
             width: 120,
             height: 120,

             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
               image: DecorationImage(
                 image: NetworkImage('${artical['urlToImage']}',),
                 fit: BoxFit.cover,
               ),

             ),
           ):Container(
             width: 120,
            height: 120,

            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
           image: NetworkImage('https://bitsofco.de/content/images/2018/12/Screenshot-2018-12-16-at-21.06.29.png',),
            fit: BoxFit.cover,
),

),
),



        SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: Container(

                height: 120.0,

                child: Column(

                  mainAxisSize: MainAxisSize.min,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${artical['title']}',

                        style:Theme.of(context).textTheme.bodyText1,

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                      ),

                    ),

                    Text('${artical['publishedAt']}',style: TextStyle(color: Colors.grey),)



            ],

            ),

            ),



        ),

      ],

    ),

  ),
);
Widget myDivider(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[400],
    ),
  );
}
Widget articalBuilder(list,context)=> ConditionalBuilder(

  condition:  list.length >0,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),

      itemBuilder: (context,index)=>buildArticalItem(list[index],context),
      separatorBuilder:  (context,index)=>myDivider(),
      itemCount: 10
  ),
  fallback: (context) => Center(child: CircularProgressIndicator()),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  VoidCallback? onTab,
  Function? onChange,
  required String textOfValidation,
  required String lable,
  required IconData? prefix,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    onFieldSubmitted: onSubmit,
    onChanged: (s)
    {
      onChange!(s);
    },
    validator: (String? value) {
      if (value!.isEmpty) {
        return '$textOfValidation';
      } else {
        return null;
      }
    },
    decoration: InputDecoration(
      labelText: lable,
      prefixIcon: Icon(prefix),
      border: OutlineInputBorder(),
    ),
    onTap: onTab,
  );
}
void navigateTo(context,Widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder:(context)=>Widget)
);

// String myImg (var x){
//   if( x == null){
//     return'https://bitsofco.de/content/images/2018/12/Screenshot-2018-12-16-at-21.06.29.png';
// }else{
//     return'${artical['urlToImage']}';
//   }
//
// }
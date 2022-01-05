
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/cubit.dart';
import 'package:shop_app/shared/styles/icon_broken.dart';

Widget defaultTextButton({
  required Function function,
  required String text,
  Color color = Colors.lightBlueAccent,
}) =>
   Container(
   child : TextButton(
      onPressed: function(),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
        ),
      ),

    ),
);

Widget defaultAppBar({
//required BuildContext context,
  String? title ,
  List<Widget>? actions,
})=>
AppBar(
  leading: IconButton(
    onPressed: () {
    //  Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  title: Text(
    title!
  ),
  actions: actions,
);


Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: MaterialButton(
          color: color,
          onPressed: () {
            function();
          },
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

Widget defaultTextField({
  required TextEditingController controller,
  bool isPassword = false,
  required TextInputType type,
  Function? onSubmit,
  Function? onTap,
   String? text,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixFunction,
  Function? validate,


  String textForUnValid = 'this element is required',
  //required Function validate,
}) =>
    Container(
      child: TextFormField(
        autocorrect: true,
        controller: controller,
        onTap: () {
          onTap!();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return textForUnValid;
          }
          return null;
        },
        onChanged: (value) {},
        onFieldSubmitted: (value) {
          onSubmit!(value);
        },
        obscureText: isPassword ? true : false,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: () {
              suffixFunction!();
            },
            icon: Icon(suffix),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: const BorderSide(),
              gapPadding: 4),
        ),
      ),
    );

/*
Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40.0,

          child: Text(

              '${model['time']}'

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

              '${model['title']}',

                style:TextStyle (

                  fontWeight: FontWeight.bold,

                  fontSize: 16.0,

                ),

              ),

              Text(

                '${model['date']}',

                style:TextStyle (

                  color: Colors.grey[500],

                ),

              ),

            ],

          ),

        ),

        SizedBox(
          width: 20.0,
        ),

        IconButton(
            onPressed: (){

              AppCubit.get(context)!.updateData

                (
                  status: 'done',
                  id: model['id'],
              );
            },

            icon : Icon(
              Icons.check_box,
              color: Colors.blue,
            )
        ),
        IconButton(
            onPressed: (){
            },

            icon : Icon(
                Icons.archive,
              color: Colors.black38,
            )
        ),
      ],

    ),

  ),
  onDismissed: (direction){
    AppCubit.get(context)!.DeleteData(id: model['id']);
  },
);
Widget tasksBuilder({
 required List<Map> tasks
}) =>
    ConditionalBuilder(
        condition: tasks.length > 0 ,
        builder:(context) => ListView.separated(
          itemBuilder: (context,index) => buildTaskItem
            (  tasks[index ] ,context),

          separatorBuilder: (context,index) => myDivider(),
          itemCount: tasks.length,
        ),
        fallback: (context) =>
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                  Text(
                    'No Tasks yet Please Add Some Tasks',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
    );
*/
Widget BuildArticleItem(artricle,context)  => InkWell(
  onTap: (){
    //NavigateTo(context, WebViewScreen(artricle['url']),);
  },

  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image: NetworkImage('${artricle['urlToImage']}'),

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

              crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${artricle['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    ),

                  ),

                Text(

                  '${artricle['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,



                  ),

                  maxLines: 4,

                  overflow: TextOverflow.ellipsis,

                ),

              ],

            ),

          ),

        ),

      ],



    ),

  ),
);

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
);

Widget articleBuilder(list,context, {isSearch=false}) => ConditionalBuilder(

condition: list.length > 0,
builder:(context) => ListView.separated(
physics: BouncingScrollPhysics(),
itemBuilder:(context,index) => BuildArticleItem(list[index],context),
separatorBuilder: (context,index) => myDivider(),
itemCount: 10
),
fallback: (context)=> isSearch ? Container() : Center(child: CircularProgressIndicator()),
);



void NavigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

void showToast({
  required String message,
  required ToastState state,

}) =>
Fluttertoast.showToast(
msg: message,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 1,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastState{Success , Error , Warning}

Color chooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.Success :
      color = Colors.green;
    break;

    case ToastState.Error :
      color = Colors.red;
      break;

    case ToastState.Warning :
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favorites[model?.id]
                              == true
                              ? Colors.blue
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

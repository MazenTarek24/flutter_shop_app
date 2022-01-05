
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/state.dart';
import 'package:shop_app/models/shop_app_model/shop_category_model.dart';
import 'package:shop_app/shared/components/copmponents.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
        listener: (context,state){},
        builder: (context,state)=> ListView.separated(
          itemBuilder: (context , index) =>
              builtCatItem(ShopCubit.get(context).categoryModel?.data?.dataModel[index]),
          separatorBuilder: (context , index)=> myDivider(),
          itemCount: ShopCubit.get(context).categoryModel!.data!.dataModel.length,
        ),
    );
  }
}

Widget builtCatItem(CategoryDetail? categoryDetail )=> Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage(categoryDetail?.image),
        height: 100,
        width: 100,
      ),
      SizedBox(
        width:20.0,
      ),
      Text(
        categoryDetail?.name,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      )

    ],
  ),
);

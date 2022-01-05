import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/state.dart';
import 'package:shop_app/models/shop_app_model/shop_favourite_model.dart';
import 'package:shop_app/shared/components/copmponents.dart';


class FavoritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState)
          showToast(
              message: state.model?.message, state: ToastState?.Success);
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).itemsInFavorites > 0,
            builder: (context) => ConditionalBuilder(
                condition: state is! ShopLoadingGetFavoritesState,
                builder: (context) => SingleChildScrollView(
                  child: Column(
                      children: [
                  Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    child: Row(
                      children: [
                        Text(
                          'My Wishlist  ',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.lightBlue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 3.0),
                          child: Text(
                            '(${ShopCubit.get(context).itemsInFavorites.toString()} items)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                      ),
          ListView.separated(
            itemBuilder: (context, index) =>
                buildFavItem( ShopCubit.get(context)
                    .favoritesModel!.data.favData[index].product, context)  ,
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit
                .get(context).favoritesModel!.data.favData.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
        ),
              ],
            ),
        ),
        ),
          );
      },
    );
  }

  Widget buildFavItem(ProductFavModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image:
                        NetworkImage(model.image),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0)
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
                            color: Colors.deepOrange,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
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
                            ShopCubit.get(context).changeFavorites(
                                model.id);
                            print(model.id + "idddddddd") ;
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopCubit.get(context).favorites[
                                        model.id]
                                    ? Colors.deepOrange
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
}
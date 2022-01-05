

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/state.dart';
import 'package:shop_app/models/shop_app_model/shop_category_model.dart';
import 'package:shop_app/models/shop_app_model/shop_model.dart';
import 'package:shop_app/shared/components/copmponents.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if (state is ShopSuccessChangeFavoritesState) {
            if (state.model?.status == false) {
              showToast(
                message: state.model?.message,
                state: ToastState.Error,
              );
            }
          }
        }, builder: (context, state) {
      ShopCubit? cubit = ShopCubit.get(context);
      return ConditionalBuilder(
        condition: cubit.homeModel != null && cubit.categoryModel != null,
        builder: (context) =>
            productBuilder(cubit.homeModel!, cubit.categoryModel, context),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
    });
  }
}

Widget productBuilder(HomeModel model , CategoryModel? categoryModel , context)
=>  SingleChildScrollView(

  physics: BouncingScrollPhysics(),
  child:Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items: model.data.banners.map((e) => Image
            (image: NetworkImage('${e.image}'),
            width: double.infinity,
          ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            scrollDirection: Axis.horizontal,
          )
      ),
      SizedBox(
        height: 10.0,
      ),
   Padding(
     padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
     ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           'Category',
           style: TextStyle(
             fontSize: 22,
             fontWeight: FontWeight.w600,
           ),
         ),
            Container(
              height: 100.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder : (context,index) =>
                      buildCategoryBuilder(categoryModel!.data!.dataModel[index],
                  ),
                  separatorBuilder: (context,index) => SizedBox(
                    width: 10,
                  ),
                  itemCount: categoryModel!.data!.dataModel.length,

            ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'New Product',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
       ],
     ),
   ),
      SizedBox(
        height: 15.0,
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
         shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: 1/1.44,
        children:
          List.generate(model.data.products.length,
                (index) =>
                    buildGridProduct(model.data.products[index] , context , index),
            ),

          ),
      ),
  ],
  ),

);

Widget buildCategoryBuilder(CategoryDetail? model) =>
    Stack(
     alignment: AlignmentDirectional.bottomCenter,
     children: [
       Image(
           image: NetworkImage(model?.image),
         height: 100.0,
         width: 100.0,
         fit: BoxFit.cover,
       ),
           Container(
         //    alignment: AlignmentDirectional.bottomCenter,
             color: Colors.black.withOpacity(.8),
             width: 100.0,
             child: Text(
               model?.name,
               maxLines:1,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(
                  color: Colors.white,
               ),
           ),
           ),
         ],
       );

Widget buildGridProduct(ProductModel? model , context , index ) =>
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model?.image),
                width: double.infinity,
                height: 180.0,
              ),
              if (model?.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 6.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model?.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8.0,
                    height: 1.3,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      '${model?.price}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model?.discount != 0)
                      Text(
                        '${model?.oldPrice}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model?.id);
                        print(model?.id ) ;
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                        ShopCubit.get(context).favorites[model?.id]
                            ? Colors.deepOrange
                            :   Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 12.0,
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

    );

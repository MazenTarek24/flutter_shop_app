


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_cupit/state.dart';
import 'package:shop_app/modules/shop_app/search_screen/shop_search_screen.dart';
import 'package:shop_app/shared/components/copmponents.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context , state){},
        builder: (context , state)
        {
          ShopCubit? cubit = ShopCubit.get(context);
         return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    NavigateTo(context, ShopSearchScreen());
                  },
                  icon: (
                      Icon(Icons.search)
                  ),
                )
              ],
            ),
            body: cubit.bottomNavBarScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,

              items: [
                BottomNavigationBarItem(icon: Icon(
                  Icons.home,
                ),
                  label: "Home",
                  backgroundColor: Colors.deepOrange,
                ),
                BottomNavigationBarItem(icon: Icon(
                  Icons.apps,
                ),
                  label: "Category",
                  backgroundColor: Colors.deepOrange,

                ),
                BottomNavigationBarItem(icon: Icon(
                  Icons.favorite,
                ),
                  label: "Favourites",
                  backgroundColor: Colors.deepOrange,

                ),
                BottomNavigationBarItem(icon: Icon(
                  Icons.settings,
                ),
                  label: "Settings",
                  backgroundColor: Colors.deepOrange,

                ),
              ],
            ),
          );
        }
      );
  }
}

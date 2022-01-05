import 'package:bloc/bloc.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:shop_app/models/shop_app_model/shop_search_model.dart';

import 'package:shop_app/modules/shop_app/search_screen/state/state.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/end_point/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<SearchStates>
{
  ShopSearchCubit():super(SearchInitialState());

  SearchModel? model;
  static ShopSearchCubit get(context) => BlocProvider.of(context);

  void searchProduct( String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: tokens,
        data: {
          'text' : text,
        }
    ).then((value)
        {
          model = SearchModel.fromJson(value?.data);

          emit(SearchSuccessState());
        }
    ).catchError((onError)
    {
      print(onError.toString());
      emit(SearchErrorState());
    });

  }

}
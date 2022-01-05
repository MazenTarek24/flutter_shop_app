class CategoryModel
{
  bool? status;
  CategoryDataModel? data;

  CategoryModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }

}

class CategoryDataModel {
  int? currentPage;
  List<CategoryDetail> dataModel=[];

  CategoryDataModel.fromJson(Map<String,dynamic> json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
    {
      dataModel.add(CategoryDetail.fromJson(element));
    });
  }

}

class CategoryDetail{
  int? id;
  dynamic? name;
  dynamic? image;

  CategoryDetail.fromJson(Map <String , dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];

  }

}

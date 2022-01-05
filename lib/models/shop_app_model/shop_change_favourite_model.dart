class ChangeFavouriteModel
{
  late bool status;
 late dynamic message;

  ChangeFavouriteModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}

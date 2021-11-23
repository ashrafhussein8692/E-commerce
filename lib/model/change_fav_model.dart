/// status : false
/// message : "لم يتم العثور علي اي بيانات"
/// data : null

class ChangeFavModel {


  ChangeFavModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];

  }
  bool? status;
  String? message;




}
import 'package:bloc/bloc.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/modules/login/cubit/states.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:e_commerce/shared/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

static  LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingStates());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value.data);
      userModel = UserModel.fromJson(value.data);
      emit(LoginSuccessStates(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates());
    });
  }
}

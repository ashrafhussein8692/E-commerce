import 'package:e_commerce/model/user_model.dart';


abstract class LoginStates{}
class LoginInitialStates extends LoginStates{}
class LoginLoadingStates extends LoginStates{}
class LoginSuccessStates extends LoginStates{
  final UserModel userModel;

  LoginSuccessStates(this.userModel);
}
class LoginErrorStates extends LoginStates{}

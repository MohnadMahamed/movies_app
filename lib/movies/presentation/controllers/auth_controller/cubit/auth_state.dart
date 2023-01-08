part of 'auth_cubit.dart';

// abstract class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object> get props => [];
// }
abstract class AuthState {}

class LoginInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginErrorState extends AuthState {}

class LoginSucessState extends AuthState {}

class SingupLoadingState extends AuthState {}

class SingupErrorState extends AuthState {}

class SingupSucessState extends AuthState {}

class ChangLoginPassVisibilityState extends AuthState {}

class ChangRegisterPassVisibilityState extends AuthState {}

class LogOutState extends AuthState {}

class GetCurrentUserState extends AuthState {}

class UploadCamaraImageState extends AuthState {}

class UploadGalleryImageState extends AuthState {}

class UpdateImageState extends AuthState {}

class UpdateUserDataLoadingState extends AuthState {}

class UpdateUserDataSuccessState extends AuthState {}

class UpdateFavouriteListState extends AuthState {}

class AddToFavouriteState extends AuthState {}

class RemoveFromFavouriteState extends AuthState {}

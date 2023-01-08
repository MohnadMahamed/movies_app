import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/movies/data/datasource/firestore_user.dart';
import 'package:movies_app/movies/data/models/user_model.dart';
import 'package:movies_app/movies/presentation/controllers/auth_controller/local_user_storage.dart';
import 'package:movies_app/movies/presentation/screens/home/home_screen.dart';
import 'package:movies_app/movies/presentation/widgets/toast.dart';
import 'package:path/path.dart' as p;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(LoginInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FacebookLogin _facebookLogin = FacebookLogin();
  // String? email, password, name;
  final Rxn<User?> _user = Rxn<User>();
  String? get user => _user.value?.email;
  final LocalUserStorageData localStorageData = LocalUserStorageData();

  onInit() {
    // super.onInit();
    _user.bindStream(_auth.authStateChanges());
    // getCurrentUser();
    if (_auth.currentUser != null) {
      getCurrentUserData(_auth.currentUser!.uid);
      // getCurrentUser();

    }
    // emit(GetCurrentUserState());
  }

  void googleSignInMethod(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    debugPrint(googleUser.toString());
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential).then((user) {
      saveUser(user);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      loginEmailController.clear();
      loginPasswordController.clear();
      registerEmailController.clear();
      registerPasswordController.clear();
      registerNameController.clear();
      showToast(text: 'Login With Google'.tr, state: ToastStates.success);
      log(user.user!.displayName.toString());
    });
  }

  void facebookSignInMethod() async {
    // FacebookLoginResult result = await _facebookLogin.logIn(['email']);
    // final accessToken = result.accessToken.token;
    // if (result.status == FacebookLoginStatus.loggedIn) {
    //   final faceCredential = FacebookAuthProvider.credential(accessToken);
    //   await _auth.signInWithCredential(faceCredential);
    // }
  }

  void signInWithEmailAndPassword(BuildContext context) async {
    emit(LoginLoadingState());
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: loginEmailController.text,
              password: loginPasswordController.text)
          .then((value) async {
        getCurrentUserData(value.user!.uid);
        // emit(LoginSucessState());
        // getCurrentUserData(_auth.currentUser!.uid);
        // getCurrentUser();
        emit(LoginSucessState());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        loginEmailController.clear();
        loginPasswordController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerNameController.clear();
        showToast(text: 'Login Suc'.tr, state: ToastStates.success);
      });
      // Get.offAll(() => const ControlView());
    } catch (e) {
      emit(LoginErrorState());
      debugPrint(e.toString());
      Get.snackbar('Error login account', e.toString(),
          duration: const Duration(seconds: 10),
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void createAccountWithEmailAndPassword(BuildContext context) async {
    emit(SingupLoadingState());
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: registerEmailController.text,
              password: registerPasswordController.text)
          .then((user) async {
        saveUser(user);
        emit(SingupSucessState());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        loginEmailController.clear();
        loginPasswordController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerNameController.clear();
        showToast(text: 'Sign Up Suc'.tr, state: ToastStates.success);
      });
      debugPrint('نااااااااااااااااا مبسووووووووووط منكك');
      // Get.offAll(() => const ControlView());
    } catch (e) {
      emit(SingupErrorState());
      debugPrint(e.toString());
      Get.snackbar('Error login account', e.toString(),
          duration: const Duration(seconds: 10),
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // final List<dynamic> _fav = [];

  void addToFavourite(int id, String title, String posterPath) async {
    List<dynamic> fav = [
      {'id': id, 'title': title, "posterPath": posterPath}
    ];
    // dynamic favid = _userModel!.favIds.add(id);
    // dynamic favIds() {
    //   favid.add(id);
    //   return favid;
    // }

    // for (int i = 0; i < fav.length; i++) {
    // }
    // fav.add(FavouriteModel(
    //     id: model.id, title: model.title, backdropPath: model.backdropPath));
    // // await updateFav();
    List<dynamic> favId = [id];
    UserModel userModel = UserModel(
        userId: _userModel!.userId,
        name: _userModel!.name,
        email: _userModel!.email,
        pic: _userModel!.pic,
        fav: FieldValue.arrayUnion(fav),
        favIds: FieldValue.arrayUnion(favId));
    await FireStoreUser().updateUserInfo(userModel);
    getCurrentUserData(userModel.userId!);
    showToast(text: 'Add to Fav'.tr, state: ToastStates.success);
    emit(AddToFavouriteState());

    // print(_fav);
  }

  void removeFromFavourite(int id, String title, String posterPath) async {
    List<dynamic> removeList = [
      {'id': id, 'title': title, "posterPath": posterPath}
    ];
    List<dynamic> removeId = [id];

    UserModel userModel = UserModel(
        userId: _userModel!.userId,
        name: _userModel!.name,
        email: _userModel!.email,
        pic: _userModel!.pic,
        fav: FieldValue.arrayRemove(removeList),
        favIds: FieldValue.arrayRemove(removeId));
    await FireStoreUser().updateUserInfo(userModel);
    getCurrentUserData(userModel.userId!);
    showToast(text: 'Favourite Item Deleted'.tr, state: ToastStates.error);

    emit(RemoveFromFavouriteState());
    // print(_fav);
  }

  void removeFavouriteList() async {
    // _removeFav.remove({'id': id, 'title': title, "backdropPath": backPath});
    UserModel userModel = UserModel(
        userId: _userModel!.userId,
        name: _userModel!.name,
        email: _userModel!.email,
        pic: _userModel!.pic,
        fav: FieldValue.arrayRemove(_userModel!.fav),
        favIds: FieldValue.arrayRemove(_userModel!.favIds));

    await FireStoreUser().updateUserInfo(userModel);
    getCurrentUserData(userModel.userId!);
    // FieldValue.arrayRemove(_fav);
    showToast(text: 'Favourite List Deleted'.tr, state: ToastStates.error);

    emit(RemoveFromFavouriteState());
    // print(_removeFav);
  }

  // final List<int> listOfId = [];
  // List<int> listOfFavId() {
  //   return;
  // }
  // updateFav() async {
  //   UserModel userModel = UserModel(
  //     userId: _userModel!.userId,
  //     name: _userModel!.name,
  //     email: _userModel!.email,
  //     pic: _userModel!.pic,
  //     fav: fav,
  //   );
  //   await FireStoreUser().updateUserInfo(userModel);
  //   getCurrentUserData(userModel.userId!);
  // }

  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
      userId: user.user!.uid,
      email: user.user!.email,
      name: (registerNameController.text == "")
          ? user.user!.displayName
          : registerNameController.text,
      pic: user.user!.photoURL ?? 'default',
      fav: const [],
      favIds: const [],
    );
    await FireStoreUser().addUserToFireStore(userModel);
    setUser(userModel);
  }

  void updateUserData() async {
    emit(UpdateUserDataLoadingState());
    file == null ? null : await uploadImage();
    UserModel userModel = UserModel(
        userId: _userModel!.userId,
        name: (updateNameController.text == '')
            ? _userModel!.name
            : updateNameController.text,
        email: (updateEmailController.text == '')
            ? _userModel!.email
            : updateEmailController.text,
        pic: urlDownload ?? _userModel!.pic,
        fav: FieldValue.arrayUnion([]),
        favIds: FieldValue.arrayUnion([]));

    await FireStoreUser().updateUserInfo(userModel);

    updateEmailController.clear();
    updateNameController.clear();
    getCurrentUserData(userModel.userId!);
    showToast(text: 'Update Suc'.tr, state: ToastStates.success);
    emit(UpdateUserDataSuccessState());
    file = null;
  }

  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
  }

  UserModel get userModel => _userModel!;
  UserModel? _userModel;

  getCurrentUserData(String uid) async {
    await FireStoreUser().getCurrentUser(uid).then((value) {
      _userModel = UserModel.fromJson(value.data() as Map<String, dynamic>);
      // emit(GetCurrentUserState());
      setUser(UserModel.fromJson(value.data() as Map<String, dynamic>));
      emit(GetCurrentUserState());
    });
  }

  // void getCurrentUser() async {
  //   await localStorageData.getUser.then((value) {
  //     _userModel = value;
  //   });
  //    emit(GetCurrentUserState());
  //    update();
  // }

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut().then((value) {
      localStorageData.deleteUser();
      showToast(text: 'Logout Suc'.tr, state: ToastStates.success);

      emit(LogOutState());
    });
  }

  bool isPassword = true;
  IconData passwordSuffix = Icons.visibility_off_outlined;

  void changLogingPassVisibility() {
    isPassword = !isPassword;
    passwordSuffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    emit(ChangLoginPassVisibilityState());
  }

  bool isPasswordRegister = true;
  IconData registerPasswordSuffix = Icons.visibility_off_outlined;

  void changRegisterPassVisibility() {
    isPasswordRegister = !isPasswordRegister;
    registerPasswordSuffix = isPasswordRegister
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(ChangRegisterPassVisibilityState());
  }

  XFile? file;
  File? imageFile;
  Future<void> pickCameraImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    file = image!;
    imageFile = File(file!.path);

    emit(UploadCamaraImageState());
  }

  Future<void> pickGalleryImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    file = image!;
    imageFile = File(file!.path);

    emit(UploadGalleryImageState());
  }

  UploadTask? uploadTask;
  String? urlDownload;
  Future<void>? uploadImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final path = file!.path;
    Reference reference = storageRef.child('users_images/${p.basename(path)}');
    uploadTask = reference.putFile(imageFile!);
    final snapshot = await uploadTask!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    emit(UpdateImageState());
  }
}

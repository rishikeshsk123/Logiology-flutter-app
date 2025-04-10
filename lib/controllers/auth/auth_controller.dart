import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logiology/models/user/user_model.dart';
import 'package:logiology/view/main_pages/widgets/bottom_navigation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();

  Rxn<UserModel> currentUser = Rxn<UserModel>();

  final RxString profileImagePath = ''.obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    _loadUserFromStorage();
    super.onInit();
  }

  void _loadUserFromStorage() {
    final data = _storage.read('user');
    if (data != null) {
      currentUser.value = UserModel.fromJson(data);
    }
  }

  Future<void> login(String username, String password) async {
    final data = _storage.read('user');
    if (data == null) {
      // if no user already stored
      if (username == 'admin' && password == 'Pass@123') {
        final defaultUser = UserModel(username: username, password: password);
        await _storage.write('user', defaultUser.toJson());
        currentUser.value = defaultUser;
      } else {
        throw Exception('Invalid credentils');
      }
    } else {
      final storedUser = UserModel.fromJson(data);
      if (storedUser.username == username && storedUser.password == password) {
        currentUser.value = storedUser;
      } else {
        throw Exception('Invalid username or password');
      }
    }
  }

  void logout() {
    currentUser.value = null;
    indexChangeNotifier.value = 0;
  }

  Future<void> updateUser(String? username, String? password) async {
    if (currentUser.value == null) return;

    final updatedUser = UserModel(
      username: username ?? currentUser.value!.username,
      password: password ?? currentUser.value!.password
    );
    await _storage.write('user', updatedUser.toJson());
    currentUser.value = updatedUser;
  }

  Future<void> pickImage(ImageSource source) async{
    await Permission.camera.request();
      await Permission.storage.request();
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 75);
    if(pickedFile != null){
      profileImagePath.value = pickedFile.path;
    }
  }
 
  Future<void> updateProfileImage(String? profilePic) async {
    if (currentUser.value == null) return;

    final updatedUser = UserModel(
      username: currentUser.value!.username,
      password: currentUser.value!.password,
      profilePic: profilePic ?? currentUser.value!.profilePic,
    );
    await _storage.write('user', updatedUser.toJson());
    currentUser.value = updatedUser;
  }

  bool isAuthenticated() => currentUser.value != null;
}

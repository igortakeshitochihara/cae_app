import 'package:cae_app/model/key_model.dart';

abstract class HomeView {
  void onKeyListSuccess(List<KeyModel> keys);

  void onKeyListError(String message);
}
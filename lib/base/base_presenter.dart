import 'base_http.dart';
import 'base_view.dart';

class BasePresenter {
  BaseView view;

  BasePresenter({this.view});

  void onError(dynamic error, Function callback) {
    if (error is HttpException) {
      error.code == 401 ? view.onUnauthenticated() : callback(error.message);
      return;
    }

    if (error is NoSuchMethodError) {
      callback(error.toString());
      return;
    }

    callback('Opss... ocorreu um erro inesperado :(');
  }
}

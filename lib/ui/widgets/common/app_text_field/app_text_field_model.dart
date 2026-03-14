import 'package:stacked/stacked.dart';

class AppTextFieldModel extends BaseViewModel {
  bool _obscureText = false;
  bool get obscureText => _obscureText;
  void setObscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }
}

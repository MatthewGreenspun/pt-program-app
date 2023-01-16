import 'package:mobile/models/user.dart';
import 'package:mobx/mobx.dart';

part 'auth.g.dart';

class Auth = _Auth with _$Auth;

abstract class _Auth with Store {
  @observable
  User? currentUser;

  @computed
  bool get isLoggedIn => currentUser != null;
}

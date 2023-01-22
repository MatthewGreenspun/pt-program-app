import './base.service.dart';

class AuthService extends BaseService {
  AuthService() : super();

  Future<void> login(String email, String password) async {
    final res = await request("/auth/login", Method.post,
        data: {"email": email, "password": password},
        headers: {"content-type": "application/json"},
        auth: false);
    if (res['error'] != null) {
      throw "Authorization Failed";
    }
    if (res['token'] != null) {
      await setAuthToken(res['token']);
    }
  }
}

import 'package:flutter/material.dart';

import './base.service.dart';

class AuthService extends BaseService {
  AuthService() : super();

  Future<void> login(String email, String password) async {
    final res = await request("/auth/login", Method.post,
        data: {"email": email, "password": password},
        headers: {"content-type": "application/json"},
        auth: false);
    if (res['error'] != null) {
      switch (res['error']) {
        case "Unauthorized":
          throw "Incorrect email or password";
        default:
          throw "Failed to log in";
      }
    }
    if (res['token'] != null) {
      await setAuthToken(res['token']);
    }
  }

  Future<void> logout() async {
    await BaseService.secureStorage.delete(key: "token");
  }
}

// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:gen/gen.dart';
import 'package:turdes/product/service/interface/login_operation.dart';
import 'package:turdes/product/service/manager/product_service_manager.dart';
import 'package:turdes/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

final class LoginService extends LoginOperation {
  LoginService({
    required ProductNetworkManager productNetworkManager,
  }) : _networkManager = productNetworkManager;
  final INetworkManager<EmptyModel> _networkManager;

  @override
  Future<LoginResponse?> login(String? email, String? password) async {
    final response =
        await _networkManager.sendRequest<LoginResponse, LoginResponse>(
      ProductServicePath.login.value,
      parseModel: LoginResponse(),
      method: RequestType.POST,
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.fold(
      onSuccess: (data) {
        // If the request is successful, return the data
        return data;
      },
      onError: (error) {
        // If the request fails, handle the error (log it, show an error message, etc.)
        if (kDebugMode) {
          print('Login error: ${error.description}');
        }
        // Return an empty instance of LoginResponse or throw an exception
        return LoginResponse(); // You can return an empty instance instead of null
      },
    );
  }
}

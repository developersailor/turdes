import 'dart:io';

import 'package:flutter/material.dart';
import 'package:turdes/product/init/config/app_environment.dart';
import 'package:vexana/vexana.dart';

/// Product network manager
final class ProductNetworkManager extends NetworkManager<EmptyModel> {
  ProductNetworkManager.base()
      : super(
          options: BaseOptions(
            baseUrl: AppEnvironmentItems.baseUrl.value,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          ),

          // Handle the response using the fold method
        );

  /// Handle error
  /// [onErrorStatus] is error status code [HttStatus]
  void listenErrorState({required ValueChanged<int> onErrorStatus}) {
    interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          onErrorStatus(e.response?.statusCode ?? HttpStatus.notFound);
          return handler.next(e);
        },
      ),
    );
  }
}

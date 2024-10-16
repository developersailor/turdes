import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends INetworkModel<LoginResponse> with EquatableMixin {
  LoginResponse({this.accessToken, this.refreshToken});

  /// Get user from json
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  final String? accessToken;
  final String? refreshToken;

  @override
  List<Object?> get props => [accessToken, refreshToken];

  /// User model to map object
  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    return _$LoginResponseFromJson(json);
  }

  LoginResponse copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

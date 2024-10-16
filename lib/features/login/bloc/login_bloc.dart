import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:turdes/product/cache/product_cache.dart';
import 'package:turdes/product/service/login_service.dart';

import 'package:turdes/features/login/validate/password_validate.dart';
import 'package:turdes/features/login/validate/username_validate.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginService authenticationOperation,
    required ProductCache productCache,
  })  : _authenticationOperation = authenticationOperation,
        _productCache = productCache,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginButtonPressed>(_login);
  }

  final LoginService _authenticationOperation;
  final ProductCache _productCache;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.username, password]),
      ),
    );
  }

  Future<void> _login(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) {
      return;
    }
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final response = await _authenticationOperation.login(
        event.email,
        event.password,
      );

      if (response != null && response.accessToken != null) {
        saveToken(response.accessToken);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            error: 'Invalid login credentials',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  void saveToken(String? token) {
    if (token != null) {
      _productCache.userCacheOperation.write('token', token);
    }
  }
}

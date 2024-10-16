import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:turdes/features/login/bloc/login_bloc.dart';

import 'package:turdes/features/login/view/mixin/login_mixin.dart';
import 'package:turdes/product/state/base/base_state.dart';
import 'package:turdes/product/widget/button/index.dart';
import 'package:turdes/product/widget/padding/project_padding.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> with LoginScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.success) {
            // Başarılı giriş durumunda yönlendir
            context.navigateNamedTo('/home');
          } else if (state.status == FormzSubmissionStatus.failure) {
            // Hata mesajını göster
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const ProjectPadding.allMedium(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'E-posta'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Şifre'),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.status == FormzSubmissionStatus.inProgress) {
                    return const CircularProgressIndicator();
                  } else if (state.status == FormzSubmissionStatus.failure) {
                    return Text(state.error);
                  }
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.navigateNamedTo('/register');
                        },
                        child: const Text('Register'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                          if (state.status == FormzSubmissionStatus.success) {
                            context.navigateNamedTo('/home');
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

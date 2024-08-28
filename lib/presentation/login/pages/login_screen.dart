import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoftcares_mt/core/colors/colors.dart';
import 'package:zoftcares_mt/core/constants/styles.dart';
import 'package:zoftcares_mt/presentation/home/pages/home_screen.dart';
import 'package:zoftcares_mt/presentation/login/bloc/login_bloc.dart';
import 'package:zoftcares_mt/presentation/login/bloc/version_bloc.dart';
import 'package:zoftcares_mt/presentation/login/widgets/form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<VersionBloc>(context).add(FetchVersion());

    return Scaffold(
      backgroundColor: kblack,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Formfield(labelText: 'Email', controller: emailController),
              height10,
              Formfield(labelText: 'Password', controller: passwordController),
              height10,
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState?.validate() ?? false) {
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginButtonPresses(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    });
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid email or password')),
                    );
                  } else if (state is LoginSessionExpired) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Session Expired')),
                    );
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator();
                    }
                    return const SizedBox(); 
                  },
                ),
              ),
              BlocBuilder<VersionBloc, VersionState>(
                builder: (context, state) {
                  if (state is VersionLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is VersionLoaded) {
                    return Text(
                      'Version ${state.version}',
                      style: TextStyle(color: kwhite),
                    );
                  } else if (state is VersionError) {
                    return Text(
                      'Error: ${state.message}',
                      style: TextStyle(color: kwhite),
                    );
                  }
                  return Text(
                    'No version data',
                    style: TextStyle(color: kwhite),
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

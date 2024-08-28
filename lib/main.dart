import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zoftcares_mt/core/securestorage/secure_storage.dart';
import 'package:zoftcares_mt/presentation/home/bloc/post_bloc.dart';
import 'package:zoftcares_mt/presentation/home/pages/home_screen.dart';
import 'package:zoftcares_mt/presentation/login/bloc/login_bloc.dart';
import 'package:zoftcares_mt/presentation/login/bloc/version_bloc.dart';
import 'package:zoftcares_mt/presentation/login/pages/login_screen.dart';

void main() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  WidgetsFlutterBinding.ensureInitialized();

  final accessToken = await getAccessToken();
  final expiryDate = await getTokenExpiryTime();
  bool isLoggedIn = false;
  if (accessToken != null &&
      expiryDate != null &&
      expiryDate.isAfter(DateTime.now())) {
    isLoggedIn = true;
  } else {
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: expiryTimeKey);
  }
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => VersionBloc()),
        BlocProvider(create: (context) => PostBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLoggedIn ? const HomeScreen() : LoginScreen(),
      ),
    );
  }
}

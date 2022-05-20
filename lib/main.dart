import 'package:about_canada/view/screens/home_screen.dart';
import 'package:about_canada/view_model/country_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'model/repository/country_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    CountryRepository repo = CountryRepositoryImpl();
    CountryViewModel viewModel = CountryViewModelImpl(repo: repo);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: viewModel),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Countries',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_watch/screens/home.dart';

Future main() async {
  await dotenv.load();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(Theme.of(context)
            .textTheme
            .copyWith(
                bodyMedium: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w500))),
      ),
      home: const Home(),
    );
  }
}

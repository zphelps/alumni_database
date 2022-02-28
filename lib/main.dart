import 'package:alumni_database/profiles/profile_model.dart';
import 'package:alumni_database/sample_data.dart';
import 'package:alumni_database/views/profile/profile.dart';
import 'package:alumni_database/views/search/search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await Firebase.initializeApp();

  runApp(const ProviderScope(
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Park Tudor Alumni Directory',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();
            return true;
          },
          child: const Search()
      ),
    );
  }
}

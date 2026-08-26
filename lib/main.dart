import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_nav.dart';
void main(){runApp(const IraqAIApp());}
class IraqAIApp extends StatelessWidget{const IraqAIApp({super.key});@override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false,title:'IraqAI Chat+',theme:ThemeData.dark().copyWith(scaffoldBackgroundColor:const Color(0xFF0A0A0F),textTheme:GoogleFonts.tajawalTextTheme(ThemeData.dark().textTheme)),home:const MainNavScreen(),locale:const Locale('ar'));}}

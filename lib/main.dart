import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
const GEMINI_API_KEY = String.fromEnvironment('GEMINI_API_KEY', defaultValue: 'MISSING');
void main()=>runApp(const IraqAIApp());
class IraqAIApp extends StatelessWidget{const IraqAIApp({super.key});@override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false,theme:ThemeData.dark(),home:const ChatPage());}}
class ChatPage extends StatefulWidget{const ChatPage({super.key});@override State<ChatPage> createState()=>_C();}
class _C extends State<ChatPage>{
  final ctrl=TextEditingController();
  final msgs=<Map<String,String>>[{"role":"ai","text":"هلا ابراهيم! 🇮🇶 انا IraqAI مربوط بـ Gemini الحقيقي!"}];
  bool loading=false; ChatSession? chat;
  @override void initState(){super.initState(); if(GEMINI_API_KEY!='MISSING'){final m=GenerativeModel(model:'gemini-1.5-flash',apiKey:GEMINI_API_KEY); chat=m.startChat();}}
  void send() async {if(ctrl.text.isEmpty) return; final q=ctrl.text; setState((){msgs.add({"role":"user","text":q}); loading=true;}); ctrl.clear(); try{final r=await chat!.sendMessage(Content.text(q)); setState(()=>msgs.add({"role":"ai","text":r.text??'error'}));}catch(e){setState(()=>msgs.add({"role":"ai","text":'خطأ: $e'}));} setState(()=>loading=false);}
  @override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('IraqAI Chat+ • Live Gemini')),body:Column(children:[Expanded(child:ListView.builder(padding:const EdgeInsets.all(12),itemCount:msgs.length,itemBuilder:(c,k){final m=msgs[k];final isU=m['role']=='user';return Align(alignment:isU?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:const EdgeInsets.symmetric(vertical:6),padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:isU?Colors.deepPurple:const Color(0xFF1E1E2A),borderRadius:BorderRadius.circular(18)),child:Text(m['text']!)));})), if(loading) const LinearProgressIndicator(), Row(children:[Expanded(child:Padding(padding:const EdgeInsets.all(8),child:TextField(controller:ctrl,decoration:InputDecoration(hintText:'احجي عراقي...',border:OutlineInputBorder(borderRadius:BorderRadius.circular(25))),onSubmitted:(_)=>send()))),IconButton(onPressed:send,icon:const Icon(Icons.send))])])) ;}
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main()=>runApp(const IraqAIApp());

class IraqAIApp extends StatelessWidget{
  const IraqAIApp({super.key});
  @override
  Widget build(BuildContext c){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:const Color(0xFF0A0A0F),
        textTheme: GoogleFonts.tajawalTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF12121A), centerTitle:true),
      ),
      home: const MainNav(),
    );
  }
}

class MainNav extends StatefulWidget{const MainNav({super.key});@override State<MainNav> createState()=>_N();}
class _N extends State<MainNav>{
  int i=0;
  @override Widget build(BuildContext c){
    final pages = [const ChatPage(), const ChannelsPage(), const ReelsPage(), const WalletPage(), const ProfilePage()];
    return Scaffold(
      body: pages[i],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF12121A),
        selectedIndex: i,
        onDestinationSelected: (x)=>setState(()=>i=x),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.smart_toy), label: 'الذكاء'),
          NavigationDestination(icon: Icon(Icons.explore), label: 'القنوات'),
          NavigationDestination(icon: Icon(Icons.video_library), label: 'ريلز'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          NavigationDestination(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// --- Chat ---
class ChatPage extends StatefulWidget{const ChatPage({super.key});@override State<ChatPage> createState()=>_C();}
class _C extends State<ChatPage>{
  final ctrl=TextEditingController();
  final msgs=<Map<String,String>>[{"role":"ai","text":"هلا إبراهيم! 🇮🇶 أنا IraqAI Chat+ \nأحجي وياي عراقي، انكليزي، اسألني عن دراسة، كود، وصفات، كلشي!"}];
  void send(){
    if(ctrl.text.trim().isEmpty) return;
    setState(){msgs.add({"role":"user","text":ctrl.text});}
    final q=ctrl.text; ctrl.clear();
    Future.delayed(const Duration(milliseconds:700),(){setState(()=>msgs.add({"role":"ai","text":"فهمت: '$q'\n\nهاي إجابة تجريبية، راح نربطها بـ OpenAI / Gemini API بعدين حتى تجاوبك ذكاء حقيقي + تحفظ المحادثات."}));});
  }
  @override Widget build(BuildContext c){
    return Scaffold(
      appBar: AppBar(title: const Text('IraqAI Chat+')),
      body: Column(children:[
        Expanded(child: ListView.builder(padding:const EdgeInsets.all(12),itemCount:msgs.length,itemBuilder:(c,k){
          final m=msgs[k]; final isUser=m['role']=='user';
          return Align(alignment:isUser?Alignment.centerRight:Alignment.centerLeft,child:Container(margin:const EdgeInsets.symmetric(vertical:6),padding:const EdgeInsets.all(14),constraints:BoxConstraints(maxWidth: MediaQuery.of(c).size.width*0.8),decoration:BoxDecoration(color:isUser?Colors.deepPurpleAccent:const Color(0xFF1E1E2A),borderRadius:BorderRadius.circular(18)),child:Text(m['text']!,style:const TextStyle(fontSize:16))));
        })),
        SafeArea(child: Row(children:[Expanded(child: Padding(padding:const EdgeInsets.all(8),child: TextField(controller:ctrl,decoration: InputDecoration(hintText:'اكتب سؤالك...',filled:true,fillColor:const Color(0xFF1E1E2A),border:OutlineInputBorder(borderRadius:BorderRadius.circular(25),borderSide:BorderSide.none)),onSubmitted:(_)=>send()))),IconButton.filled(onPressed:send,icon:const Icon(Icons.send))]))
      ]),
    );
  }
}

// --- Channels ---
class ChannelsPage extends StatelessWidget{const ChannelsPage({super.key});@override Widget build(BuildContext c){final chans=[{"name":"التقنية العراقية","subs":"12K"},{"name":"طبخات أم حسين","subs":"45K"},{"name":"رياضة عراقية","subs":"20K"}];return Scaffold(appBar:AppBar(title:const Text('القنوات')),body:ListView.builder(itemCount:chans.length,itemBuilder:(c,i)=>Card(color:const Color(0xFF1E1E2A),margin:const EdgeInsets.all(8),child:ListTile(leading:const CircleAvatar(backgroundColor:Colors.deepPurpleAccent,child:Icon(Icons.play_arrow)),title:Text(chans[i]['name']!),subtitle:Text('${chans[i]['subs']} مشترك'),trailing: ElevatedButton(onPressed:(){}, child: const Text('اشتراك 0.99\$'))))));}}

// --- Reels with earnings ---
class ReelsPage extends StatelessWidget{const ReelsPage({super.key});@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('ريلز - اربح من المشاهدة')),body:PageView.builder(scrollDirection:Axis.vertical,itemCount:5,itemBuilder:(c,i)=>Container(color:Colors.black,child:Stack(children:[Center(child: Text('فيديو ريلز #${i+1}\n شاهد 30 ثانية = 0.01\$',textAlign:TextAlign.center,style:const TextStyle(fontSize:22))),Positioned(bottom:20,right:20,child:Column(children:[IconButton(onPressed:(){},icon:const Icon(Icons.favorite,size:35)),const Text('2.1K'),const SizedBox(height:20),IconButton(onPressed:(){},icon:const Icon(Icons.attach_money,size:35)),const Text('ارباحك: 0.12\$')]))]))));}}

// --- Wallet ---
class WalletPage extends StatelessWidget{const WalletPage({super.key});@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('المحفظة')),body:Padding(padding:const EdgeInsets.all(20),child:Column(children:[Container(width:double.infinity,padding:const EdgeInsets.all(24),decoration:BoxDecoration(color:Colors.deepPurpleAccent,borderRadius:BorderRadius.circular(20)),child:const Column(children:[Text('رصيدك الحالي',style:TextStyle(fontSize:18)),SizedBox(height:10),Text('12.50 \$',style:TextStyle(fontSize:36,fontWeight:FontWeight.bold)),SizedBox(height:10),Text('≈ 16,500 د.ع')] )),const SizedBox(height:20),ListTile(leading:const Icon(Icons.account_balance),title:const Text('سحب عبر زين كاش / آسيا حوالة'),subtitle:const Text('الحد الأدنى 10\$')),ElevatedButton(onPressed:(){},child:const Text('طلب سحب'))])));}

// --- Profile ---
class ProfilePage extends StatelessWidget{const ProfilePage({super.key});@override Widget build(BuildContext c){return Scaffold(appBar:AppBar(title:const Text('حسابي')),body:ListView(padding:const EdgeInsets.all(16),children:const[CircleAvatar(radius:40,child:Icon(Icons.person,size:50)),SizedBox(height:10),Center(child:Text('Ibrahim Al-Sudani - i97_i_',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold))),ListTile(title:Text('الباقة: المجانية (100 رسالة/يوم)')),ListTile(title:Text('الايميل: ibrahim@example.com')),ListTile(title:Text('تطوير: ربط Firebase + AdMob للأرباح'))]));}


import 'package:app/src/models/person_model.dart';
import 'package:app/src/screens/albums.dart';
import 'package:flutter/material.dart';
import 'package:app/practice.dart';
import 'package:app/src/screens/home.dart';
import 'package:app/src/screens/About.dart';
import 'package:app/src/screens/Profile.dart';
import 'package:app/src/screens/UpdateProfile.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
      '/home' :(context) => const HomePage(),
      '/about':(context) => const About(),
      '/profile':(context)=>  Profile(person: Person(),),
      '/updateProfile':(context) =>  UpdateProfile(person: Person(),),
      '/albums':(context) => const MyAlbums(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var increment='Increment';
  var decrement='Decrement';
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter()
  {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button1(onPressed: _incrementCounter,title: increment,),
            const SizedBox(height: 10,),
            DisplayCounter(count: _counter),
             const SizedBox(height: 10,),
            Button1(onPressed: _decrementCounter,title: decrement,),
            const SizedBox(height: 10,),
            Image.asset('lib/src/resources/assets/images/driver.png'),
          ],
        ),
        bottomNavigationBar: BottomAppBar (
          
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child:Container(height: 50,color:Colors.blue,)
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

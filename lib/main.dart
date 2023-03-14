import 'package:app/src/blocs/profile_bloc/profile_bloc.dart';
import 'package:app/src/blocs/register_bloc/register_b.dart';
import 'package:app/src/blocs/add_task_bloc/add_bloc.dart';
import 'package:app/src/blocs/album_bloc/album_bloc.dart';
import 'package:app/src/blocs/album_bloc/album_events.dart';
import 'package:app/src/blocs/login_bloc/login_bloc.dart';
import 'package:app/src/models/person_model.dart';
import 'package:app/src/screens/add_task.dart';
import 'package:app/src/screens/login.dart';
import 'package:app/src/screens/albums.dart';
import 'package:app/src/screens/sign_up.dart';
import 'package:app/src/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:app/practice.dart';
import 'package:app/src/screens/home.dart';
import 'package:app/src/screens/about.dart';
import 'package:app/src/screens/profile.dart';
import 'package:app/src/screens/update_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AlbumBloc()..add(GetAlbums())),
          BlocProvider(create: ((context) => SignUpBloc())),
          BlocProvider(create: ((context) => LoginBloc())),
          BlocProvider(create: ((context) => AddBloc())),
          BlocProvider(create: ((context) => ProfileBloc()))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const Login(),
            '/signUp': (context) => const SignUp(),
            '/home': (context) => const HomePage(),
            '/about': (context) => const About(),
            '/profile': (context) => const Profile(),
            '/updateProfile': (context) => UpdateProfile(
                  person: Person(),
                ),
            '/albums': (context) => const MyAlbums(),
            '/addTask': (context) => const AddTask(),
            '/TextTest': (context) => const TextTest(),
          },
        ));
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
  var increment = 'Increment';
  var decrement = 'Decrement';
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
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
          Button1(
            onPressed: _incrementCounter,
            title: increment,
          ),
          const SizedBox(
            height: 10,
          ),
          DisplayCounter(count: _counter),
          const SizedBox(
            height: 10,
          ),
          Button1(
            onPressed: _decrementCounter,
            title: decrement,
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset('lib/src/resources/assets/images/driver.png'),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          notchMargin: 4,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 50,
            color: Colors.blue,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

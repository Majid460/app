import 'package:app/src/models/user.dart';
import 'package:app/src/resources/theme/colors.dart';
import 'package:app/src/screens/update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/src/widgets/Drawer/side_drawer.dart';
import 'package:app/src/widgets/buttons/custom_button.dart';
import 'package:isar/isar.dart';

import '../models/person_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  Isar? isar;
  String name = '';
  String email = '';
  String phone = '';
  void instance() async {
    isar = Isar.getInstance('USER');
    final us = await isar?.collection<User>().get(1);
    var e = us?.email;
    setState(() {
      email = e!;
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      fetchData();
    });
  }

  @override
  void initState() {
    super.initState();
    instance();
  }

  void fetchData() {
    final docRef = FirebaseFirestore.instance.collection('user').doc(email);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          name = data['name'];
          phone = data['phone'];
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                  tooltip: 'Drawer',
                )),
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        backgroundColor: LightColors.kDarkYellow,
      ),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(10.0),
                //Top Container
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: LightColors.kDarkYellow,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(48)),
                      width: 80,
                      height: 80,
                      child: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 35.0,
                        backgroundImage: AssetImage(
                          'lib/src/resources/assets/images/avatar.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10, height: 50),
                    Expanded(
                        child: Text(
                      name.isNotEmpty ? name : 'Your Name',
                      style: const TextStyle(fontSize: 25, color: Colors.black),
                    ))
                  ]),
                )),

            // Bottom Container
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: SizedBox(
                    width: 60,
                    height: 20,
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: LightColors.kDarkYellow,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      email.isNotEmpty ? email : 'ABC@gmail.com',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    )),
                  ],
                ),
              ),
            ),
            //Other Container
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: SizedBox(
                    width: 60,
                    height: 20,
                    child: Text(
                      'Phone',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: LightColors.kDarkYellow,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      phone.isNotEmpty ? phone : '03XXXXXXX',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    )),
                  ],
                ),
              ),
            ),
            //Update Profile Button
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Button(
                onPressed: () {
                  Person p = Person.name(name, email, phone);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProfile(
                        person: p,
                      ),
                    ),
                  );
                },
                title: 'Update Profile',
                color: Colors.grey,
                font: 18,
                paddingH: 20,
                paddingV: 16,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4,
        clipBehavior: Clip.antiAlias,
        color: LightColors.kDarkYellow,
        shape: const CircularNotchedRectangle(),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                  tooltip: 'Open navigation menu',
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  tooltip: 'Search',
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
              Expanded(
                flex: 2,
                child: IconButton(
                  tooltip: 'Favorite',
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

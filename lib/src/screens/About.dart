import 'package:flutter/material.dart';
import 'package:app/src/widgets/Drawer/side_drawer.dart';
import 'package:app/src/widgets/buttons/custom_button.dart';
import 'package:app/src/widgets/TextInput/text_field.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
        title: const Text('About'),
        automaticallyImplyLeading: false,
      ),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.blue, width: 4.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: const Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Lorem ipsum dolor sit .',
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 1,
                child: Container(
                  color: Colors.blue[400],
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.blue, width: 4.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: const Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Contact Us

              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextInput(
                      hint: 'Email',
                      textColor: Colors.grey,
                      fontSize: 16,
                      onChanged: (value) {},
                      expands: false,
                      icon: Icons.email,
                      iconColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextInput(
                      hint: 'Comment',
                      textColor: Colors.grey,
                      fontSize: 16,
                      onChanged: (value) {},
                      expands: false,
                      icon: Icons.comment,
                      iconColor: Colors.blue,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Button(
                      onPressed: () {},
                      title: 'Save',
                      color: Colors.blue,
                      font: 18,
                      paddingH: 0,
                      paddingV: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        color: Colors.blue,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Open navigation menu',
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

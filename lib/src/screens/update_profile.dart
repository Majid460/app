import 'package:app/src/blocs/profile_bloc/profile_bloc.dart';
import 'package:app/src/blocs/profile_bloc/profile_event.dart';
import 'package:app/src/resources/theme/colors.dart';
import 'package:app/src/screens/Profile.dart';
import 'package:app/src/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:app/src/models/person_model.dart';
import 'package:app/src/widgets/buttons/custom_button.dart';
import 'package:app/src/widgets/TextInput/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/blocs/profile_bloc/profile_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key, required this.person});
  final Person person;
  @override
  State<UpdateProfile> createState() => _UpdateProfile();
}

class _UpdateProfile extends State<UpdateProfile> {
  String pName = '';
  String pPhone = '03XXXXXXXX';
  String pEmail = '';
  String parentEmail = '';
  String parentName = '';
  String parentPhone = '';
  ProfileBloc bloc = ProfileBloc();
  @override
  void initState() {
    super.initState();
    setState(() {
      parentEmail = widget.person.email;
      parentName = widget.person.name;
      parentPhone = widget.person.phone;
    });
  }

  void update() async {
    String email = pEmail == '' ? parentEmail : pEmail;
    String phone = pPhone == '03XXXXXXXX' ? parentPhone : pPhone;
    String name = pName == '' ? parentName : pName;
    if (name != '' && email != '' && phone != '03XXXXXXXX') {
      final ProfileBloc bloc = BlocProvider.of<ProfileBloc>(context);
      bloc.add(UpdateEvent(email: email, name: name, phone: phone));
    } else {
      var dialog = CustomAlertDialog(
        icon: Icons.warning,
        title: 'Warning',
        message: 'All fields are required',
        onPositivePressed: () {
          Navigator.of(context).pop();
        },
        positiveBtnText: 'OK',
      );
      showDialog(context: context, builder: (BuildContext context) => dialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App Bar
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  tooltip: 'back',
                )),
        title: const Text('Update Profile'),
        backgroundColor: LightColors.kDarkYellow,
        automaticallyImplyLeading: false,
      ),
      //Body
      body: SingleChildScrollView(
        child: Column(children: [
          //Name
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextInput(
                    inputType: TextInputType.name,
                    maxLength: 20,
                    hint: widget.person.name.isNotEmpty
                        ? widget.person.name
                        : 'Your Name',
                    textColor: Colors.black,
                    fontSize: 16,
                    onChanged: (value) {
                      setState(() {
                        pName = value;
                      });
                    },
                    expands: false,
                    icon: Icons.person_rounded,
                    iconColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          // Email
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextInput(
                    inputType: TextInputType.emailAddress,
                    hint: widget.person.email.isNotEmpty
                        ? widget.person.email
                        : 'ABC@gmail.com',
                    textColor: Colors.black,
                    fontSize: 16,
                    onChanged: (value) {
                      setState(() => pEmail = value);
                    },
                    expands: false,
                    icon: Icons.email,
                    iconColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          // Phone
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextInput(
                    inputType: TextInputType.phone,
                    maxLength: 11,
                    hint: widget.person.phone.isNotEmpty
                        ? widget.person.phone
                        : '03XXXXXXX',
                    textColor: Colors.black,
                    fontSize: 16,
                    onChanged: (value) {
                      setState(() => pPhone = value);
                    },
                    expands: false,
                    icon: Icons.phone,
                    iconColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Button(
              onPressed: () {
                update();
              },
              title: 'Save',
              color: Colors.grey,
              font: 18,
              paddingH: 60,
              paddingV: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<ProfileBloc, ProfileStateUpdate>(
              builder: (context, state) {
            if (state is Success) {
              Fluttertoast.showToast(
                  msg: "User Updated Successfully",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0);
              return Center(
                  child: Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                    color: LightColors.kDarkBlue,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Text(
                  'User Updated Successfully',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ));
            }
            if (state is LoadingUser) {
              return Center(
                  child: Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Text(
                  '',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ));
            }
            if (state is Error) {
              return Center(
                  child: Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                    color: LightColors.kDarkBlue,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Text(
                  'Error in updating data',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ));
            }
            return const Text('');
          }, listener: (context, state) {
            if (state is Success) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            }
          })
        ]),
      ),
    );
  }
}

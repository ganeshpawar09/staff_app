import 'package:flutter/material.dart';
import 'package:staff_flutter_app/old%20screen/home_screen1.dart';
import 'package:staff_flutter_app/state/user_state.dart';
import 'package:provider/provider.dart';

class LoginScrrens extends StatefulWidget {
  // static const routeName = '/login-screens';

  @override
  _LoginScrrensState createState() => _LoginScrrensState();
}

class _LoginScrrensState extends State<LoginScrrens> {
  String _username = '';
  String _password = '';
  bool visibility = true;
  final _form = GlobalKey<FormState>();

  void _loginNew() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    bool istoken = await Provider.of<UserState>(
      context,
      listen: false,
    ).loginNow(_username, _password);
    if (istoken) {
      // Navigator.of(context).pushNamed(HomeScreens.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Something is wrong.Try Again"),
              actions: [
                // RaisedButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: Text("OK"),
                // )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Now"),
        backgroundColor: Color(0xff101522),
      ),
      body: Padding(
        //padding: EdgeInsets.all(12),
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        child: loginBody(),
      ),
    );
  }

  loginBody() => SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Welcome to",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Color(0xff101522),fontSize: 20),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                "Sign in to continue",
                style: TextStyle(color: Colors.grey,fontSize: 20,),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter Your Username';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Username",
                  labelText: "Username",
                ),
                onSaved: (v) {
                  _username = v!;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter Your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: Icon(visibility
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  labelText: "Password",
                ),

                onSaved: (v) {
                  _password = v!;
                },
                obscureText: visibility,

              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 45,
                    color: Color(0xff101522),
                    child: ElevatedButton(
                      onPressed: () {
                        _loginNew();
                      },
                      
                      child: Text("Login",style: TextStyle(color: Color(0xff151022),fontSize: 22),),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );

  loginBody1() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            textColor: Colors.green,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome to",
            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.green),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(color: Color(0xff151022)),
          ),
        ],
      );

  loginFields() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter Your Username';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Username",
                ),
                onSaved: (v) {
                  _username = v!;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Enter Your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                onSaved: (v) {
                  _password = v!;
                },
                obscureText: true,
              ),
            ),

          ],
        ),
      );
}

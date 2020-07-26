import 'package:flutter/material.dart';
import 'package:easy_form_fields/easy_form_fields.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FocusFormPage(),
    );
  }
}

class FocusFormPage extends StatefulWidget {
  FocusFormPage({Key key}) : super(key: key);

  @override
  _FocusFormPageState createState() => _FocusFormPageState();
}

class _FocusFormPageState extends State<FocusFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  static void _onSubmit(BuildContext context, GlobalKey<FormState> formKey) {
    if (!formKey.currentState.validate()) {
      return;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The form was submitted successfully.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus Form'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EasyTextFormFieldFocus(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                focusNode: _emailFocus,
                onFieldSubmitted: (String value) {
                  _emailFocus.unfocus();
                  FocusScope.of(context).requestFocus(_nameFocus);
                },
                textInputAction: TextInputAction.next,
                validator: (value) => !value.contains('@') ? 'Not a valid email.' : null,
              ),
              EasyTextFormFieldFocus(
                decoration: const InputDecoration(
                  hintText: 'First name',
                ),
                focusNode: _nameFocus,
                onFieldSubmitted: (String value) {
                  _nameFocus.unfocus();
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? 'Cannot be empty.' : null,
              ),
              EasyTextFormFieldFocus(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                focusNode: _passwordFocus,
                obscureText: true,
                onFieldSubmitted: (String value) {
                  _onSubmit(context, _formKey);
                },
                textInputAction: TextInputAction.done,
                validator: (value) => value.length < 5 ? 'Must be at least 6 characters.' : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    _onSubmit(context, _formKey);
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

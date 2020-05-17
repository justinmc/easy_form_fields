# Easy Form Fields
It can be complicated and verbose to get Flutter's form setup to validate when you want it to. This library provides a few pre-built classes that make some common use cases very easy.

## API
This library exports several variations on [TextFormField](https://master-api.flutter.dev/flutter/material/TextFormField-class.html) that handle validation in various ways. All other parameters on TextFormField are passed through directly to the underlying TextFormField.

### EasyTextFormFieldFocus
Validates when the field has been focused and on any change after that.

```dart
EasyTextFormFieldFocus(
  validator: (String value) => value.length > 5 ? null : 'Must be longer than 5',
),
```

### EasyTextFormFieldUnfocus
Validates only when the field is unfocused.

```dart
EasyTextFormFieldUnfocus(
  validator: (String value) => value.length > 5 ? null : 'Must be longer than 5',
),
```

### Others?
Have a use case that's different than any of the given classes?  Please file an issue or open a pull request!

If you want to roll your own solution, it may also be useful to take a look at the source code of the closest class to what you want. Copy it into your project and make the necessary modifications.

Lastly, don't forget that the default behavior of a TextFormField in Flutter is to validate only on submit, so if that's the behavior you want, there is no need for this libarary!

## Example
The following is a complete example app that shows a form using
EasyTextFormFieldFocus widgets to provide a realistic set of features.

```dart
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
```

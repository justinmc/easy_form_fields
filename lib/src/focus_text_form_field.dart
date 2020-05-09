import 'package:flutter/material.dart';

class FocusTextFormField extends StatefulWidget {
  FocusTextFormField({
    Key key,
    this.decoration,
    this.keyboardType,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
  }) : super(key: key);
  
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  
  @override
  State createState() => FocusTextFormFieldState();
}

class FocusTextFormFieldState extends State<FocusTextFormField> {
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  final FocusNode _focus = FocusNode();
  bool _autovalidate = false;
  
  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (_focus.hasFocus && !_autovalidate) {
        setState(() {
          _autovalidate = true;
        });
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _key,
      autovalidate: _autovalidate,
      decoration: widget.decoration,
      focusNode: _focus,
      keyboardType: widget.keyboardType,
      onFieldSubmitted: (String value) {
        _focus.unfocus();
        FocusScope.of(context).requestFocus(_focus);
        widget.onFieldSubmitted(value);
      },
      textInputAction: widget.textInputAction,
      validator: widget.validator,
    );
  }
}

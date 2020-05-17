import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Validates only after the field has been focused, and on any change after
/// that.
class EasyFocusTextFormField extends StatefulWidget {
  EasyFocusTextFormField({
    Key key,
    this.textFormFieldKey,
    this.autocorrect = true,
    this.autofocus = false,
    this.buildCounter,
    this.controller,
    this.cursorColor,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    this.decoration = const InputDecoration(),
    this.enabled,
    this.enableInteractiveSelection = true,
    this.enableSuggestions = true,
    this.expands = false,
    this.focusNode,
    this.initialValue,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.minLines,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.readOnly = false,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.scrollPhysics,
    this.showCursor,
    this.smartDashesType,
    this.smartQuotesType,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.toolbarOptions,
    this.validator,
  }) : super(key: key);
  
  final bool autocorrect;
  final bool autofocus;
  final InputCounterWidgetBuilder buildCounter;
  final TextEditingController controller;
  final Color cursorColor;
  final Radius cursorRadius;
  final double cursorWidth;
  final InputDecoration decoration;
  final bool enabled;
  final bool enableInteractiveSelection;
  final bool enableSuggestions;
  final bool expands;
  final FocusNode focusNode;
  final String initialValue;
  final List<TextInputFormatter> inputFormatters;
  final Key textFormFieldKey;
  final Brightness keyboardAppearance;
  final TextInputType keyboardType;
  final bool maxLengthEnforced;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final bool obscureText;
  final String obscuringCharacter;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  final GestureTapCallback onTap;
  final bool readOnly;
  final EdgeInsets scrollPadding;
  final ScrollPhysics scrollPhysics;
  final bool showCursor;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final StrutStyle strutStyle;
  final TextStyle style;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextDirection textDirection;
  final TextInputAction textInputAction;
  final ToolbarOptions toolbarOptions;
  final FormFieldValidator<String> validator;
  
  @override
  State createState() => _EasyFocusTextFormFieldState();
}

class _EasyFocusTextFormFieldState extends State<EasyFocusTextFormField> {
  FocusNode _focus;
  bool _autovalidate = false;

  void _focusListener() {
    if (_focus.hasFocus && !_autovalidate) {
      setState(() {
        _autovalidate = true;
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    _focus = widget.focusNode ?? FocusNode();
    _focus.addListener(_focusListener);
  }

  @override
  void didUpdateWidget(EasyFocusTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.focusNode != widget.focusNode) {
      _focus.removeListener(_focusListener);
      _focus = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_focusListener);
  }
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      autovalidate: _autovalidate,
      buildCounter: widget.buildCounter,
      controller: widget.controller,
      cursorColor: widget.cursorColor,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      decoration: widget.decoration,
      enabled: widget.enabled,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableSuggestions: widget.enableSuggestions,
      expands: widget.expands,
      focusNode: _focus,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      key: widget.textFormFieldKey,
      keyboardAppearance: widget.keyboardAppearance,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      scrollPadding: widget.scrollPadding,
      scrollPhysics: widget.scrollPhysics,
      showCursor: widget.showCursor,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textCapitalization: widget.textCapitalization,
      textDirection: widget.textDirection,
      textInputAction: widget.textInputAction,
      toolbarOptions: widget.toolbarOptions,
      validator: widget.validator,
    );
  }
}

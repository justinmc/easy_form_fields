# Easy Form Fields
It can be complicated and verbose to get Flutter's form setup to validate when you want it to. This library provides a few pre-built classes that make some common use cases very easy.

## API
This library exports several variations on [TextFormField](https://master-api.flutter.dev/flutter/material/TextFormField-class.html) that handle validation in various ways. All other parameters on TextFormField are passed through directly to the underlying TextFormField.

### EasyFocusTextFormField
Validates only after the field has been focused, and on any change after that.

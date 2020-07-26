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
A complete example can be found in the `example/` directory of this project. It shows a form using EasyTextFormFieldFocus widgets to provide a realistic set of features.

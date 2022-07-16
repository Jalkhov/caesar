# CesarCrypt

## Usage as CLI

````
dart run cesarcrypt --help

-s, --string        String to be encrypted
-a, --[no-]afore    Returns the original string and the encrypted string in a tabulated table
-h, --help          Show this help
````

```
dart run cesarcrypt -s CESAR
FHVDU
```

```
dart run cesarcrypt -s CESAR -a
+---+---+---+---+---+
| C | E | S | A | R |
+---+---+---+---+---+
| F | H | V | D | U |
+---+---+---+---+---+
```

## Usage as package

```dart
import 'cesarcrypt.dart';

void main() {
    
  var cesarc = CesarCrypt("CESAR", 3);
  var encrypted = cesarc.encrypt();
  print(encrypted);
}
```

## TODO

- [x] Allow assignment of rotation from the command line
- [ ] Support for punctuation marks and numbers (Based on a standard scheme)
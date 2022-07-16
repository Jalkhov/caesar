import 'package:tabular/tabular.dart';
import 'package:args/args.dart';
import 'dart:io';

final letrasup = [
  "A", "B",
  "C", "D",
  "E", "F",
  "G", "H",
  "I", "J",
  "K", "L",
  "M", "N",
  "Ñ", "O",
  "P", "Q",
  "R", "S",
  "T", "U",
  "V", "W",
  "X", "Y",
  "Z", " " // for spaces
];

class CesarCrypt {
  /*
  * Maybe implement named parameters?
  * Or maybe you pass these arguments directly
  * to the encrypt method?
  */
  String message;
  int rot;

  CesarCrypt(this.message, this.rot);

  List separateString() {
    /*
    * For now the string is forced
    * to convert to Upper Case
    */
    return message.toUpperCase().split("");
  }

  List getNewIndexes() {
    var splitMsg = separateString();

    var output = [];
    var listLenght = letrasup.length;

    for (var x = 0; x < splitMsg.length; x++) {
      var letIndex = letrasup.indexOf(splitMsg[x]);
      // var letra = splitMsg[x]; //temp
      // print("$letra - $letIndex");
      var newIndex = letIndex + rot; // index más rotación

      if (newIndex > listLenght) {
        /*
        * Si el nuevo index es mayor que la longitud de la lista
        * de caracteres soportados, se cuenta desde el inicio de
        * la lista cuantas veces sea mayor el nuevo index.
        */
        newIndex = newIndex - letIndex;
      }

      if (letIndex == 27) {
        /* 
        * If the index of the character is equal to 27 it means
        * that it is a space, therefore it is not increased, but
        * it is left the same. The space index is assigned.
        */
        newIndex = letrasup.indexOf(" ");
      }

      output.add(newIndex);
    }
    return output;
  }

  String encrypt({bool afterbefore = false}) {
    var newIndexs = getNewIndexes();
    var output = [];

    for (var x = 0; x < newIndexs.length; x++) {
      output.add(letrasup[newIndexs[x]]);
    }

    switch (afterbefore) {
      case true:
        /*
        * Return original message and encrypted in
        * a tabulate table
        */
        {
          var data = [
            message.split(""),
            output,
          ];

          var tabData = tabular(data, style: Style.mysql, border: Border.all);

          return tabData;
        }

      default:
        /*
        *  Only return encrypted message
        */
        {
          return output.join("");
        }
    }
  }
}

void main(List<String> args) {
  try {
    var parser = ArgParser();
    parser.addOption('string', abbr: 's', help: 'String to be encrypted');
    parser.addOption('rotate',
        abbr: 'r',
        help:
            'Number of positions the letter will be moved from its original position.',
        defaultsTo: '3');

    parser.addFlag('afore',
        abbr: 'a',
        defaultsTo: false,
        help:
            'Returns the original string and the encrypted string in a tabulated table');

    parser.addFlag('help', abbr: 'h', help: 'Show this help', negatable: false);

    var arguments = parser.parse(args);

    if (arguments.wasParsed("help")) {
      print(parser.usage);
      exit(0);
    } else {
      if (!arguments.wasParsed('string')) {
        stderr.writeln('The --string[-s] option is mandatory');
        exit(1);
      }
      var cesar =
          CesarCrypt(arguments['string'], int.parse(arguments['rotate']));
      var encrypted = cesar.encrypt(afterbefore: arguments['afore']);

      print(encrypted);
    }
  } on FormatException catch (e) {
    print(e);
  }
}

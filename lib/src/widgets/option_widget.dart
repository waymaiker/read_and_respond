import 'package:flutter/material.dart';
import 'package:readandrespond/src/constants.dart';


class OptionWidget extends StatelessWidget {
  final String textContent;
  final Function selectOption;
  final bool isSelected;
  final Status textContentColor;
  final Status borderDecoration;
  final String imageContent;
  final int idValue;

  const OptionWidget({
    required this.textContent,
    required this.selectOption,
    this.isSelected = false,
    this.textContentColor = Status.itemUnSelectedOnly,
    this.borderDecoration = Status.itemUnSelectedOnly,
    this.imageContent = '',
    this.idValue = 0,
  });

  @override
  Widget build(BuildContext context){
    Duration duration = imageContent.isEmpty
      ? const Duration(milliseconds: 500)
      : const Duration(milliseconds: 200);

    return GestureDetector(
      onTap: () {
        selectOption();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: AnimatedOpacity(
          opacity: isSelected ? .5 : 1.0,
          duration: duration,
          child: AnimatedContainer(
            margin: const EdgeInsets.only(bottom: 10.0),
            decoration: setBorderDecoration(borderDecoration),
            duration: duration,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: imageContent.isEmpty
                 ? optionWithText(duration)
                 : optionWithImage(duration, context),
              ),
            ),
          )
        )
      ),
    );
  }

  AnimatedDefaultTextStyle optionWithText(Duration duration) {
    return AnimatedDefaultTextStyle(
      duration: duration,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: setTextContentColor(textContentColor)
      ),
      child: Text(textContent)
    );
  }

  AnimatedContainer optionWithImage(Duration duration, BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*.11,
            child: Image.network(
              imageContent,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.02),
          Text(
            textContent,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: setTextContentColor(textContentColor)
            ),
          ),
        ],
      ),
    );
  }

  Color setTextContentColor(Status choice){
    switch(choice){
      case Status.itemSelectedOnly:
        return selectedCardTextContentColor();
      case Status.itemUnSelectedOnly:
        return disabledTextContentColor();
      case Status.itemSelectedFalseAnswer:
        return falseAnswerTextContentColor();
      case Status.itemSelectedOnlyTrueAnswer:
        return trueAnswerTextContentColor();
      default:
        return defaultTextContentColor();
    }
  }

  BoxDecoration setBorderDecoration(Status choice){
    switch(choice){
      case Status.itemSelectedOnly:
        return selectedCardBoxBorderDecoration();
      case Status.itemUnSelectedOnly:
        return disabledBoxBorderDecoration();
      case Status.itemSelectedFalseAnswer:
        return falseAnswerBoxBorderDecoration();
      case Status.itemSelectedOnlyTrueAnswer:
        return trueAnswerBoxBorderDecoration();
      default:
        return defaultBoxBorderDecoration();
    }
  }

  Color defaultTextContentColor() => Colors.grey.shade800;
  Color disabledTextContentColor() => Colors.grey.shade400;
  Color falseAnswerTextContentColor() => Colors.red.shade300;
  Color trueAnswerTextContentColor() => Colors.green.shade300;
  Color selectedCardTextContentColor() => Colors.white;

  BoxDecoration defaultBoxBorderDecoration(){
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.grey.shade600
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
        color: Colors.grey.shade600,
        offset: const Offset(0.0, 1.5),
        ),
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(10)
      ),
      color: Colors.white,
    );
  }

  BoxDecoration disabledBoxBorderDecoration(){
    return defaultBoxBorderDecoration().copyWith(
      border: Border.all(
        width: 2,
        color: Colors.grey.shade300
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
        color: Colors.grey.shade300,
        offset: const Offset(0.0, 1.5),
        ),
      ]
    );
  }

  BoxDecoration falseAnswerBoxBorderDecoration(){
    return defaultBoxBorderDecoration().copyWith(
      border: Border.all(
        width: 2,
        color: Colors.red.shade300
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
        color: Colors.red.shade300,
        offset: const Offset(0.0, 1.5),
        ),
      ]
    );
  }

  BoxDecoration trueAnswerBoxBorderDecoration(){
    return defaultBoxBorderDecoration().copyWith(
      border: Border.all(
        width: 2,
        color: Colors.green.shade300
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
        color: Colors.green.shade300,
        offset: const Offset(0.0, 1.5),
        ),
      ]
    );
  }

  BoxDecoration selectedCardBoxBorderDecoration(){
    return defaultBoxBorderDecoration().copyWith(
      color: Colors.blue.shade300,
      border: Border.all(
        width: 2,
        color: Colors.blue
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
        color: Colors.blue,
        offset: Offset(0.0, 1.5),
        ),
      ]
    );
  }
}
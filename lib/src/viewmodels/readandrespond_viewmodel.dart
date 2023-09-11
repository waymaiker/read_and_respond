import 'package:flutter/material.dart';

import 'package:readandrespond/src/models/option_model.dart';
import 'package:readandrespond/src/models/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readandrespond/src/constants.dart';

final readAndRespondViewModelProvider = ChangeNotifierProvider(
  (ref) => ReadAndRespondViewModel()
);

class ReadAndRespondViewModel extends ChangeNotifier {
  late QuestionModel question;
  late int optionSelected;
  late List<Status> optionsStatus;
  late List<OptionModel> optionsList;
  late Function showButtonBottomSheet;

  void initViewModel(QuestionModel questionReceived, Function buttonBottomSheet){
    optionsList = [];
    optionSelected = -1;
    questionReceived.options.shuffle();
    question = questionReceived;
    showButtonBottomSheet = buttonBottomSheet;
    optionsStatus = List.filled(3, Status.itemUnSelectedOnly);

    optionsList = List.generate(
      question.options.length,
      (index) => OptionModel(id: index, value: question.options[index])
    );
  }

  bool isQuestionValidated(){
    return question.isSucceded();
  }

  bool isVerifyable(){
    return !question.isFinished();
  }

  bool isGoodAnswerFound(){
    return optionsStatus.contains(Status.itemSelectedOnlyTrueAnswer) ;
  }

  void resetSelectedOption(){
    for(var i = 0; i < optionsList.length; i++){
      optionsList[i].isSelected = false;
      setOptionStatus("optionUnSelected", i);
    }
  }

  void selectOption(int index){
    resetSelectedOption();

    optionSelected = index;
    question.proposition = optionsList[index].value;
    onOptionClick(index);
    notifyListeners();
  }

  void onOptionClick(int index){
    optionsList[index].setIsSelected();
      String statusValue = optionsList[index].getIsSelected()
        ? "optionSelected"
        : "optionUnSelected";

    setOptionStatus(statusValue, index);
    notifyListeners();
  }

  void setOptionStatus(String status, int index){
    switch(status){
      case "goodAnswer":
        optionsStatus[index] = Status.itemSelectedOnlyTrueAnswer;
        break;
      case "wrongAnswer":
        optionsStatus[index] = Status.itemSelectedFalseAnswer;
        break;
      case "optionSelected":
        optionsStatus[index] = Status.itemSelectedOnly;
        break;
      case "optionUnSelected":
        optionsStatus[index] = Status.itemUnSelectedOnly;
        break;
      default:
        optionsStatus[index] = Status.itemUnSelectedOnly;
    }
    notifyListeners();
  }

  Status getOptionStatus(int index){
    return optionsStatus[index];
  }
}

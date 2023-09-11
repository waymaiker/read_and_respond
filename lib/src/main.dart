import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:readandrespond/src/models/question_model.dart';
import 'package:readandrespond/src/viewmodels/readandrespond_viewmodel.dart';
import 'package:readandrespond/src/widgets/button_bottom_sheet_widget.dart';
import 'package:readandrespond/src/widgets/button_widget.dart';
import 'package:readandrespond/src/widgets/list_options_widget.dart';
import 'package:readandrespond/src/widgets/text_widget.dart';

class ReadAndRespond extends HookWidget {
  final int id;
  final String title;
  final String titleButton;
  final String titleButtonSheet;
  final List<String> options;
  final String answer;
  final String answerTranslation;
  final Function action;
  final Function setQuestionResult;
  final String feedbackMessage;
  final String text;
  final String questionText;

  const ReadAndRespond({
    required this.id,
    required this.title,
    required this.options,
    required this.answer,
    required this.answerTranslation,
    required this.action,
    required this.setQuestionResult,
    required this.text,
    required this.questionText,
    this.titleButton = 'NEXT',
    this.titleButtonSheet = 'NEXT',
    this.feedbackMessage = 'SUPER'
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(readAndRespondViewModelProvider);
    int optionSelected = -1;
    late PersistentBottomSheetController buttonBottomSheet;

    void closeButtonBottomSheet(){
      buttonBottomSheet.close();
    }

    void showButtonBottomSheet(BuildContext context) {
      buttonBottomSheet = showBottomSheet<void>(
        enableDrag: false,
        context: context,
        builder: (context) {
          return ButtonBottomSheetWidget(
            type: viewModel.question.isSucceded(),
            feedbackMessage: feedbackMessage,
            answer: viewModel.question.getAnswer(),
            answerTranslation: answerTranslation,
            actionButton: ButtonWidget(
              action: () {
                action();
                closeButtonBottomSheet();
              },
              title: titleButtonSheet,
              type: viewModel.question.isSucceded() ? 'goodAnswer' : 'wrongAnswer'
            )
          );
        }
      );
    }

    useEffect((){
      QuestionModel question = QuestionModel(
        options: options,
        answer: answer
      );

      viewModel.initViewModel(
        question,
        () => showButtonBottomSheet(context)
      );
    }, [id]);

    useEffect((){
      optionSelected = viewModel.optionSelected;
    }, [optionSelected]);

    return SizedBox(
      height: MediaQuery.of(context).size.height*.915,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: title, fontSize: 22),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                TextWidget(text: text, isLongText: true, isBold: false, fontSize: 16),
                SizedBox(height: MediaQuery.of(context).size.height*0.05),
                TextWidget(text: questionText, fontSize: 18),
              ],
            ),
          ),
          ListOptionsWidget(viewModel: viewModel),
          SizedBox(height: MediaQuery.of(context).size.height*0.05),
          ButtonWidget(
            action: viewModel.question.isFinished()
              ? () {
                setQuestionResult(viewModel.question.isSucceded());
                viewModel.setOptionStatus(
                  viewModel.question.isSucceded()
                    ? 'goodAnswer'
                    : 'wrongAnswer',
                  viewModel.optionSelected
                );
                if(!viewModel.question.isSucceded()){
                  viewModel.setOptionStatus('goodAnswer', viewModel.question.getAnswerIndex());
                }
                showButtonBottomSheet(context);
              }
              : () => {},
            title: titleButton,
            type: viewModel.question.isFinished() ? 'enabled' : 'default'
          ),
        ],
      ),
    );
  }
}
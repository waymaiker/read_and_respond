import 'package:flutter/material.dart';
import 'package:readandrespond/src/viewmodels/readandrespond_viewmodel.dart';
import 'package:readandrespond/src/widgets/option_widget.dart';

class ListOptionsWidget extends StatelessWidget {
  final ReadAndRespondViewModel viewModel;

  const ListOptionsWidget({
    required this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    var gridPadding = EdgeInsets.only(
      left: MediaQuery.of(context).size.width*0.05,
      right: MediaQuery.of(context).size.width*0.05
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.3,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          padding: gridPadding,
          itemCount: viewModel.optionsList.length,
          itemBuilder: (BuildContext context, int index) {
            return OptionWidget(
              textContent: viewModel.optionsList[index].value,
              isSelected: viewModel.optionsList[index].getIsSelected(),
              selectOption: viewModel.optionsList[index].getIsSelected() || viewModel.isGoodAnswerFound() ? () => {} : () => viewModel.selectOption(index),
              borderDecoration: viewModel.getOptionStatus(index),
              textContentColor: viewModel.getOptionStatus(index),
            );
          }
        ),
      )
    );
  }
}
/*
 * An option
 */
class OptionModel {
  final int id;
  final String value;
  bool isSelected;

  OptionModel({
    required this.id,
    required this.value,
    this.isSelected = false
  });

  void setIsSelected(){
    isSelected = !isSelected;
  }

  bool getIsSelected(){
    return isSelected;
  }
}
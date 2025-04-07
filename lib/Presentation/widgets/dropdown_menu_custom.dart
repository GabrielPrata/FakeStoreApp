import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownMenuCustom extends StatefulWidget {
  final List<String> data;
  final void Function() onOptionSelected; 
  final String defaultText;

  const DropdownMenuCustom({
    super.key,
    required this.data,
    required this.onOptionSelected,
    required this.defaultText,
  });

  @override
  State<DropdownMenuCustom> createState() => _DropdownMenuCustomState();
}

class _DropdownMenuCustomState extends State<DropdownMenuCustom> {
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                widget.defaultText,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.data
            .map((String item) => DropdownMenuItem<int>(
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (newValue) {
          setState(() {
            // selectedValue = newValue;
            // final selectedCourse = widget.data.firstWhere(
            //   (course) => course['id'] == newValue,
            // );
            // if (selectedCourse != null) {
            //   widget.onOptionSelected(selectedCourse['id'], selectedCourse['nome']);
            // }
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 70,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Theme.of(context).colorScheme.secondary,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 400,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

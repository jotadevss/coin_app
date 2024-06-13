import 'package:coin_app/app/interactor/actions/conversor_actions.dart';
import 'package:coin_app/app/interactor/atoms/conversor_atoms.dart';
import 'package:coin_app/app/shared/formatters/currency_formatter.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputValueForm extends StatefulWidget {
  const InputValueForm({super.key, required this.prefixCurrencyInCode});

  final String prefixCurrencyInCode;

  @override
  State<InputValueForm> createState() => _InputValueFormState();
}

class _InputValueFormState extends State<InputValueForm> {
  TextEditingController? inputValueController;

  @override
  void initState() {
    super.initState();

    inputValueController = TextEditingController(text: CurrencyFormatter.format((inputValueState.value * 100).toString()));
  }

  @override
  void dispose() {
    super.dispose();
    inputValueController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextField(
        onTap: () {
          final isOutInitRange = inputValueController!.selection.baseOffset < inputValueController!.text.length;
          if (isOutInitRange) {
            setState(() {
              final toFinalSelection = TextSelection.fromPosition(TextPosition(offset: inputValueController!.text.length));
              inputValueController!.selection = toFinalSelection;
            });
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
          CurrencyFormatter(),
        ],
        controller: inputValueController,
        onChanged: (text) {
          if (text.isEmpty) {
            inputValueController!.text = CurrencyFormatter.format("100");
            conversorAction.setValue(ChangeInputValueRateAction(valueFormatted: inputValueController!.text));
          }

          conversorAction.setValue(ChangeInputValueRateAction(valueFormatted: text));
          inputValueState.setValue(CurrencyFormatter.unformat(text));
        },
        keyboardType: TextInputType.number,
        textDirection: TextDirection.rtl,
        cursorColor: Colors.black,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixText: widget.prefixCurrencyInCode,
          prefixStyle: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: AppStyle.kGrayFontColor.withOpacity(0.2),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

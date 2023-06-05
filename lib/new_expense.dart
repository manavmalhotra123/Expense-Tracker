import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my4/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  
  final void Function(Expense exp) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  // String newTitle = '';

  // void _inputTitle(String input){
  //   newTitle = input;
  // }

  final List<Expense> addexp = [];
  Category _selectedCategory = Category.leisure;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void onAddExpense(Expense exp){
    setState(() {
      addexp.add(exp);
    });
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);

    // it will return either true or false for the invalid amount conditions
    final amountValid = (enteredAmount == null) || (enteredAmount < 0);

    // conditions for validating the expense that user is going to enter
    if ((_titleController.text.trim().isEmpty) ||
        amountValid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Invalid Input',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text("Enter valid amount,Title or date...."),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                icon: const Icon(Icons.close))
          ],
        ),
      );
      return;
    }
    
    
    widget.onAddExpense(
      Expense(
       _selectedDate!,
       _titleController.text,
       enteredAmount,
       _selectedCategory
      ),
    );

    // for closing the overlay after adding the new expense
    Navigator.pop(context);
 
  }

  @override
  // function that is used to dipose off or to terminate the controller when the widget is closed hence saving it from
  // excess device memory problem
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:45,horizontal: 10),
      child: Column(
        children: [
          
          const Text(
            "New Expense",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            // onChanged: _inputTitle,
            controller: _titleController, // for handling the value of title
            maxLength: 40,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '₹ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "no Date Selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // const Spacer(),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              // for the selection of category of the expense
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toLowerCase())),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(onPressed: _submitExpense, child: const Text("Add")),
              const SizedBox(
                width: 10,
              ),
              // const Spacer(),
              // cancel button
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my4/expense_list.dart';
import 'package:my4/models/expense.dart';
import 'package:my4/new_expense.dart';
import 'package:my4/chart.dart';

// stateful widget
class Expenses extends StatefulWidget {
  // widget constructor
  const Expenses({super.key});

  // being stateful widget it will create the state of the UI
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenes = [
      Expense(DateTime.now(), 
      'Flutter Course',
      55, 
      Category.work)
  ];

  // function that will open the window through which we can add the new expense
  void _openAddExpenseOverlay() {
    // here ctx is also the context
    showModalBottomSheet(
        // for the sheet not to overlap the keyboard
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense exp) {
    setState(() {
      _registeredExpenes.add(exp);
    });
  }

  void _removeExpense(Expense exp) {
    setState(() {
      _registeredExpenes.remove(exp);
    });

    // for displaying the snackbar message after deleting the expense
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted!!!!!!"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              _registeredExpenes.add(exp);
            });
          },
        ),
      ),
    );
  }

  // build method for dynamic changes in the UI
  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 200),
        child: Text("No expenses Found!!!"),
      ),
    );

    if (_registeredExpenes.isNotEmpty) {
      mainContent = Expanded(
          child: ExpenseList(
              expenses: _registeredExpenes, onRemoveExpense: _removeExpense));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker"),
        titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Times New Roman'),
        backgroundColor: const Color.fromARGB(190, 16, 26, 218),
        actions: [
          IconButton(
              onPressed: () {
                _openAddExpenseOverlay();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenes),
          mainContent
        ],
      ),
    );
  }
}

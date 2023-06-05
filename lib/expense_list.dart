import 'package:flutter/material.dart';
import 'package:my4/expense_card.dart';
import 'package:my4/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses,required this.onRemoveExpense});
 
  final List<Expense> expenses;
  final void Function(Expense exp) onRemoveExpense;

  @override
  Widget build(context) {
    // number of items build in case of list is equal to lenght of expenses list which is keeping the record of the expnses we are going to keep the record of.....
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) =>
          Dismissible(
          onDismissed: (direction){
             onRemoveExpense(expenses[index]);
          },  
          key: ValueKey(key), 
          child: ExpenseCard(expenses[index])),
    );
    // expenses[index] is used to pick the single value for each widget
  }
}

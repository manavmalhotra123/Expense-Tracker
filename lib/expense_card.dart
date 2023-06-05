import 'package:flutter/material.dart';
import 'package:my4/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard (this.expense,{super.key});
  
  final Expense expense;

  @override
  Widget build(context){
    return Card(
      child:Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 18
      ),
      child: Column(children: [
        Text(expense.title,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
        const SizedBox(height: 15,),
        Row(
            children: [
              Text('Amount: ₹${expense.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12,),
              ),
              const Spacer(), // for getting the space in between the row or column
              // spacer push the text to left at the limit of screen
              const Spacer(),
              Row(children: [
                Icon(categoryicons[expense.category]),
                const SizedBox(height: 8,),
                Text(expense.formattedDate,style: const TextStyle(fontSize: 12),)
              ],)              
            ],
        )
      ],) 
      ),
    );
  }
}
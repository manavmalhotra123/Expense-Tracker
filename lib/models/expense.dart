// creating a data model for handling the expenses
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// installing the uuid package for assigning the different values to each expense
const uuid = Uuid();

// date format class of the intl package that is the third party package of dart
final formatter = DateFormat.yMd();

// Enum 
enum Category {food,travel,leisure,work}

const categoryicons = {
  Category.food: Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work
};


class Expense {
  // constructor function for storing the data regarding the expense
  Expense(this.date, this.title, this.amount,this.category) : id = uuid.v4();
    
  final String id; // expense id for each expense
  final String title;
  final double amount; // for storing the amount
  final DateTime date; // date time of the expense
  final Category category; // category of the expense (like personal,work or travel)


  String get formattedDate {
    return formatter.format(date);
  }
}


// class for maintaining the charts on the main UI...............



class ExpenseBucket {
  
  const ExpenseBucket({required this.category,required this.expenses});

  final Category category;
  final List<Expense> expenses;
  
  // other constructor for the expense bucket class
  ExpenseBucket.forcategory(
    List<Expense> allexp,
    this.category
  );

  // total expense function
  double get totalExpenses {
    double sum = 0;
    
    // getting the total of the amount spent 
    for( final expense in expenses){
      sum += expense.amount;
    }

    return sum;
  }


}
import 'package:expenses/app/widgets/chart/chart.dart';
import 'package:expenses/app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses/app/models/expense.dart';
import 'package:expenses/app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  final String title;

  const Expenses({super.key, required this.title});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpense = [
    Expense(
      title: 'Flutter Corse',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerExpense.indexOf(expense);
    setState(() {
      _registerExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Item foi deletado!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            _registerExpense.insert(expenseIndex, expense);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text(
        'Nenhum gasto encontrado! Adicione um gasto!',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    if (_registerExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registerExpense,
        onRemoveExpense: _removeExpense,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Controle de Gasto'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body:
            width < 600
                ? Column(
                  children: [
                    Chart(expenses: _registerExpense),
                    Expanded(child: mainContent),
                  ],
                )
                : Row(
                  children: [
                    Expanded(child: Chart(expenses: _registerExpense)),
                    Expanded(child: mainContent),
                  ],
                ),
      ),
    );
  }
}

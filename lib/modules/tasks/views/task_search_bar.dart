import 'package:flutter/material.dart';

class TaskSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  
  const TaskSearchBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Pesquisar tarefas...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: onSearch,
      ),
    );
  }
}
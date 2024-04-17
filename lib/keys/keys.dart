import 'package:flutter/material.dart';
import 'package:flutter_internals/keys/checkable_todo_item.dart';
// import 'package:flutter_internals/keys/todo_item.dart';

// Todo類別，包含文字和優先級兩個屬性
class Todo {
  const Todo(this.text, this.priority);

  final String text;
  final Priority priority;
}

// Keys是一個StatefulWidget，它會創建一個Keys的狀態
class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

// _KeysState是Keys的狀態，它包含了一個排序順序和一個待辦事項列表
class _KeysState extends State<Keys> {
  var _order = 'asc'; // 排序順序，預設為升序
  final _todos = [
    // 待辦事項列表
    const Todo(
      'Learn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];

  // _orderedTodos返回一個根據_order排序的待辦事項列表
  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  // _changeOrder會改變_order的值，如果_order是'asc'，則變為'desc'，反之亦然
  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  // build方法返回一個包含按鈕和待辦事項列表的Widget
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _changeOrder, // 按鈕按下時會調用_changeOrder方法
            icon: Icon(
              _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
            ),
            label: Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              for (final todo in _orderedTodos)
                CheckableTodoItem(
                  key: ValueKey(todo.text),
                  // key: ObjectKey(todo), // ValueKey較輕量，但若待辦事項的text可能重複，則應使用ObjectKey
                  todo.text,
                  todo.priority,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

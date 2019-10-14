import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_simple/app/domain/entities/todo.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_bloc.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_event.dart';
import 'package:flutter_todo_simple/app/view/bloc/todo/todo_state.dart';
import 'package:flutter_todo_simple/app/view/widget/appbar.dart';
import 'package:flutter_todo_simple/app/view/widget/sliver_delegate.dart';

import '../../domain/entities/visibility_filter.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _titleController;

  @override
  void initState() {
    _titleController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _buildNestedView(context),
          flex: 1,
        ),
        _buildBottomContent(context),
      ],
    );
  }

  Widget _buildNestedView(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: _buildHeaderSliver,
        body: _buildBodyContent(context),
      ),
    );
  }

  List<Widget> _buildHeaderSliver(
      BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      CustomAppBar(),
      SliverPersistentHeader(
        delegate: SliverAppBarDelegate(_buildTaskTypesWidget(context), height: 60),
        pinned: true,
      ),
    ];
  }

  Widget _buildTaskTypesWidget(context) {
    BorderSide borderSide = BorderSide(color: Theme.of(context).dividerColor);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            border: Border(top: borderSide, bottom: borderSide)),
        child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is Loaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildToggleButton(
                      context: context,
                      text: "All",
                      onPressed: () => BlocProvider.of<TodoBloc>(context)
                          .dispatch(GetTodoListEvent(filter: VisibilityFilter.all)),
                      focus: state.filter == VisibilityFilter.all,
                    ),
                    _buildToggleButton(
                      context: context,
                      text: "Active",
                      onPressed: () => BlocProvider.of<TodoBloc>(context)
                          .dispatch(GetTodoListEvent(filter: VisibilityFilter.active)),
                      focus: state.filter == VisibilityFilter.active,
                    ),
                    _buildToggleButton(
                      context: context,
                      text: "Completed",
                      onPressed: () => BlocProvider.of<TodoBloc>(context)
                          .dispatch(GetTodoListEvent(filter: VisibilityFilter.completed)),
                      focus: state.filter == VisibilityFilter.completed,
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }
          )
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: _buildListView(context),
    );
  }

  Widget _buildToggleButton(
      {@required BuildContext context,
        @required String text,
        @required Function() onPressed,
        bool focus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ButtonTheme(
        minWidth: 0,
        child: FlatButton(
          child: Text(text),
          onPressed: onPressed,
          color: focus ? Color(0xFFFF4954) : null,
          shape: focus
              ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
              side: BorderSide(color: Colors.grey.shade400))
              : null,
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is Loaded) {
          return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return _buildListTile(
                  context: context,
                  item: state.todos[index],
                );
              }
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildListTile({@required BuildContext context, Todo item}) {
    return InkWell(
      onTap: () {
        BlocProvider.of<TodoBloc>(context).dispatch(ToggleTodoEvent(id: item.id));
      },
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(0, 2, 0, 2),
        leading: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
          child: Opacity(
            child: Icon(
              Icons.done,
              color: Colors.green,
            ),
            opacity: item.completed ? 1 : 0,
          ),
        ),
        title: Text(
          item.text,
          style: item.completed
              ? TextStyle(
            fontSize: 22,
            color: Theme.of(context).disabledColor,
            decoration: TextDecoration.lineThrough,
          )
              : TextStyle(
            fontSize: 22,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.red,
          ),
          onPressed: () {
            BlocProvider.of<TodoBloc>(context).dispatch(DeleteTodoEvent(id: item.id));
          },
        ),
      ),
    );
  }

  Widget _buildBottomContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)]),
      child: Column(
        children: <Widget>[
          _buildListInfo(context),
          Divider(height: 1),
          _buildAddForm(context),
        ],
      ),
    );
  }

  Widget _buildListInfo(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is Loaded) {
          int activeCount = state.todos.length;
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 8, 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "$activeCount item${activeCount > 1 ? "s" : ""} left",
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.grey),
                  ),
                ),
                ButtonTheme(
                  minWidth: 0,
                  child: FlatButton(
                    child: Text(
                      "Clear completed",
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .copyWith(color: Colors.grey),
                    ),
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context).dispatch(ClearCompletedEvent());
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildAddForm(BuildContext context) {
    InputBorder border =
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            child: TextFormField(
              controller: _titleController,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  hintText: "What needs to be done?",
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  contentPadding: EdgeInsets.fromLTRB(
                      24, 4, 16, MediaQuery.of(context).padding.bottom)),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0)),
          child: MaterialButton(
            height: 75.0 + MediaQuery.of(context).padding.bottom,
            minWidth: 65.0,
            child: Icon(Icons.add, color: Colors.white),
            color: Theme.of(context).accentColor,
            onPressed: addTodo,
          ),
        ),
      ],
    );
  }

  void addTodo() {
    if (_titleController.text.isNotEmpty) {
      BlocProvider.of<TodoBloc>(context).dispatch(AddTodoEvent(text: _titleController.text));
      _titleController.clear();
    }
  }
}


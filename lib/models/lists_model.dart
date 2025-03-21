class Lists {
  final int listId;
  final String listTitle;
  final String listDesc;
  final bool listCompleted;
  final DateTime lastUpdate;

  Lists({required this.listId, required this.listTitle, required this.listDesc, required this.listCompleted, required this.lastUpdate});

  factory Lists.fromJson(Map<String, dynamic> json) {
    return Lists(
      listId: json['user_todo_list_id'],
      listTitle: json['user_todo_list_title'],
      listDesc: json['user_todo_list_desc'],
      listCompleted: json['user_todo_list_completed'] == 'true',
      lastUpdate: DateTime.parse(json['user_todo_list_last_update']),
    );
  }
}

import 'package:auth/src/features/room/logic/bloc/rooms_bloc.dart';
import 'package:auth/src/features/room/logic/models/room.dart';
import 'package:flutter/material.dart';

class UpsertRoomDialog extends StatefulWidget {
  final Room? room;
  final RoomsBloc bloc;

  UpsertRoomDialog({Key? key, this.room, required this.bloc}) : super(key: key);

  @override
  _UpsertRoomDialogState createState() =>
      _UpsertRoomDialogState(room: room, bloc: bloc);
}

class _UpsertRoomDialogState extends State<UpsertRoomDialog> {
  final Room? room;
  final RoomsBloc bloc;

  String _title = '';
  bool _isPublic = false;

  _UpsertRoomDialogState({this.room, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(room == null ? 'Create Room' : 'Update Room ${room?.title}'),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _title,
              decoration: InputDecoration(hintText: 'Title'),
              onChanged: (value) => setState(() => _title = value),
              autofocus: true,
            ),
            Row(
              children: [
                Switch(
                  value: _isPublic,
                  onChanged: (value) => setState(() => _isPublic = value),
                ),
                Text(_isPublic ? 'Public' : 'Private'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _save(context),
          child: Text('Save'),
        ),
      ],
    );
  }

  _save(BuildContext context) {
    bloc.add(RoomCreated(title: _title, isPublic: _isPublic));

    Navigator.pop(context);
  }
}

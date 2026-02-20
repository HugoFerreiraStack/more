abstract class Command {
  void execute();
  void undo();
  bool canExecute();
  bool canUndo();
}
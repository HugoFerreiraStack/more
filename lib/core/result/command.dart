// Interface base para comandos seguindo o padrão Command.

abstract class Command {
  // Executa o comando.
  void execute();

  // Desfaz o comando (se aplicável).
  void undo();

  // Verifica se o comando pode ser executado.
  bool canExecute();

  // Verifica se o comando pode ser desfeito.
  bool canUndo();
}
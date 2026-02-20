class AppSemantics {
  AppSemantics._();

  static const header = 'A Bolsa do Brasil. Cotações em tempo real.';

  static const sortGroup = 'Ordenar lista por';
  static const searchClear = 'Limpar busca';

  static const emptySearch =
      'Nenhum ativo encontrado. Tente outro termo, por exemplo PETR4 ou Vale.';
  static const retryButton = 'Tentar novamente. Recarregar cotações.';
  static const loading = 'Carregando cotações. Por favor aguarde.';

  static String stockCard(String stock, String name, String price, String change) =>
      '$stock $name. Preço $price. Variação $change. Toque para ver detalhes.';

  static String errorState(String message) => 'Erro ao carregar. $message';

  static String sortChip(String label, [String? direction]) {
    if (direction != null) {
      return 'Ordenar por $label, $direction. Toque para inverter ou remover ordenação.';
    }
    return 'Ordenar por $label';
  }

  static String sortDirectionName(bool descending) =>
      descending ? 'maior primeiro' : 'menor primeiro';
  static String sortDirectionAlphabetical(bool descending) =>
      descending ? 'Z a A' : 'A a Z';
}

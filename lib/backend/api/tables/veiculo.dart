import '../database.dart';

class VeiculoTable extends ApiTable<VeiculoRow> {
  @override
  String get tableName => 'veiculo';

  @override
  VeiculoRow createRow(Map<String, dynamic> data) => VeiculoRow(data);
}

class VeiculoRow extends ApiDataRow {
  VeiculoRow(Map<String, dynamic> data) : super(data);

  @override
  ApiTable get table => VeiculoTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get placa => getField<String>('placa')!;
  set placa(String value) => setField<String>('placa', value);

  String get marca => getField<String>('marca')!;
  set marca(String value) => setField<String>('marca', value);

  String get modelo => getField<String>('modelo')!;
  set modelo(String value) => setField<String>('modelo', value);

  int? get ano => getField<int>('ano');
  set ano(int? value) => setField<int>('ano', value);

  String? get cor => getField<String>('cor');
  set cor(String? value) => setField<String>('cor', value);

  String? get chassi => getField<String>('chassi');
  set chassi(String? value) => setField<String>('chassi', value);

  int? get kmAtual => getField<int>('km_atual');
  set kmAtual(int? value) => setField<int>('km_atual', value);

  String? get combustivel => getField<String>('combustivel');
  set combustivel(String? value) => setField<String>('combustivel', value);

  String? get contato => getField<String>('contato');
  set contato(String? value) => setField<String>('contato', value);

  String? get observacao => getField<String>('observacao');
  set observacao(String? value) => setField<String>('observacao', value);

  DateTime get criadoEm => getField<DateTime>('criado_em')!;
  set criadoEm(DateTime value) => setField<DateTime>('criado_em', value);

  DateTime get atualizadoEm => getField<DateTime>('atualizado_em')!;
  set atualizadoEm(DateTime value) =>
      setField<DateTime>('atualizado_em', value);

  bool get isExcluido => getField<bool>('is_excluido') ?? false;
  set isExcluido(bool value) => setField<bool>('is_excluido', value);
}

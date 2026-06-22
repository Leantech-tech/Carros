import '../database.dart';

class OsTable extends ApiTable<OsRow> {
  @override
  String get tableName => 'os';

  @override
  OsRow createRow(Map<String, dynamic> data) => OsRow(data);
}

class OsRow extends ApiDataRow {
  OsRow(Map<String, dynamic> data) : super(data);

  @override
  ApiTable get table => OsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get numero => getField<String>('numero')!;
  set numero(String value) => setField<String>('numero', value);

  int? get kmVeiculo => getField<int>('km_veiculo');
  set kmVeiculo(int? value) => setField<int>('km_veiculo', value);

  DateTime? get dataEntrada => getField<DateTime>('data_entrada');
  set dataEntrada(DateTime? value) => setField<DateTime>('data_entrada', value);

  DateTime? get dataPrevisao => getField<DateTime>('data_previsao');
  set dataPrevisao(DateTime? value) => setField<DateTime>('data_previsao', value);

  DateTime? get dataConclusao => getField<DateTime>('data_conclusao');
  set dataConclusao(DateTime? value) => setField<DateTime>('data_conclusao', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  String? get descricao => getField<String>('descricao');
  set descricao(String? value) => setField<String>('descricao', value);

  double? get valorMaoObra => getField<double>('valor_mao_obra');
  set valorMaoObra(double? value) => setField<double>('valor_mao_obra', value);

  double? get valorPeca => getField<double>('valor_peca');
  set valorPeca(double? value) => setField<double>('valor_peca', value);

  double? get valorTotal => getField<double>('valor_total');
  set valorTotal(double? value) => setField<double>('valor_total', value);

  String? get observacao => getField<String>('observacao');
  set observacao(String? value) => setField<String>('observacao', value);

  String? get mecanicoResponsavel => getField<String>('mecanico_responsavel');
  set mecanicoResponsavel(String? value) =>
      setField<String>('mecanico_responsavel', value);

  String? get veiculoId => getField<String>('veiculo_id');
  set veiculoId(String? value) => setField<String>('veiculo_id', value);

  DateTime? get criadoEm => getField<DateTime>('criado_em');
  set criadoEm(DateTime? value) => setField<DateTime>('criado_em', value);

  DateTime? get atualizadoEm => getField<DateTime>('atualizado_em');
  set atualizadoEm(DateTime? value) =>
      setField<DateTime>('atualizado_em', value);
}

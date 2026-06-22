import '../database.dart';

class CarroTable extends ApiTable<CarroRow> {
  @override
  String get tableName => 'carros';

  @override
  CarroRow createRow(Map<String, dynamic> data) => CarroRow(data);
}

class CarroRow extends ApiDataRow {
  CarroRow(Map<String, dynamic> data) : super(data);

  @override
  ApiTable get table => CarroTable();

  String get id => getField<String>('id') ?? '';
  set id(String value) => setField<String>('id', value);

  String get nomeVeiculo => getField<String>('nome') ?? getField<String>('nome_veiculo') ?? '';
  set nomeVeiculo(String value) => setField<String>('nome', value);

  String get placa => getField<String>('placa') ?? '';
  set placa(String value) => setField<String>('placa', value);

  DateTime get dataServico => getField<DateTime>('data') ?? DateTime.now();
  set dataServico(DateTime value) => setField<DateTime>('data', value);

  String? get descricao => getField<String>('historico') ?? getField<String>('descricao') ?? getField<String>('observacao') ?? getField<String>('servico');
  set descricao(String? value) => setField<String>('historico', value);

  String? get contato => getField<String>('contato');
  set contato(String? value) => setField<String>('contato', value);
}

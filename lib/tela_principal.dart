import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  List<Map<String, String>> tarefas = [];

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final preferencias = await SharedPreferences.getInstance();
    final dadosJson = preferencias.getString('tarefas');
    if (dadosJson != null) {
      setState(() {
        tarefas = List<Map<String, String>>.from(jsonDecode(dadosJson));
      });
    }
  }

  Future<void> salvarTarefasLocalmente() async {
    final preferencias = await SharedPreferences.getInstance();
    final dadosJson = jsonEncode(tarefas);
    await preferencias.setString('tarefas', dadosJson);
  }

  void adicionarTarefa(String titulo, String descricao) {
    setState(() {
      tarefas.add({'titulo': titulo, 'descricao': descricao});
    });
    salvarTarefasLocalmente();
  }

  void editarTarefa(int index, String novoTitulo, String novaDescricao) {
    setState(() {
      tarefas[index] = {'titulo': novoTitulo, 'descricao': novaDescricao};
    });
    salvarTarefasLocalmente();
  }

  void excluirTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
    salvarTarefasLocalmente();
  }

  void exibirDialogoAdicionar() {
    final controladorTitulo = TextEditingController();
    final controladorDescricao = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Adicionar Tarefa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controladorTitulo,
              decoration: InputDecoration(hintText: 'Digite o título da tarefa'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: controladorDescricao,
              decoration:
                  InputDecoration(hintText: 'Digite a descrição da tarefa'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (controladorTitulo.text.isNotEmpty &&
                  controladorDescricao.text.isNotEmpty) {
                adicionarTarefa(
                    controladorTitulo.text, controladorDescricao.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void exibirDialogoEditar(int index) {
    final controladorTitulo =
        TextEditingController(text: tarefas[index]['titulo']);
    final controladorDescricao =
        TextEditingController(text: tarefas[index]['descricao']);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Editar Tarefa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controladorTitulo,
              decoration: InputDecoration(hintText: 'Digite o novo título'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: controladorDescricao,
              decoration:
                  InputDecoration(hintText: 'Digite a nova descrição'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (controladorTitulo.text.isNotEmpty &&
                  controladorDescricao.text.isNotEmpty) {
                editarTarefa(
                    index, controladorTitulo.text, controladorDescricao.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Tarefa Pad'),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.yellow[700]!, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.yellow[700],
                child: Text(
                  'Tarefas Atuais',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              tarefa['titulo']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(tarefa['descricao']!),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => exibirDialogoEditar(index),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => excluirTarefa(index),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        onPressed: exibirDialogoAdicionar,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

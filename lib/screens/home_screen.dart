import 'package:flutter/material.dart';
import '../widgets/contact_list.dart';
import '../widgets/chat_area.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int contatoAtual = 0;
  bool mostrandoChat = false;

  final List<Map<String, dynamic>> contatos = [
    {"id": "Maria", "nome": "Maria Silva", "online": true, "av": "MS"},
    {"id": "Joao", "nome": "João Pedro", "online": false, "av": "JP"},
    {"id": "Ana", "nome": "Ana Carla", "online": true, "av": "AC"},
    {"id": "Lucas", "nome": "Lucas Mendes", "online": false, "av": "LM"},
    {"id": "Bia", "nome": "Beatriz Lima", "online": true, "av": "BL"},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Scaffold(
        body: mostrandoChat
            ? Stack(
                children: [
                  ChatArea(contato: contatos[contatoAtual]),
                  Positioned(
                    top: 10,
                    left: 8,
                    child: SafeArea(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          setState(() => mostrandoChat = false);
                        },
                      ),
                    ),
                  ),
                ],
              )
            : ContactList(
                contatos: contatos,
                contatoAtual: contatoAtual,
                onContatoSelecionado: (index) {
                  setState(() {
                    contatoAtual = index;
                    mostrandoChat = true;
                  });
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Map<String, dynamic>> contatos;
  final int contatoAtual;
  final Function(int) onContatoSelecionado;

  const ContactList({
    super.key,
    required this.contatos,
    required this.contatoAtual,
    required this.onContatoSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: const Color(0xFF0F0F0F),
      child: Column(
        children: [
          // Header TalksApp
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF0F0F0F),
            child: const Row(
              children: [
                Text(
                  "TALKSAPP",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC8960C),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          // Campo de busca
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar contato...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1A1A1A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // Lista de contatos
          Expanded(
            child: ListView.builder(
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                final contato = contatos[index];
                final bool selecionado = index == contatoAtual;

                return ListTile(
                  leading: _buildAvatar(contato),
                  title: Text(
                    contato['nome'],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    contato['online'] ? "● Online" : "● Offline",
                    style: TextStyle(
                      color: contato['online'] ? Colors.green : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  selected: selecionado,
                  selectedTileColor: const Color(0xFF1F1500),
                  onTap: () => onContatoSelecionado(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(Map<String, dynamic> contato) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFFC8960C),
          child: Text(
            contato['av'],
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: CircleAvatar(
            radius: 6,
            backgroundColor: contato['online'] ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }
}
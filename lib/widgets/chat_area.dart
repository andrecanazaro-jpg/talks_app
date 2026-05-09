import 'package:flutter/material.dart';

class ChatArea extends StatefulWidget {
  final Map<String, dynamic> contato;

  const ChatArea({super.key, required this.contato});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final List<Map<String, dynamic>> mensagens = [];
  final TextEditingController _controller = TextEditingController();

  void _enviarMensagem() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      mensagens.add({
        "texto": _controller.text.trim(),
        "hora": TimeOfDay.now().format(context),
        "enviada": true,
      });
    });

    _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          mensagens.add({
            "texto": "Entendi! 👍",
            "hora": TimeOfDay.now().format(context),
            "enviada": false,
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: const Color(0xFF141414),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFC8960C),
                child: Text(
                  widget.contato['av'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.contato['nome'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.contato['online'] ? "● Online" : "● Offline",
                    style: TextStyle(
                      fontSize: 12,
                      color: widget.contato['online'] ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Área das mensagens
        Expanded(
          child: Container(
            color: const Color(0xFF111111),
            padding: const EdgeInsets.all(12),
            child: mensagens.isEmpty
                ? const Center(
                    child: Text(
                      "Envie a primeira mensagem...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    itemCount: mensagens.length,
                    itemBuilder: (context, index) {
                      final msg = mensagens[mensagens.length - 1 - index];
                      final bool enviada = msg['enviada'];

                      return Align(
                        alignment: enviada
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.72,
                          ),
                          decoration: BoxDecoration(
                            color: enviada
                                ? const Color(0xFF2B2000)
                                : const Color(0xFF1C1C1C),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                msg['texto'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                msg['hora'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),

        // Barra de mensagem
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            color: const Color(0xFF1A1A1A),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined,
                      color: Colors.amber, size: 26),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _enviarMensagem(),
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: "Digite sua mensagem...",
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF252525),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Color(0xFFC8960C), size: 26),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _enviarMensagem,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
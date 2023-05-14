import 'package:share_app/src/shared/model/message_model.dart';

class MessageController {
  // static MessageModel message = MessageModel.empty;
  static List<MessageModel> list = [];

  MessageModel msg1 = MessageModel(
    body: "Olá! Só queria dizer que você é incrível. Tenha um dia maravilhoso!",
    title: 'Aventureiro21',
  );

  MessageModel msg2 = MessageModel(
    body:
        "Lembre-se de cuidar de si mesmo(a) hoje. Você merece um momento de descanso e autocuidado. Cuide-se!",
    title: 'SorrisoRadiante',
  );

  MessageModel msg3 = MessageModel(
    body:
        "Parabéns pelo seu novo emprego! Tenho certeza de que você vai arrasar. Estou torcendo por você!",
    title: 'SonhadorInspirado',
  );

  List<MessageModel> getList() {
    list.add(msg1);
    list.add(msg2);
    list.add(msg3);

    return list;
  }

  void addMessage(MessageModel message) {
    list.add(message);
  }

  static void dispose() {
    list = [];
  }
}

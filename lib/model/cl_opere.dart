//creazione della classe Opere
/**
 * Tipo : Crud
 * Link: molti a uno con tabella Autori-- molti a uno con tabella Musei
 * Metodi:
 */

class Opere {
  int uid;
  String museo_fk;
  int codice_fk;
  String titolo;
  String descrizione;
  String anno;
  String img_link;
  String video_link;

  Opere(
      {required this.uid,
      required this.codice_fk,
      required this.museo_fk,
      required this.titolo,
      required this.descrizione,
      required this.anno,
      required this.img_link,
      required this.video_link});

  factory Opere.fromJson(Map<String, dynamic> json) => Opere(
        //se il valore recuperato e ugale a nullo scrivi 0 , altrimenti prendi quel valore
        uid: json == null ? 0 : json["uid"],
        codice_fk: json == null ? 'vuoto' : json["codice_fk"],
        museo_fk: json == null ? 0 : json["museo_fk"],
        titolo: json == null ? 0 : json["titolo"],
        descrizione: json == null ? 0 : json["descrizione"],
        anno: json == null ? 0 : json["anno"],
        img_link: json == null ? 0 : json["img_link"],
        video_link: json == null ? 0 : json["video_link"],
      );
}

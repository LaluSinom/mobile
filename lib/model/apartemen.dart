// ignore_for_file: public_member_api_docs, sort_constructors_first
class Apartemen {
  int id;
  String nama_apartemen;
  String alamat;
  String gambar;
  Apartemen(
    this.id,
    this.nama_apartemen,
    this.alamat,
    this.gambar,
  );

  factory Apartemen.fromJson(Map<String, dynamic> json) => Apartemen(
        int.parse(json['id']),
        json['nama_apartemen'],
        json['alamat'],
        json['gambar'],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id.toString(),
        'nama_apartemen': this.nama_apartemen,
        'alamat': this.alamat,
        'gambar': this.gambar,
      };
}

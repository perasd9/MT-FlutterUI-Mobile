class Member {
  int clanId;
  String? ime;
  String? prezime;
  String email;
  String lozinka;

  Member({required this.clanId, this.ime, this.prezime, required this.email, required this.lozinka });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      clanId: json['ClanId'] ?? 0,
      ime: json['ClanId'] != 0 ? json['Ime'] : "",
      prezime: json['Prezime'],
      email: json['Email'],
      lozinka: json['Lozinka'],
    );
  }

  @override
  String toString() {
    return ime.toString();
  }
}
class AddressSearchModel {
  int totalCount = 0;
  String errorCode;
  List<AddressModel> addresses = [];
  AddressSearchModel({
    required this.totalCount,
    required this.errorCode,
    required this.addresses,
  });

  factory AddressSearchModel.fromJson(Map<String, dynamic> json) {
    return AddressSearchModel(
      totalCount: int.tryParse(json['results']['common']['totalCount']) ?? 0,
      errorCode: json['results']['common']['errorCode'],
      addresses:
          ((json['results']['juso'] ?? []) as List).map((e) => AddressModel.fromMap(e)).toList(),
    );
  }
}

class AddressModel {
  String zipNo;
  String emdNm;
  String rn;
  String jibunAddr;
  String siNm;
  String sggNm;
  String admCd;
  String udrtYn;
  String lnbrMnnm;
  String roadAddr;
  String korAddr;
  String lnbrSlno;
  String buldMnnm;
  String bdKdcd;
  String rnMgtSn;
  String liNm;
  String mtYn;
  String buldSlno;
  AddressModel({
    required this.zipNo,
    required this.emdNm,
    required this.rn,
    required this.jibunAddr,
    required this.siNm,
    required this.sggNm,
    required this.admCd,
    required this.udrtYn,
    required this.lnbrMnnm,
    required this.roadAddr,
    required this.korAddr,
    required this.lnbrSlno,
    required this.buldMnnm,
    required this.bdKdcd,
    required this.rnMgtSn,
    required this.liNm,
    required this.mtYn,
    required this.buldSlno,
  });

  factory AddressModel.fromMap(Map<String, dynamic> json) {
    return AddressModel(
      zipNo: json['zipNo'],
      emdNm: json['emdNm'],
      rn: json['rn'],
      jibunAddr: json['jibunAddr'],
      siNm: json['siNm'],
      sggNm: json['sggNm'],
      admCd: json['admCd'],
      udrtYn: json['udrtYn'],
      lnbrMnnm: json['lnbrMnnm'],
      roadAddr: json['roadAddr'],
      korAddr: json['korAddr'],
      lnbrSlno: json['lnbrSlno'],
      buldMnnm: json['buldMnnm'],
      bdKdcd: json['bdKdcd'],
      rnMgtSn: json['rnMgtSn'],
      liNm: json['liNm'],
      mtYn: json['mtYn'],
      buldSlno: json['buldSlno'],
    );
  }
}

enum BoardType {
  notice('notice', '공지사항'),
  free('free', '자유게시판'),
  undefined('undefined', '');

  const BoardType(this.code, this.displayName);
  final String code;
  final String displayName;

  factory BoardType.getByCode(String code){
    return BoardType.values.firstWhere((value) => value.code == code,
        orElse: () => BoardType.undefined);
  }
}
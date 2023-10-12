class AdminVoteAddModel {
  String? voteName;
  DateTime? votingDate;
  int? totalVote;
  String? voteId;
  AdminVoteAddModel({
    required this.voteName,
    required this.votingDate,
    required this.totalVote,
    required this.voteId,
  });

  factory AdminVoteAddModel.fromJSON(Map<String, dynamic> map) {
    return AdminVoteAddModel(
      voteName: map['voteName'] ?? '',
      votingDate:
          map['votingDate'] == null ? null : DateTime.parse(map['votingDate']),
      totalVote: map['totalVote'] ?? 0,
      voteId: map['voteId'] ?? '',
    );
  }
}

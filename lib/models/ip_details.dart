class IPDetails {
  late final String country;
  late final String regionName;
  late final String city;
  late final String zip;
  late final String timezone;
  late final String isp;
  late final String query;
  IPDetails({
    required this.country,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.timezone,
    required this.isp,
    required this.query,
  });

  IPDetails.fromJson(Map<String, dynamic> json) {
    country = json['country'] ?? 'Fetching';
    regionName = json['regionName'] ?? 'Fetching';
    city = json['city'] ?? 'Fetching';
    zip = json['zip'] ?? 'Fetching';
    timezone = json['timezone'] ?? 'Fetching';
    isp = json['isp'] ?? 'Fetching';
    query = json['query'] ?? 'Fetching';
  }
}

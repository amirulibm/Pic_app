class Shift {
  final int attendance_syifs_id;
  final String attendance_syifs_code;
  final String attendance_syifs_job_code;
  final String attendance_syif_date;
  final String attendance_syifs;
  /* final String pic_name;
  final String start_time;
  final String end_time;
  final String created_at;
  final String updated_at;
  final String deleted_at;*/

  const Shift({
    required this.attendance_syifs_id,
    required this.attendance_syifs_code,
    required this.attendance_syifs_job_code,
    required this.attendance_syif_date,
    required this.attendance_syifs,
    /*   required this.pic_name,
    required this.start_time,
    required this.end_time,
    required this.created_at,
    required this.updated_at,
    required this.deleted_at, */
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        attendance_syifs_id: json['attendance_syifs_id'],
        attendance_syifs_code: json['attendance_syifs_code'],
        attendance_syifs_job_code: json['attendance_syifs_job_code'],
        attendance_syif_date: json['attendance_syif_date'],
        attendance_syifs: json['attendance_syifs'],
        /*   pic_name: json['pic_name'],
        start_time: json['start_time'],
        end_time: json['end_time'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        deleted_at: json['deleted_at'],*/
      );

  Map<String, dynamic> toJson() => {
        'attendance_syifs_id': attendance_syifs_id,
        'attendance_syifs_code': attendance_syifs_code,
        'attendance_syifs_job_code': attendance_syifs_job_code,
        'attendance_syif_date': attendance_syif_date,
        'attendance_syifs': attendance_syifs,
        /*  'pic_name': pic_name,
        'start_time': start_time,
        'end_time': end_time,
        'created_at': created_at,
        'updated_at': updated_at,
        'deleted_at': deleted_at,*/
      };
}

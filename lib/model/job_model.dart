class Job {
  final int job_id;
  final String job_events_name;
  final String job_position;
  final String company_name;
  final String job_code;
  /* final String job_code;
  final String job_company_id;
  final String job_events_name;
  final String job_position;
  final String job_salary;
  final String job_start_date;
  final String job_end_date;
  final String job_address;
  final String job_postcode;
  final String job_state_id;
  final String job_description;
  final String company_name;
  final String ssm_no;
  final String pic_name;
  final String pic_phone_no;
  final String pic_email;
  final String state_id;
  final String state_name; */

  const Job({
    required this.job_id,
    required this.job_events_name,
    required this.job_position,
    required this.company_name,
    required this.job_code,
    /*  required this.job_code,
    required this.job_company_id,
    required this.job_events_name,
    required this.job_position,
    required this.job_salary,
    required this.job_start_date,
    required this.job_end_date,
    required this.job_address,
    required this.job_postcode,
    required this.job_state_id,
    required this.job_description,
    required this.company_name,
    required this.ssm_no,
    required this.pic_name,
    required this.pic_phone_no,
    required this.pic_email,
    required this.state_id,
    required this.state_name,*/
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        job_id: json['job_id'],
        job_events_name: json['job_events_name'],
        job_position: json['job_position'],
        company_name: json['company_name'],
        job_code: json['job_code'],
        /*   job_code: json['job_code'],
        job_company_id: json['job_company_id'],
        job_events_name: json['job_events_name'],
        job_position: json['job_position'],
        job_salary: json['job_salary'],
        job_start_date: json['job_start_date'],
        job_end_date: json['job_end_date'],
        job_address: json['job_address'],
        job_postcode: json['job_postcode'],
        job_state_id: json['job_state_id'],
        job_description: json['job_description'],
        company_name: json['company_name'],
        ssm_no: json['ssm_no'],
        pic_name: json['pic_name'],
        pic_phone_no: json['pic_phone_no'],
        pic_email: json['pic_email'],
        state_id: json['state_id'],
        state_name: json['state_name'],*/
      );

  Map<String, dynamic> toJson() => {
        'job_id': job_id,
        'job_events_name': job_events_name,
        'job_position': job_position,
        'company_name': company_name,
        'job_code': job_code,
        /* 'job_code': job_code,
        'job_company_id': job_company_id,
        'job_events_name': job_events_name,
        'job_position': job_position,
        'job_salary': job_salary,
        'job_start_date': job_start_date,
        'job_end_date': job_end_date,
        'job_address': job_address,
        'job_postcode': job_postcode,
        'job_state_id': job_state_id,
        'job_description': job_description,
        'company_name': company_name,
        'ssm_no': ssm_no,
        'pic_name': pic_name,
        'pic_phone_no': pic_phone_no,
        'pic_email': pic_email,
        'state_id': state_id,
        'state_name': state_name,*/
      };
}

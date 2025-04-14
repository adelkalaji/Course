class StudentCourseRel {
  int? scId;
  int? studentId;
  int? courseId;
  String? studentCourseJoin;
  int? studentCourseEvaluation;
  int? studentCourseType;

  StudentCourseRel({
    this.scId,
    this.studentId,
    this.courseId,
    this.studentCourseJoin,
    this.studentCourseEvaluation,
    this.studentCourseType,
  });

  factory StudentCourseRel.fromJson(Map<String, dynamic> json) {
    return StudentCourseRel(
      scId: json['sc_id'],
      studentId: json['student_id'],
      courseId: json['course_id'],
      studentCourseJoin: json['student_course_join'],
      studentCourseEvaluation: json['student_course_evaluation'],
      studentCourseType: json['student_course_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sc_id': scId,
        'student_id': studentId,
        'course_id': courseId,
        'student_course_join': studentCourseJoin,
        'student_course_evaluation': studentCourseEvaluation,
        'student_course_type': studentCourseType,
      };
}

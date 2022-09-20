CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;
CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);
CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);
/*Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.*/
select subid"mã môn học", subname"Tên môn học", max(credit)"Credit lớn nhất"
from subject;
/*Hiển thị các thông tin môn học có điểm thi lớn nhất.*/
select sub.subid"Mã môn học", sub.subname"Tên môn học", max(m.mark) "Điểm tối đa"
from subject sub join mark m on sub.subid = m.subid
group by sub.subid
order by max(m.mark);
/*Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần*/
select s.studentid"Mã sinh viên", s.studentname"Tên sinh viên", avg(m.mark)"Điểm Trung Bình"
from student s join mark m on s.studentid = m.studentid
group by s.studentid
order by avg(m.mark);
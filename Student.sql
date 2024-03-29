-- 自动删除已存在表的plsql代码
declare
  v_count number;
begin
  -- 表名大写
  select count(1) into v_count from user_tables t 
    where t.TABLE_NAME='GRADE';
    if v_count>0 then
      execute immediate 'drop table GRADE';
    end if;
end;


-------- 建表
-- 学生表
create table Student(
  StudentNo number(4) not null,
  StudentName nvarchar2(50) not null,
  Sex char(4) not null,
  GradeId number(4) not null,
  Phone number(11),
  Address nvarchar2(255),
  BornDate date not null,
  Email nvarchar2(50),
  IdentityCard char(18) not null
);

-- 年级表
create table Grade(
  GradeId number(4) not null,
  GradeName nvarchar2(50) not null
);

-- 课程表
create table Subject(
  SubjectNo number(4) not null,
  SubjectName nvarchar2(50) not null,
  ClassHour number(4) not null,
  GradeId number(4) not null  -- 年级编号
);

-- 成绩表
create table Result(
  StudentNo number(4) not null,
  SubjectNo number(4) not null,
  StudentResult number(4) not null,
  ExamDate date not null
);

drop table subject;



-------- 添加约束
alter table Grade add constraint pk_grade_GradeId primary key(GradeId);

alter table Student add constraint pk_student_StuNo primary key(StudentNo);
alter table Student add constraint ck_student_Sex check(Sex='男' or Sex='女');
alter table Student add constraint uq_student_StuId unique(IdentityCard);
alter table Student modify address default('地址不详'); -- 默认约束

alter table Subject add constraint pk_subject_SubjectNo primary key(SubjectNo);
alter table Subject add constraint ck_subject_ClassHour check(ClassHour>=0);

alter table Result add constraint pk_result primary key(StudentNo, SubjectNo, ExamDate);
alter table Result add constraint ck_Student_Result check(StudentResult between 0 and 100);
-- 添加外键
alter table Result add constraint fk_StudentNo foreign key(StudentNo) references Student(StudentNo);
alter table Result add constraint fk_Subject_SubjectNo foreign key(SubjectNo) references Subject(SubjectNo);

alter table Student add constraint fk_Grade_GradeId foreign key(GradeId) references Grade(GradeId);

alter table Subject add constraint fk_Subject_GradeId foreign key(GradeId) references Grade(GradeId);

/*
alter table grade drop constraint pk_grade_gradeid;
alter table student drop constraint uq_student_StuId;
alter table result drop constraint ck_Student_Result;
alter table subject drop constraint ck_subject_ClassHour;
*/


-------- 插入数据
-- Grade
insert into grade(gradeid, Gradename) values(1, '一年级');
insert into grade values(2, '二年级');
insert into grade values(3, '三年级');
commit;
select * from grade;

-- Subject
insert into subject values(1, '计算机基础', 20, 1);
insert into subject values(2, 'Java程序设计基础', 16, 1);
insert into subject values(3, '数据库设计基础', 18, 1);
insert into subject values(4, 'HTML', 32, 1);
insert into subject values(5, 'javascript', 38, 1);
insert into subject values(6, 'css', 36, 1);
insert into subject values(7, 'Java面向对象程序设计', 24, 2);
insert into subject values(8, 'MySql从入门到删库跑路', 28, 2);
insert into subject values(9, '数据结构与算法设计', 12, 2);
insert into subject values(10, '设计模式之美', 26, 2);
insert into subject values(11, '深入理解Spring框架', 42, 3);
insert into subject values(12, 'MyBatis从入门到放弃', 38, 3);
insert into subject values(13, 'SpringBoot实战', 12, 3);
commit;
select * from subject;

-- Student
insert into student values(1000, '郭靖', '男', 1, 02088762106, '天津市河西区', 
  to_date('1987-09-08 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'GuoJing@sohu.com', 111111111111111111);
insert into student values(1001, '杨过', '男', 1, 01062768866, '地址不详', 
  to_date('1993-09-08 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'YangGuo@sohu.com', 111111111111111112);
insert into student values(1002, '李斯文', '男', 1, 01927294729, '河南洛阳', 
  to_date('1992-08-08 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'LiSiwen@sohu.com', 111111111111111113);
insert into student values(1011, '武松', '男', 1, 46287639926, '地址不详', 
  to_date('1984-10-08 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'WuSong@sohu.com', 111111111111111114); 
insert into student values(1012, '王宝钏', '女', 1, 46729863082, '地址不详', 
  to_date('1998-08-08 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'WangBaochuan@sohu.com', 111111111111111115); 
insert into student values(2011, '张三', '男', 1, 36482683036, '北京市海淀区', 
  to_date('1994-01-01 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'ZhangSan@sohu.com', 111111111111111116); 
insert into student values(2012, '张秋丽', '女', 2, 46582793645, '北京市东城区', 
  to_date('1996-06-08 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'ZhangQiuli@sohu.com', 111111111111111117); 
insert into student values(2015, '肖梅', '女', 2, 47395629023, '河北省石家庄市', 
  to_date('1996-10-01 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'XiaoMei@sohu.com', 111111111111111118); 
insert into student values(3021, '欧阳俊', '男', 2, 01928172628, '上海市卢湾区', 
  to_date('1995-08-08 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'OuYangJu@sohu.com', 111111111111111119); 
insert into student values(3023, '梅超风', '男', 2, 29371028364, '广州市天河区', 
  to_date('1997-08-30 00:00:00','yyyy-MM-dd HH24:mi:ss'), 'MeiChaofeng@sohu.com', 111111111111111110); 
  
commit;
select * from student;
delete from student where studentno = 1000;

-- Result
INSERT INTO Result VALUES(1001,2,70,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(1000,2,60,to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(1001,2,46,to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(1002,2,83,to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(1011,2,71,to_date('2020-02-16 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(1011,2,95,to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(1012,2,76,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(2011,2,60,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(2012,2,91,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(2012,7,61,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(2015,2,60,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(2015,7,65,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(3021,2,23,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(3021,8,74,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(3023,2,23,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO Result VALUES(3023,9,39,to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
commit;

update result set studentresult=39 where studentno=3023 and subjectno=9 
and examdate=to_date('2020/2/15','yyyy-MM-dd')
commit;
select * from result;


-------------------------------
-- 1. 查询年龄比“杨过”大的学生，显示这些学生的信息
select * from student where borndate<(select borndate from student where studentname='杨过');

-- 2.查询“Java程序设计基础”课程至少一次考试刚好等于60分的多个学生信息
select * from student 
  where studentno in(select studentno from result 
    where subjectno=(select subjectno from subject 
      where subjectname='Java程序设计基础') and studentresult=60
);

-- 3.查询参加最近一次“Java面向对象程序设计”考试成绩最高分和最低分
select max(studentresult) as 最高分, min(studentresult) as 最低分 from result
  where subjectno=(select subjectno from subject where subjectname='Java面向对象程序设计') and 
        examdate=(select max(examdate) from result group by subjectno 
                  having subjectno=(select subjectno from subject where subjectname='Java面向对象程序设计')) ;

-- 4.查询获得所有参加2020年2月15日“Java程序设计基础”课程考试的所有学生的考试成绩，要求输出学生姓名、课程名称和考试成绩。
select stu.studentname, stu1.subjectname, stu1.studentresult from student stu
right join (
  select r.studentno,r.studentresult,sub1.subjectname from subject sub1
  right join result r
  on sub1.subjectno=r.subjectno 
  where r.subjectno=(select sub2.subjectno from subject sub2 where sub2.subjectname='Java程序设计基础')
    and r.examdate=to_date('2020/2/15','yyyy-MM-dd')
) stu1
on stu.studentno=stu1.studentno;

-- 5.查询参加“Java程序设计基础”课程最近一次考试的学生名单
select studentname from student where studentno in (
  select studentno from result 
    where subjectno=(select subjectno from subject 
      where subjectname='Java程序设计基础') 
    and examdate=(select max(examdate) from result 
      where subjectno=(select subjectno from subject 
        where subjectname='Java程序设计基础'))
);

-- 6.查询“Java程序设计基础”课程最近一次考试成绩为60分的学生信息
select * from student where studentno in (
  select studentno from result 
    where subjectno=(select subjectno from subject 
      where subjectname='Java程序设计基础') 
    and examdate=(select max(examdate) from result 
      where subjectno=(select subjectno from subject 
        where subjectname='Java程序设计基础'))
    and studentresult=60
);

-- 7.查询一年级开设的课程信息， （查询所有年级开设的课程信息）
select * from subject where gradeid=(
  select gradeid from grade where gradename='一年级'
);

select * from subject where gradeid=(
  select gradeid from grade where gradename='二年级'
);

select * from subject where gradeid=(
  select gradeid from grade where gradename='三年级'
);

-- 8.查询未参加“Java程序设计基础”课程最近一次考试的学生名单
select stu.studentname from student stu
left join (
  select r.studentno,r.studentresult from subject sub1
  left join result r
  on sub1.subjectno=r.subjectno 
  where r.subjectno=(select sub2.subjectno from subject sub2 where sub2.subjectname='Java程序设计基础')
    and r.examdate=(select max(examdate) from result where subjectno=(
                    select subjectno from subject where subjectname='Java程序设计基础'))
) stu1
on stu.studentno=stu1.studentno
where studentresult is null;

-- 9.查询同年级未参加“Java程序设计基础”课程最近一次考试的学生名单
select stu.studentname from student stu
left join (
  select r.studentno,r.studentresult from subject sub1
  left join result r
  on sub1.subjectno=r.subjectno 
  where r.subjectno=(select sub2.subjectno from subject sub2 where sub2.subjectname='Java程序设计基础')
    and r.examdate=(select max(examdate) from result where subjectno=(
                    select subjectno from subject where subjectname='Java程序设计基础'))
) stu1
on stu.studentno=stu1.studentno
where studentresult is null
and gradeid=1;

-- 10.查询第5-10名学生的信息。
select * from (
  select rownum rn, stu.* from student stu
  where rownum<=10
)
where rn>=5;

-- 11.制作学生在校期间所有课程的成绩单。
select table1.studentno, table1.studentname, table1.subjectname, nvl(to_char(re1.studentresult),'缺考') 考试成绩
from (select stu1.studentno, stu1.studentname, sub1.subjectname, sub1.subjectno from student stu1, subject sub1) table1
left join result re1
on table1.studentno=re1.studentno and table1.subjectno=re1.subjectno
order by table1.subjectno;

-- 12.查询每门课程最近一次考试成绩在90分以上的学生名单（相关子查询)
select D.subjectname, C.studentname, A.EXAMDATE, B.Studentresult
from (select max(examdate) examdate, subjectno from result group by subjectno) A, result B, student C, subject D
where C.studentno = B.studentno
  and D.subjectno = B.Subjectno
  and A.EXAMDATE = B.EXAMDATE
  and A.SUBJECTNO = B.subjectno
  and B.Studentresult >= 90
order by B.subjectno, B.studentno;


-- 13.统计男女生的人数，显示结果如下：
select sex 性别, count(1) 人数 from student group by sex;

-- 14.汇总统计每个学生的课程编号分别为2/7/8/9的成绩，显示结果如下
select  studentno, 
  (select sum(studentresult) from result where subjectno=2 and studentno=re1.studentno ) 编号为2的课程,
  (select sum(studentresult) from result where subjectno=7 and studentno=re1.studentno ) 编号为7的课程,
  (select sum(studentresult) from result where subjectno=8 and studentno=re1.studentno ) 编号为8的课程, 
  (select sum(studentresult) from result where subjectno=9 and studentno=re1.studentno ) 编号为9的课程 
from result re1 group by studentno;

-- 第二种写法
select studentno, 
       sum(
          case subjectno
            when 2 then studentresult
          end
       ) as 课程编号为2号总成绩,
       sum(
          case subjectno
            when 7 then studentresult
          end
       ) as 课程编号为7号总成绩,
       sum(
          case subjectno
            when 8 then studentresult
          end
       ) as 课程编号为8号总成绩,
       sum(
          case subjectno
            when 9 then studentresult
          end
       ) as 课程编号为9号总成绩
from result re1 group by studentno;

------------------------------- 编程题-----------------------------------------
-- 1. 编程实现查询年龄比“李斯文”大的学生，使用变量显示这些学生的姓名与出生日期。要求使用变量保存待查询的学生姓名。
declare 
  cursor c_student is
    select studentname, borndate from student 
    where borndate<(select borndate from student where studentname='李斯文');
  v_borndate student.borndate%type;
  v_name nvarchar2(50);
begin
  dbms_output.put_line('年龄比‘李斯文’大的学生如下:');
  open c_student;
  loop
    fetch c_student into v_name, v_borndate;
    exit when c_student %notfound;
    dbms_output.put_line('姓名：'||v_name||'；出生日期：'||v_borndate);
  end loop;
  close c_student;
end;


-- 2. 编程实现将参加“Java程序设计基础”课程考试成绩低于60分的学生成绩，提高至60分。
begin
  update result set studentresult=60 
  where studentresult<60 and subjectno=(
    select subjectno from subject 
    where subjectname='Java程序设计基础');
  commit;
end;

-- 3. 编程实现查询一年级开设的课程信息，要求使用显式游标，显示课程编号和课程名称。
declare
  cursor c_subject is
    select subjectno, subjectname from subject 
    where gradeid=(select gradeid from grade 
      where gradename='一年级');
  v_subjectno subject.subjectno%type;
  v_subjectname subject.subjectname%type;
begin
  open c_subject;
  loop
    fetch c_subject into v_subjectno, v_subjectname;
    exit when c_subject %notfound;
    dbms_output.put_line('课程编号：'||v_subjectno||'；课程名称：'||v_subjectname);
  end loop;
  close c_subject;
end;

-- 4. 使用存储过程查询Java程序设计基础最近一次考试平均分。
create or replace procedure query_avg_score
  is
  avg_score number;
begin
  select avg(studentresult) into avg_score from result
    where subjectno=(select subjectno from subject where subjectname='Java程序设计基础') 
    and examdate=(select max(examdate) from result 
      where subjectno=(select subjectno from subject where subjectname='Java程序设计基础'));
  dbms_output.put_line('Java程序设计基础最近一次考试平均分：'||avg_score||'分');
end;

begin
  query_avg_score;
end;

-- 5. 使用函数查询Java程序设计基础最近一次考试小于90的学生名单，要求显示学生姓名，考试成绩。
create or replace function query_flunk
  return nvarchar2
  is
  result nvarchar2(10);
  
  cursor v_student_cursor is
    select table1.studentname, table1.studentresult
    from (select stu.*, re.* from student stu
          left join result re
          on stu.studentno=re.studentno) table1
    where table1.studentresult<90 and 
    table1.examdate=(select max(re1.examdate) from result re1 
                     where re1.subjectno=(select sub1.subjectno from subject sub1 
                                          where sub1.subjectname='Java程序设计基础'));
  v_studentname nvarchar2(50);
  v_studentresult number(7,2);
begin
  dbms_output.put_line('最近一次考试<90分的学生名单：');
  open v_student_cursor;
  loop
    fetch v_student_cursor into v_studentname, v_studentresult;
    exit when v_student_cursor %notfound;
    dbms_output.put_line('学生姓名：'||v_studentname||'；考试成绩：'||v_studentresult);

  end loop;
  
  close v_student_cursor;
  return result;
end;

declare
  v_result nvarchar2(50);
begin
  v_result := query_flunk();
  dbms_output.put_line(v_result);
end;

-- 6. 使用函数查询未参加“Java程序设计基础”课程最近一次考试的学生名单。
create or replace function query_miss_test
  return nvarchar2
  is
  result nvarchar2(50);
  v_studentname nvarchar2(50);
  cursor c_uncommitted_stu_1 is select s1.studentname 
  from student s1
  left join (
    select s2.subjectno,r.studentno,r.studentresult,r.examdate from result r 
    left join subject s2
    on r.subjectno=s2.subjectno
    where s2.subjectname='Java程序设计基础' and
          r.examdate=(select max(examdate) from result 
                      where subjectno=(select subjectno from subject where
                                       subjectname='Java程序设计基础'))
  )sr
  on sr.studentno=s1.studentno
  where sr.studentresult is null;         
begin
  dbms_output.put_line('Java程序设计基础最近一次考试未参加的学生名单：');
  open c_uncommitted_stu_1;
  loop
    fetch c_uncommitted_stu_1 into v_studentname;
    exit when c_uncommitted_stu_1 %notfound;
    dbms_output.put_line('学生姓名：'||v_studentname);
  end loop;
  close c_uncommitted_stu_1;
  return result;
end;

declare
  v_tmp_num nvarchar2(50);
begin
  v_tmp_num := query_miss_test();
  dbms_output.put_line(v_tmp_num);  
end;

-- 7. 使用存储过程查询指定年级开设的课程名称。
create or replace procedure query_grade_course(
  v_gradename nvarchar2,
  subjectname_cursor out sys_refcursor
)
  is
begin
  open subjectname_cursor for
    select subjectno,subjectname from subject
    where gradeid=(select gradeid from grade 
                   where gradename=v_gradename);
end;

declare
  c_temp sys_refcursor;
  v_subjectname nvarchar2(50);
  v_subjectno number(4);
  v_grade nvarchar2(50) := '一年级';
  v_index number(1) := 0;
begin
  query_grade_course(v_grade,c_temp);
  dbms_output.put_line(v_grade||'开设的课程名称如下：');
  loop
    fetch c_temp into v_subjectno,v_subjectname;
    v_index := v_index+1;
    exit when c_temp %notfound;
    dbms_output.put_line(v_index||'.'||v_subjectname);  
  end loop;
  close c_temp;
end;


-- 8. 使用存储过程，传入指定pageIndex和pageSize, 显示对应分页后的学生的基本信息。
create or replace procedure query_page_message(
  pageIndex in number,  -- 传入参数：第几页 
  pageSize in number, -- 传入参数，页大小 
  message_cursor out sys_refcursor
)
  is
begin
  open message_cursor for
    select studentno,studentname from (
      select rownum rn, stu.* 
      from student stu 
      where rownum<=pageSize*pageIndex
    ) 
    where rn>=(pageIndex-1)*pageSize+1;
end;

declare
  mes_cursor sys_refcursor;
  v_studentno number(4);
  v_studentname nvarchar2(50);
  v_pageIndex number(4) := 2;
  v_pageSize number(4) := 3;
begin
  query_page_message(v_pageIndex,v_pageSize,mes_cursor);
  dbms_output.put_line('页大小为'||v_pageSize||'时，第'||v_pageIndex||'页的学生信息如下：');
  loop
    fetch mes_cursor into v_studentno,v_studentname;
    exit when mes_cursor %notfound;
    dbms_output.put_line('学号：'||v_studentno||'；姓名：'||v_studentname);
  end loop;
  close mes_cursor;
end;

-- 9. 编写存储过程，根据学号查询某学生的所有的成绩信息。
create or replace procedure query_student_mes(
  v_studentno in number,
  studentMessage_cursor out sys_refcursor
)
  is
begin
  open studentMessage_cursor for
    select subjectno, studentresult, examdate
    from result
    where studentno=v_studentno;
end;

declare
  c_temp sys_refcursor;
  v_studentno number(4) := 1001;
  v_subjectno number(4);
  v_studentresult number(4);
  v_examdate date;
begin
  query_student_mes(v_studentno,c_temp);
  dbms_output.put_line('学号为:'||v_studentno||'的学生的所有成绩信息如下');
  loop
    fetch c_temp into v_subjectno,v_studentresult, v_examdate;
    exit when c_temp %notfound;
    dbms_output.put_line('课程编号：'||v_subjectno||'；成绩：'||v_studentresult||'；考试时间：'||v_examdate);
  end loop;
  close c_temp;
end;

-- 10. 编写函数或存储过程，查询某门课程的考试的最高分。
create or replace function query_max_score(v_subjectname nvarchar2)
  return number
  is
  v_max_studentResult number(4);
begin
  select max(studentresult) into v_max_studentResult from result
  where subjectno=(select subjectno from subject 
                   where subjectname=v_subjectname);
  return v_max_studentResult;
end;

declare
  v_subjectName nvarchar2(50) := 'Java程序设计基础';
  max_result number(4);
begin
  max_result := query_max_score(v_subjectName);
  dbms_output.put_line(v_subjectName||' 考试的最高分为：'||max_result);
end;


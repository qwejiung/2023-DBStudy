# 데이터베이스 프로그래밍
## 데이터베이스 프로그래밍의 개념
- 프로그래밍 : 프록램을 설계하고 소스코드를 작성하여 디버깅하는 과정
- 데이터베이스 프로그래밍 : DMBS에 데이터를 정의하고 저장된 데이터를 읽어와 데이터를 변경하느 프로그램을 작성하는 과정
### 데이터베이스 프로그래밍 방법
1. SQL 전용 언어를 사용하는 방법
    - MYSQL은 저장프로그램, 오라클은 PL/SQL,SQL Server는 T-SQL 용어 사용
1. 일반 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
    - 자바, C, C++ 등에 SQL을 삽입하는 방법
1. 웹 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
    - JSP, PHP, ASP 등에 SQL을 삽입하는 방법
1. 4GL(4세대 언어)
    - Delphi, Power Builder, Visual Basic 개발 도구 사용

## 저장 프로그램
- 데이터베이스 응용 프로그램을 작성하는 데 사용하는 MYSQL의 SQL 전용 언어
### 저장 프로그램
- 프로그램 로직을 프로시저로 구현하여 객체 형태로 사용
- 저장프로그램은 저장 루틴, 트리거, 이벤트로 구성되고 저장 루틴은 프로시저와 함수로 나뉨
- 프로시저를 정의하려면 CREATE PROCEDURE 문을 사용(p270)
#### 삽입 작업을 하는 프로시저
- 테이블에 데이터를 삽입하는 프로시저
- INSERT 문 대신 프로시저를 사용하면 좀 더 복잡한 조건의 삽입 작업을 인자 값만 바꾸어 수행 가능
- 저장해두었다가 필요할 때마다 호출하여 사용 가능
#### 제어문을 사용하는 프로시저(p273)
- 어떤 조건에서 어떤 코드가 실행되어야 하는지를 제어하기 위한 문법

| 구문 | 의미 | 문법 |
| --- | --- | --- |
| DELIMITER | 구문 종료 기호 설정 | DELIMITER{기호} |
| BEGIN-END | 프로그램 문을 블록화시킴<br>중첩가능 | BEGIN<br>{SQL 문}<br>END |
| IF-ELSE | 조건의 검사 결과에 따라 문장을 선택적으로 수행 | IF<조건> THEN {SQL 문}<br>[ELSE {SQL 문}]<br>END IF; |
| LOOP | LEAVE 문을 만나기 전까지 LOOP을 반복 | [label:] LOOP<br>{SQL 문 \|LEAVE [label]}<br>END LOOP |
| WHILE | 조건이 참일 경우 WHILE 문의 블록을 실행 | WHILE <조건> DO<br>{SQL 문\| BREAK \| CONTINUE}<br>END WHILE |
| REPEAT | 조건이 참일 경우 REPEAT 문의 블록을 실행 | [label:]REPEAT<br>{SQL 문\|BREAK\|CONTINUE}<br>UNTIL<조건><br>END REPEAT [label:] |
| RETURN | 프로시저를 종료<br>상태값 반환 가능 | RETURN [<식>] |
#### 결과를 반환하는 프로시저
- 주어진 작업을 수행하고 작업을 완료하기도 하지만 함수와 같이 계산된 결과를 반환할 수도 있음
#### 커서를 사용하는 프로시저
- 커서는 실행 결과 테이블을 한 번에 한 행씩 처리하기 위하여 테이블의 행을 순서대로 가리키는 데 사용<br>

| 키워드 | 역할 |
| --- | --- |
| CURSOR <cursor 이름> IS <커서 정의><br>DECLARE <cursor 이름> CURSOR FOR | 커서를 생성 |
| OPEN <cursor 이름> | 커서의 사용을 시작 |
| FETCH <cursor 이름> INTO <변수> | 행 데이터를 가져옴 |
| CLOSE <cursor 이름> | 커서의 사용을 끝냄 |
### 트리거
- 데이터의 변경문이 실행될 때 자동으로 같이 실행되는 프로시저
- 데이터의 변경문이 처리되는 실행 전, 대신하여, 실행 후에 동작
- 데이터의 변경이 일어날 때 부수적으로 필요한 작업인 데이터의 기본값 제공, 데이터 제약 준수, SQL 뷰의 수정, 참조무결성 작업 등을 수행
### 사용자 정의 함수
- 수학의 함수처럼 입력된 값을 가공하여 결과 값을 반환
- 프로시저는 CALL 명령에 의해 실행되는 독립된 프로그램이고, 사용자 정의 함수는 SELECT 문이나 프로시저 내에서 호출되어 그 값을 제공하는 용도
- 프로시저, 트리거, 사용자 정의 함수의 공통점과 차이점

| 구분 | 프로시저 | 트리거 | 사용자 정의 함수 |
| --- | --- | --- | --- |
| 공통점 | 저장 프로시저 | | |
| 정의 방법 | CREATR<br>PROCEDURE 문 | CREATE TRIGGER 문 | CREATE FUNTION 문 |
| 호출 방법 | CALL 문으로 직접 호출 | INSERT, DELETE, UPDATE 문이 실행될 때 자동으로 실행됨 | SELECT 문에 포함 |
| 기능의 차이 | SQL 문으로 할 수 없는 복잡한 로직을 수행 | 기본값 제공, 데이터 제약 준수, SQL 뷰의 수정, 참조무결성 작업 | 속성 값을 가공하여 반환, SQL 문에서 직접 사용 |
### 저장 프로그램 문법 요약
- 저장 프로그램의 기본 문법

| 구분 | 명령어 |
| --- | --- |
| 데이터 정의어 | CREATE TABEL<br>CREATE PROCEDURE<br>CREATE FUNCTION<br>CREATE TRIGGER<br>DROP |
| 데이터 조작어 | SELECT<br>INSERT<br>DELETE<br>UPDATE |
| 데이터 타입 | INTEGERm VARCHAR(n), DATE |
| 변수 | DECLARE 문으로 선언<br>치환(SET,=사용) |
| 연산자 | 산술연산자(+,-,*,/)<br>비교연산자(=,<,>,>=,<=,<>)<br>문자열연산자(||)<br>논리연산자(NOT,AND,OR) |
| 주석 | --,/* */ |
| 내장 함수 | 숫자 함수(ABS,CEIL,FLOOR,POWER 등)<br>집계 함수(AVG,COUNT,MAX,MIN,SUM)<br>날짜함수(SYSDATE,DATE,DATNAME 등)<br>문자함수(CHAR,LEFT,LOWER,SUBSTR 등) |
| 제어문 | BEGIN-END<br>IF-THEN-ELSE<br>WHILE,LOOP |
| 데이터 제어어 | GRANT<br>REVOKE |
## 데이터베이스 연동 자바 프로그래밍
### 소스코드 설명
- 연동이란 어느 한 부분이 움직이면 다른 부분도 같이 움직인다는 의미, 여기에서는 자바 프로그램을 수행하여 DBMS를 동작시킨다는 의미
- 데이터베이스 접속 자바 클래스(java.sql)


| 클래스 구분 | 클래스 혹은 인터페이스 | 주요 메소드 이름 | 메소드 설명 |
| --- | --- | --- | --- |
| java.lang | Class | Class.forName(<클래스이름>) | <클래스이름>의 JDBC 드라이버를 로딩 |
| java.sql | DriverManager | Connection getConnection<br>(url,usermpassword) | 데이터베이스 Connection 객체를 생성 |
|  | Connection | Statement createStatement() | SQL 문을 실행하는 Statement 객체를 생성 |
|  |  |void close() | Connection 객체 연결을 종료 |
|  | Statement | ResultSet executeQuery(String sql) | SQL 문을 실행해서 ResultSet 객체를 생성 |
|  |  | ResultSet executeUpdete(String sql) | INSERT/DELETE/UPDATE 문을 싱행해서 ResultSet 객체를 생성 |
|  | ResultSet | boolean first() | 결과 테이블에서 커서가 처음 투플을 가리킴 |
|  |  | blooean next() | 결과 에티블에서 커서가 다음 투플을 가리킴 |
|  |  | int getint(<int>) | <int>가 가리키는 열 값을 정수로 반환 |
|  |  | String getString(<int>) | <int>가 가리키는 열 값을 문자열로 반환 |
## 데이터베이스 연동 웹 프로그래밍
- 데이터베이스 연동 웹 프로그래밍 실습 환경

| 항목 | 프로그램 |
| --- | --- |
| 데이터베이스 프로그램 | MYSQL 8.x |
| PHP | PHP 5.x |
| 웹서버 | Apache |
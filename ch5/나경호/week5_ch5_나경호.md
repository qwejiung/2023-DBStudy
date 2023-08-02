# Chapter 05 데이터베이스 프로그래밍

## 데이터베이스 프로그래밍의 개념

- ‘데이터베이스 프로그래밍’이란 DBMS에 데이터를 정의하고 저장된 데이터를 읽어와 데이터를 변경하는 프로그램을 작성하는 과정

### 대표적인 데이터베이스 프로그래밍

1. **SQL 전용 언어**를  사용하는 방법
    - SQL 자체의 기능을 확장하여 변수, 제어, 입출력 등의 기능을 추가한 새로운 언어를 사용하는 방법
    - MySQL: 저장 프로그램, 오라클: PL/SQL, SQL Server: T-SQL이라는 용어 사용
    - 장점: 데이터베이스를 다루는 능력이 뛰어나고 다루는 방법이 쉽다.
    - 단점: 사용자 인터페이스(GUI)를 구축하는 기능이 없어 독립적으로 사용하기보다 프로시저나 함수 등으로 구현하여 다른 프로그램에서 호출해 사용한다.

2. **일반 프로그래밍 언어에 SQL을 삽입**하여 사용하는 방법
    - 자바, C, C++ 등 일반 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
    - 삽입된 SQL 문은 DBMS의 컴파일러가 처리
    - 일반 프로그래밍 언어로 작성된 응용 프로그램에서 데이터를 관리 및 검색할 수 있음
    - SQL 단독으로 사용할 때보다 복잡한 로직 구현이 용이

3. **웹 프로그래밍 언어에 SQL을 삽입**하여 사용하는 방법
    - JSP, PHP, ASP 등 웹 스크립트 언어에 SQL을 삽입하여 사용하는 방법
    - 웹 프로그래밍 언어로 작성된 프로그램에서 데이터를 관리 및 검색할 수 있음
    - SQL 문의 결과는 웹 브라우저에서 확인
    - 아파치와 같은 웹 서버가 데이터베이스 연동을 지원

4. 4GL(4th Generation Language)
    - 4세대 언어의 일종으로 데이터베이스 관리 기능과 비주얼 프로그래밍 기능을 갖춘 ‘GUI 기반 소프트웨어 개발 도구’를 사용하여 프로그래밍
    - 개발도구로는 Delphi, Power Builder, Visual Basic 등이 있음

![99807F375A6F06EA16](https://github.com/Hoya324/2023-DBStudy/assets/96857599/f78c1507-2eeb-42d3-b039-457036e39f96)



- 이 그림은 데이터베이스 응용 시스템을 ‘하드웨어 - 운영체제 - DBMS - 프로그램 환경’으로 계층화시키고, 층간에 관계를 표현한 것
- 맨 아래의 하드웨어 계층과 운영체제 계층은 DBMS가 운영되는 기반 구조 즉 플랫폼이다.

**DBMS의 종류와 특징**

| 특징 | Access | SQL Server | Oracle | MySQL | DB2 | SQLite |
| --- | --- | --- | --- | --- | --- | --- |
| 제조사 | 마이크로소프트 | 마이크로소프트 | 오라클 | 오라클 | IBM | 리처드 힙 (오픈소스) |
| 운영체제<br>기반 | 윈도우 | 윈도우, 리눅스 | 윈도우, 유닉스, 리눅스 | 윈도우, 유닉스, 리눅스 | 유닉스 | 모바일 OS<br>(안드로이드,<br>IOS 등) |
| 특징 | 개인용 DBMS | 윈도우 기반<br>기업용 DBMS | 대용량 데이터베이스를 위한 응용 | 소용량 데이터 베이스를 위한 응용 | 대용량 데이터 베이스를 위한 응용 | 모바일 전용 데이터베이스 |

## 저장 프로그램

- MySQL 전용 언어

### 저장 프로그램에 대하여

- 저장 프로그램은 로직을 procedure(프로시저)로 구현하여 객체 형태로 사용
- 저장 프로그램은 일반 프로그래밍 언어에서 사용하는 함수와 비슷한 개념으로, 작업 순서가 정해진 독립된 프로그램의 수행 단위를 말하며 정의된 다음 MySQL(DBMS)에 저장되므로 저장 프로그램이라고 한다.
- 저장 프로그램은  저장 루틴(routine), 트리거(trigger), 이벤트(event)로 구성되며, 저장 루틴은 프로시저(procedure와 함수(function)로 나뉜다.

프로시저를 정의하려면 `CREATE PROCEDURE` 문을 사용한다. 

**정의 방법**

- 프로시저는 선언부와 실행부(BEGIN-END)로 구성된다. 선언부에서는 변수와 매개변수를 선언하고 실행부에서는 프로그램 로직을 구현한다.
- 매개변수는 저장 프로시저가 호출될 때 그 프로시저에 전달되는 값이다.
- 변수는 저장 프로시저나 트리거 내에서 사용되는 값이다.
- 소스코드에 대한 설명문은 `/* */` 사이에 기술한다.(한 줄이면 `--` 도 가능)

<img width="1136" alt="스크린샷 2023-07-25 오후 3 23 22" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/0ed364a3-0c78-4055-9312-9d2b6a486d62">


### 삽입 작업을 하는 프로시저

<img width="1136" alt="스크린샷 2023-07-25 오후 3 31 34" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/9c3d6dcc-6211-460d-bce5-0210fec2524d">

### 제어문을 사용하는 프로시저

- 저장 프로그램의 제어문은 어떤 조건에서 어떤 코드가 실행되어야 하는지를 제어하기 위한 문법
- 절차적 언어의 구성요소를 포함
    - BEGIN-END 문, IF-ELSE 문, WHERE 문, RETURN 문 등의 코드 블록에 연산을 하기 위한 구문들을 포함

**저장 프로그램의 제어문**

| 구문 | 의미 | 문법 |
| --- | --- | --- |
| DELIMITER | 구문 종료 기호 설정 | DELIMITER(기호) |
| BEGIN-END | 프로그램 문을 블록화시킴<br>중첩 가능 | BEGIN<br>{SQL 문}<br>END |
| IF-ELSE | 조건의 검사 결과에 따라 문장을 선택적으로 수행 | IF <조건><br>THEN {SQL 문}<br>[ELSE {SQL 문]<br>END IF; |
| LOOP | LEAVE 문을 만나기 전까지 LOOP을 반복 | [label:]LOOP<br>{SOL | LEAVE [label]}<br>END LOOP |
| WHILE | 조건이 참일 경우 WHILE 문의 블록을 실행 | WHILE <조건> DO<br>{SQL 문 \| BREAK \| CONTINUE}<br>END WHILE |
| REPEAT | 조건이 참일 경우 REPEAT 문의 블록을 실행 | [label:] REPEAT<br>{SQL 문 \| BREAK \| CONTINUE}<br>UNTIL <조건><br>END REPEAT [label:] |
| RETURN | 프로시저를 종료<br>상태값 반환 가능 | RETURN[<식>] |

- **동일한 도서가 있는지 점검한 후 삽입하는 프로시저**
  
    <img width="1465" alt="스크린샷 2023-07-25 오후 4 02 39" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/a29f1423-b681-4966-9277-6de998664936">

- BookInsertOrUpdate 프로시저를 실행한 후 Book 테이블
    
    ```sql
    CALL BookInsertOrUpdate(13, '스포츠과학', '마당과학서적', 25000);
    SELECT * FROM Book;
    ```
    <img width="299" alt="스크린샷 2023-07-25 오후 4 07 03" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/0ed2bd25-bac1-4726-8710-18b9d335d2e6">

    
    
    ```sql
    CALL BookInsertOrUpdate(13, '스포츠과학', '마당과학서적', 20000);
    SELECT * FROM Book;
    ```
    <img width="304" alt="스크린샷 2023-07-25 오후 4 07 16" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/70517273-fb17-4bfb-bdbf-4497f688b711">
    
    

### 결과를 반환하는 프로시저

- 저장 프로시저는 주어진 작업을 수행하고 잡업을 완료하기도 하지만 함수와 같이 계산된 결과를 반환할 수도 있다.
- **Book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저**
  
    <img width="1465" alt="스크린샷 2023-07-25 오후 4 13 17" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/083604d0-f42d-41b0-a4c2-b6c476853cf9">


### 커서를 사용하는 프로시저

- SQL 문의 실행 결과가 다중행 또는 다중열일 경우 프로그램에서는 한 행씩 처리한다.
- 커서는 실행 결과 테이블을 한 번에 한 행씩 처리하기 위하여 테이블의 행을 순서대로 가리키는 데 사용한다.
- 커서에 관련된 키워드로는 CURSOR, OPEN, FETCH, CLOSE 등이 있다.
    
    
    | 키워드 | 역할 |
    | --- | --- |
    | CURSOR <cursor 이름> IS <커서 정의>
    DECLARE <cursor 이름> CURSOR FOR | 커서를 생성 |
    | OPEN <cursor 이름> | 커서의 사용을 시작 |
    | FETCH <cursor 이름> INTO <변수> | 행 데이터를 가져옴 |
    | CLOSE <cursor 이름> | 커서의 사용을 끝냄 |
- **Orders 테이블의 판매 도서에 대한 이익를 계산하는 프로시저**
    
    <img width="1465" alt="스크린샷 2023-07-25 오후 4 44 58" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/06376471-c7a6-4139-a2d2-3091d135442a">

    

### 트리거

- 트리거(trigger)는 데이터 변경(INSERT, DELETE, UPDATE) 문이 실행될 때 자동으로 같이 실행되는 프로시저를 말한다.
- 보통 트리거는 데이터의 변경문이 처리되는 세 가지 시점, 즉 BEFORE, INSTEAD OF, AFTER에 동작
    - DBMS 제조사에 따라 트리거의 정의가 많이 다르다.
- 트리거는 데이터의 변경이 일어날 때 부수적으로 필요한 작업인 데이터의 기본값 제공, 데이터 제약 준수, SQL 뷰의 수정, 참조무결성 작업 등을 수행한다.
- 예) Book 테이블에 새로운 도서를 삽입할 때 삽입된 내용을 백업하기 위해 다른 테이블 Book_log에 삽입된 내용을 기록한다고 하자. Book 테이블에 INSERT 문을 수행하면서 같이 실행할 수도 있지만 사용자 입장에서는 번거롭기도 하고 보안상 백업을 감추어야할 경우도 있다.
- 이때 트리거를 사용하면 편하다.
- **신규 도서를 삽입한 후 자동으로 Book_log 테이블에 삽입한 내용을 기록하는 트리거**
    
    <img width="1136" alt="스크린샷 2023-07-25 오후 5 54 04" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/8a378ed9-3e53-4894-9e29-3692f37bf9b7">


### 사용자 정의 함수

- 사용자 정의 함수는 수학의 함수와 마찬가지로 입력된 값을 가공하여 결과 값을 되돌려준다.
- 프로시저와 비슷해 보이지만 프로시저는 CALL 명령에 의해 실행되는 독립된 프로그램이고, 사용자 정의 함수는 SELECT 문이나 프로시저 내에 호출되어 SQL 문이나 프로시저에 그 값을 제공하는 용도로 사용된다.
- MySQL에서 작성할 수 있는 사용자 정의 함수는 단일 값을 돌려주는 스칼라 함수가 일반적
- 예) 판매된 도서의 이익을 계산하기 위해 각 주문 건별로 실제 판매가격인 saleprice를 입력받아 가격에 맞는 이익(30,000원 이상이면 10%, 30,000원 미만이면 5%)를 계산하여 반환하는 함수를 작성해보자
- **판매된 도서에 대한 이익을 계산하는 함수**
    
    <img width="1136" alt="스크린샷 2023-07-25 오후 7 04 58" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/317df914-b414-4eab-a947-9ade49d56991">

**프로시저, 트리거, 사용자 정의 함수의 공통점과 차이점**

| 구분 | 프로시저 | 트리거 | 사용자 정의 함수 |
| --- | --- | --- | --- |
| 공통점 | 저장 프로시저 | 저장 프로시저 | 저장 프로시저 |
| 정의 방법 | CREATE
PROCEDURE 문 | CREATE TRIGGER 문 | CREATE FUNCTION 문 |
| 호출 방법 | CALL 문으로 직접 호출 | INSERT, DELETE, UPDATE 문이 실행될 때 자동으로 실행됨 | SELECT 문에 포함 |
| 기능의 차이 | SQL 문으로 할 수 없는 복잡한 로직을 수행 | 기본값 제공, 데이터 제약 준수, SQL 뷰의 수정, 참조무결성 작업 등을 수행 | 속성 값을 가공하여 반환, SQL 문에서 직접 사용 |

### 저장 프로그램 문법 요약

| 구분 | 명령어 |
| --- | --- |
| 데이터 정의어 | CREATE TABLE<br>CREATE PROCEDURE<br>CREATE FUNCTION<br>CREATE TRIGGER<br>DROP |
| 데이터 조작어 | SELECT<br>INSERT<br>DELETE<br>UPDATE |
| 데이터 타입 | INTEGER, VARCHAR(n), DATE |
| 변수 | DECLARE 문으로 선언 <br>치환(SET, = 사용) |
| 연산자 | 산술연산자(+, -, *, /)<br>비교연산자(=, <,>.>=, <=, <>)<br>문자열연산자(||)<br>논리연산자(NOT, AND, OR) |
| 주석 | —, /* */ |
| 내장 함수 | 숫자 함수(ABS, CEIL, FLOOR, POWER 등)<br>집계 함수(AVG, COUNT, MAX MIN, SUM)<br>날짜 함수(SYSDATE, DATE, DATNAME 등)<br>문자 함수(CHAR, LEFT, LOWER, SUBSTR 등) |
| 제어문 | BEGIN-END<br>IF-THEN-ELSE<br>WHILE, LOOP |
| 데이터 제어어 | GRANT<br>REVOKE |

## 데이터베이스 연동 자바 프로그래밍

### 소스코드

```java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// SQL 관련 클래스는 java.sql .*에 포함되어 있다.
public class BookList {
  Connection con;
  // 클래스 booklist를 선언한다. java.sql의 Connection 객체 con을 선언한다.
  public BookList() {
    String Driver="";
    String url="jdbc:mysql://localhost:3306/madang?&serverTimezone=Asia/Seoul";
    String userid="madang";
    String pwd="Gh852852!";
// 접속변수를 초기화한다. url은 자바 드라이버 이름, 호스트명(localhost), 포트번호를 입력한다
// userid는 관리자(madang), pwd는 사용자의 비밀번호(madang)를 입력한다.    
    try { /* 드라이버를 찾는 과정 */
      Class.forName("com.mysql.cj.jdbc.Driver");
      System.out.println("드라이버 로드 성공");
    } catch(ClassNotFoundException e) {
      e.printStackTrace();
    }
// Class.forName()으로 드라이버를 로딩한다. 드라이버 이름을 Class.forName에 입력한다.      
    try { /* 데이터베이스를 연결하는 과정 */
      System.out.println("데이터베이스 연결 준비...");
      con= DriverManager.getConnection(url, userid, pwd);
      System.out.println("데이터베이스 연결 성공");
    } catch(SQLException e) {
      e.printStackTrace();
    }
  }
  // 접속 객체 con을 DriverManager.getConnection 함수로 생성한다.
// 접속이 성공하면 "데이터베이스 연결 성공"을 출력하도록 한다.  
// 문자열 query에 수행할 SQL 문을 입력한다.
  private void sqlRun() {
    String query="SELECT * FROM Book"; /* SQL 문 */
    try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
      Statement stmt=con.createStatement();
      ResultSet rs=stmt.executeQuery(query);
      System.out.println(" BOOK NO \\tBOOK NAME \\t\\tPUBLISHER \\tPRICE ");
      while(rs.next()) {
        System.out.print("\\t"+rs.getInt(1));
        System.out.print("\\t"+rs.getString(2));
        System.out.print("\\t\\t"+rs.getString(3));
        System.out.println("\\t"+rs.getInt(4));
      }

      con.close();
    } catch(SQLException e) {
      e.printStackTrace();
    }
  }

  public static void main(String args[]) {
    BookList so = new BookList();
    so.sqlRun();
  }
}
```

### 프로그램 실습

[1단계] DBMS 설치 및 환경설정

1. MySQL 8.x 설치
2. SQL 접속을 위한 사용자(madang)설정

[2단계] 데이터베이스 준비

1. 마당서점 데이터베이스 준비(demo.madang.sql)

[3단계] 자바 실행(명령 프롬포트 이용)

1. 자바 컴파일러 설치
2. JDBC 드라이버 설치
3. 자바 프로그램 준비(Booklist.java)
4. 컴파일 및 실행
5. 자바 실행(IntelliJ 이용)
6. IntelliJ 개발도구 설치
7. JDBC 드라이버 설치
8. 자바 프로그램 준비(Booklist.java)
9. 컴파일 및 실행

## 데이터베이스 연동 웹 프로그래밍

### 소스코드 설명

다음의 booklist.php는 Book 테이블에 저장된 도서를 읽어와 웹 브라우저에 출력하는 PHP 프로그램이다. 

PHP 프로그램은 HTML 태그에 PHP 스크립트를 끼워 넣어 작성하는데, PHP 스크립트 부분은 <?PHP … ?>에 넣어 실행한다.

bookview.php는 도서 한 권에 대한 상세 정보를 보는 프로그램이다.

`booklist.php`

```php
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<h2><blockquote> 마당서점 도서목록 </blockquote></h2>
<?php
  $conn = mysqli_connect('localhost', 'madang', 'madang', 'madang');
  if (mysqli_connect_error($conn)){
      echo 'Connection Error';
      exit();
  }

  $sql = "SELECT * FROM Book";
  $result = mysqli_query($conn, $sql);

  echo '<table border=1><tr><td>BOOKNAME</td><td>PUBLISHER</td><td>PRICE</td></tr> ';
  while($row = mysqli_fetch_array($result)) {
      echo ('<tr><td><b>
        <a href="bookview.php?id='.$row['bookid'].'">'
          .$row['bookname'].'</a></b></td><td>'
          .$row['publisher'].' </td><td> '
          .$row['price'].'</td></tr>');
  }
  echo '</table><p>';

?>
```

`bookview.php`

```php
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<h2><blockquote> 마당서점 도서목록 </blockquote></h2>
<?php
    $conn = mysqli_connect('localhost', 'madang', 'madang', 'madang');
    if (mysqli_connect_error($conn)){
        echo 'Connection Error';
        exit();
    }

    $sql = "SELECT * FROM Book WHERE bookid='".$_GET['id']."'";
    $result = mysqli_query($conn, $sql);
    $id=$_GET['id'];
    $row = mysqli_query($conn, $sql);
    echo '<table border=1><tr><td>책번호</td><td>'.$id.'</td></tr>';
    echo '<tr><td>책제목</td><td>'.$row['bookname'].'</td></tr>';
    echo '<tr><td>출판사</td><td>'.$row['publisher'].'</td></tr>';
    echo '<tr><td>가격</td><td>'.$row['price'].'</td></tr>';
    echo '</table>';
    echo '<a href="./booklist.php">목록보기</a>';
?>
```

## 주요개념

### 연동이란?

- 어느 한 부분이 움직이면 다른 부분도 같이 움직인다는 의미로, 데이터베이스 응용에서는 일반 프로그램을 수행하여 DBMS를 동작시킨다는 의미이다.
- 연동은 자바 프로그램 혹은 웹 프로그램을 이용한다.

### JDBC

- 자바는 객체지향 언어이기 때문에 객체를 호출하여 데이터베이스에 접속한다.
- 데이터베이스에 접속하는 API(Application Programming Interface)를 java.sql.*에서 제공한다.
- java.sql에 정의된 API는 각 DBMS 제조사에서 자신의 제품에 맞게 구현해서 제공하는데, 이를 JDBC(Java DataBase Connectivity) 드라이버라고 한다.

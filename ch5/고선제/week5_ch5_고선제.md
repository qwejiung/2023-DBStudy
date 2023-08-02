# 1. 데이터베이스 프로그래밍의 개념

- 데이터베이스 프로그래밍
    - DBMS에 데이터를 정의하고 저장된 데이터를 읽어와 데이터를 변경하는 프로그램을 작성하는 과정
    - 일반 프로그래밍 언어에 SQL문을 삽입하여 각 언어의 장점을 살린 프로그래밍을 주로 한다. (삽입 프로그래밍) Ex) SQL + 자바

- 데이터베이스 프로그래밍의 네 가지 대표적인 방법
    - SQL전용 언어를 사용하는 방법
    - 일반 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
        - 자바 , C, C++
    - 웹 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
        - JSP, PHP, ASP 등
    - 4GL(4th Generation Language)
        - GUI 기반 소프트웨어 개발 도구 사용

# 2. 저장 프로그램

- MySQL의 전용 언어 : 저장 프로그램(Stored Program)
- 오라클의 전용 언어 : PL/SQL
- 마이크로소프트 전용언어 : T-SQL

→ SQL 전용 언어는 SQL문제에 변수, 제어, 입출력 등의 프로그래밍 기능을 추가하여 SQL만으로 처리하기 어려운 문제를 해결한다.

### 1) 저장 프로그램

- 프로그램 로직을 프로시저(procedure)로 구현하여 객체 형태로 사용.
- 작업 순서가 정해진 독립된 프로그램의 수행 단위를 말하며 정의된 다음 MySQL에 저장된다.
- 저장 루틴(routine), 트리거(trigger), 이벤트(event)로 구성
    - 저장 루틴은 프로시저(procedure)와 함수(function)으로 나뉨

- MySQL에서 저장 프로그램을 정의하는 과정
    1. SQL편집기에서 프로그램을 정의
    2. 스크립트 실행 아이콘 클릭
    3. 실행 결과가 결과 화면창에 나타남
    4. 개체 탐색기의 Stored Procedures/Functions 폴더에 객체가 만들어진다.
    - 프로시저를 정의하려면 CREATE PROCEDURE문을 사용
    - 프로시저는 선언부와 실행부(BEGIN-END)로 구성
        - 선언부에서는 변수와 매개변수를 선언하고
        - 실행부에서는 프로그램 로직을 구현
    - 매개변수는 저장 프로시저가 호출될 때 그 프로시저에 전달되는 값이다.
    - 변수는 저장 프로시저나 트리거 내에서 사용되는 값이다.
    - 소스코드에 대한 설명문은 /* 와 */사이에 기술한다. 만약 설명문이 한 줄이면 이중 대시(- -) 기호 다음에 기술해도 된다.

```sql
delimiter //
CREATE PROCEDURE dorepeat(p1 INT)
BEGIN
     SET @x =0;
     REPEAT SET @x = @x+1; UNTIL @x>p1 END REPEAT ;
END //
delimiter ;

call dorepeat(1000);
```

### 삽입 작업을 하는 프로시저

- 삽입 작업을 인자 값만 바꾸어 수행할 수 있게 해줌.

```sql
use madang;
delimiter //
CREATE PROCEDURE InsertBook(
    IN myBookID INTEGER,
    IN myBookName VARCHAR(40),
    IN myPublisher VARCHAR(40),
    IN myPrice INTEGER)
    BEGIN
        INSERT INTO Book(bookid, bookname, publisher, price)
            VALUES (myBookID, myBookName, myPublisher, myPrice);
    END;
//
delimiter ;
```

- 프로시저 InsertBook을 테스트하는 부분

```sql
use madang;
CALL InsertBook(13,'스포츠과학', '마당과학서적', 25000);
SELECT * FROM Book;
```

→ 프로시저가 호출되어 실행되면 Book 테이블에 bookid가 13인 새로운 투플 한 개가 추가된다.

- 프로시저 정의문은 CREATE PROCEDURE-BEGIN-END형식이다.

### 제어문을 사용하는 프로시저

- 저장 프로그램의 제어문은 어떤 조건에서 어떤 코드가 실행되어야 하는지를 제어하기 위한 문법으로, 절차적 언어의 구성요소를 포함한다.

| 구문 | 의미 | 문법 |
| --- | --- | --- |
| DELIMITER | 구문 종료 기호 설정 | DELIMITER(기호) |
| BEGIN-END | 프로그램 문을 블록화시킴<br>중첩 가능 | BEGIN<br>{SQL 문}<br>END |
| IF-ELSE | 조건의 검사 결과에 따라 문장을 선택적으로 수행 | IF <조건><br>THEN {SQL 문}<br>[ELSE {SQL 문}]<br>END IF; |
| LOOP | LEAVE 문을 만나기 전까지 LOOP을 반복 | [label:]LOOP<br>{SOL | LEAVE [label]}<br>END LOOP |
| WHILE | 조건이 참일 경우 WHILE 문의 블록을 실행 | WHILE <조건> DO<br>{SQL 문 \| BREAK \| CONTINUE}<br>END WHILE |
| REPEAT | 조건이 참일 경우 REPEAT 문의 블록을 실행 | [label:] REPEAT<br>{SQL 문 \| BREAK \| CONTINUE}<br>UNTIL <조건><br>END REPEAT [label:] |
| RETURN | 프로시저를 종료<br>상태값 반환 가능 | RETURN[<식>] |

```sql
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
    myBookID INTEGER,
    myBookName VARCHAR(40),
    myPublisher VARCHAR(40),
    myPrice INTEGER
)
BEGIN
    DECLARE mycount INTEGER;
    SELECT  count(*) INTO mycount FROM Book
        WHERE bookname LIKE myBookName;
IF mycount!=0 THEN
    SET SQL_SAFE_UPDATES =0;
    UPDATE Book SET  price=myPrice
    WHERE  bookname LIKE myBookName;
    ELSE
    INSERT INTO Book(BOOKID, BOOKNAME, PUBLISHER, PRICE)
        VALUES (myBookID, myBookName, myPublisher, myPrice);
end if;
end;
//
delimiter ;
```

- BookInsertOrUpdate 프로시저 실행하여 테스트

```sql
CALL  BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book;
```

### 결과를 반환하는 프로시저

- 주어진 작업을 수행하고 작업을 완료하기도 하지만 함수와 같이 계산된 겨로가를 반환할 수도 있다.
- 반환하는 방법은 프로시저를 선언할 때 인자의 타입을 OUT으로 설정한 후, 이 인자 변수에 값을 주면 된다.

```sql
delimiter  //
CREATE PROCEDURE AveragePrice(
OUT AverageVal INTEGER
)
BEGIN
    SELECT AVG(price) INTO AverageVal
    FROM Book WHERE price IS NOT NULL;
end
//
delimiter ;
```

- AveragePrice 테스트

```java
CALL AveragePrice(@myValue);
SELECT @myValue;
```

### 커서를 사용하는 프로시저

- 커서(cursor)는 실행 결과 테이블을 한 번에 한 행씩 처리하기 위해 테이블의 행을 순서대로 가리키는 데 사용한다.

| 키워드 | 역할 |
| --- | --- |
| CURSOR<cursor 이름> IS <커서 정의> <br> DECLARE <cursor 이름> CURSOR FOR | 커서를 생성 |
| OPEN <cursor 이름> | 커서의 사용을 시작 |
| FETCH<cursor 이름> INTO <변수> | 행 데이터를 가져옴 |
| CLOSE <cursor 이름> | 커서의 사용을 끝냄 |

- Orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저

```sql
delimiter //
CREATE PROCEDURE Interest()
BEGIN
    DECLARE myInterest INTEGER DEFAULT  0.0;
    DECLARE Price INTEGER;
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;
    DECLARE InterestCursor CURSOR FOR
          SELECT saleprice FROM Orders;
    DECLARE CONTINUE HANDLER FOR
            NOT FOUND SET endOfRow =TRUE;
    OPEN InterestCursor;
    cursor_loop : LOOP
        FETCH  InterestCursor INTO  Price;
        IF endOfRow THEN LEAVE cursor_loop;
        END IF;
        IF Price >= 30000 THEN
            SET myInterest = myInterest + Price * 0.1;
        ELSE
            SET myInterest = myInterest + Price * 0.05;
        END IF;
        END LOOP  cursor_loop;
    CLOSE InterestCursor;
    SELECT CONCAT('전체 이익 금액 =', myInterest);
    END;
//
delimiter ;
```

- 위 sql문 실행

```sql
CALL Interest();
```

### 2) 트리거

- 트리거는 데이터의 변경(INSERT, DELETE, UPDATE)문이 실행될 떄 자동으로 같이 실행되는 프로시저를 말한다.
- 실행 전(BEFORE), 대신하여(INSTEAD OF), 실행 후(AFTER)에 동작한다.
- 부수적으로 필요한 작업인 데이터의 기본값 제공, 데이터 제약 준수, SQL 뷰의 수정, 참조무결성 작업 등을 수행한다.

- 신규 도서를 삽입한 후 자동으로 Book_log 테이블에 삽입한 내용을 기록하는 트리거

```sql
delimiter //
CREATE TRIGGER AfterInsertBook
    AFTER INSERT ON Book FOR EACH ROW
BEGIN
    DECLARE average INTEGER;
    INSERT INTO Book_log
        VALUES (new.bookid, new.bookname, new.publisher, new.price);
end;
//
delimiter;
```

- 삽입한 내용을 기록하는 트리거 확인

```sql
INSERT INTO Book VALUES (14, '스포츠 과학 1', '이상미디어', 25000);
SELECT * FROM Book WHERE  bookid=14;
SELECT * FROM Book_log WHERE bookid_l='14';
```

### 3) 사용자 정의 함수

- SELECT문이나 프로시저 내에서 호출되어 SQL문이나 프로시저에 그 값을 제공하는 용도로 사용된다.

→ 단일 값을 돌려주는 스칼라 함수가 일반적이다.

- 판매된 도서에 대한 이익을 계산하는 함수

```sql
delimiter //
CREATE FUNCTION fnc_Interest(
Price INTEGER) RETURNS INT
BEGIN
    DECLARE myInterest INTEGER;
    -- 가격이 30,000원 이상이면 10%, 30,000원 미만이면 5%
    IF Price >= 30000 THEN SET myInterest = Price *0.1;
    ELSE SET myInterest = Price * 0.05;
    END IF;
    RETURN  myInterest;
end //
delimiter ;
```

- Orders 테이블에서 각 주문에 대한 이익을 출력

```sql
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) interest
FROM Orders;
```

- 프로시저, 트리거, 사용자 정의 함수의 공통점과 차이점

| 구분 | 프로시저 | 트리거 | 사용자 정의 함수 |
| --- | --- | --- | --- |
| 공통점 | 저장 프로시저 | 저장 프로시저 | 저장 프로시저 |
| 정의 방법 | CREATE PROCEDURE 문 | CREATE TRIGGER 문 | CREATE FUNCTION 문 |
| 호출 방법 | CALL문으로 직접 호출 | INSERT, DELETE, UPDATE문이 실행될 때 자동 실행 | SELECT문에 포함 |
| 기능의 차이 | SQL문으로 할 수 없는 복잡한 로직 수행 | 기본값 제공, 데이터 제약 준수, SQL뷰의 수정, 참조무결성 작업 수행 | 속성 값을 가공하여 반환, SQL 문에서 직접 사용 |

### 4) 저장 프로그램 문법 요약
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


# 3. 데이터베이스 연동 자바 프로그래밍

### 연동이란?

- 어느 한 부분이 움직이면 다른 부분도 같이 움직인다는 의미로, 데이터베이스 응용에서는 일반 프로그램을 수행하여 DBMS를 동작시킨다는 의미이다.
- 연동은 자바 프로그램 혹은 웹 프로그램을 이용한다.

### JDBC

- 자바는 객체지향 언어이기 때문에 객체를 호출하여 데이터베이스에 접속한다.
- 데이터베이스에 접속하는 API(Application Programming Interface)를 java.sql.*에서 제공한다.
- java.sql에 정의된 API는 각 DBMS 제조사에서 자신의 제품에 맞게 구현해서 제공하는데, 이를 JDBC(Java DataBase Connectivity) 드라이버라고 한다.

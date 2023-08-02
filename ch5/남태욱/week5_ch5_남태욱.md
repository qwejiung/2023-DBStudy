# Chapter 05 데이터베이스 프로그래밍

## 1. 데이터베이스 프로그래밍의 개념

### 데이터베이스 프로그래밍 방법

- SQL 전용 언어를 사용하는 방법
- 일반 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
- 웹 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
- 4GL (4th Generation Language)를 사용하는 방법

## 2. 저장 프로그램 (Stored Program)

- 데이터베이스 응용 프로그램을 작성하는 데 사용하는 MySQL의 SQL 전용 언어
- SQL에 변수, 제어, 입출력 등의 프로그래밍 기능을 추가하여 SQL만으로 처리하기 어려운 문제를 해결할 수 있다.

### 저장 프로그램

- 프로그램 로직을 프로시저(procedure)로 구현하여 객체 형태로 사용하는 것
- 일반 프로그래밍 언어에서 사용하는 함수와 비슷한 개념
- 저장 루틴(routine), 트리거(trigger), 이벤트(event)로 구성되며, 저장 루틴은 프로시저(procedure)와 함수(function)으로 나뉜다.

#### 프로시저

- 데이터베이스에 대한 일련의 작업을 정리한 절차를 관계형 데이터베이스 관리 시스템이 저장한 것
- CREATE PROCEDURE 문으로 정의한다.
- 선언부와 실행부 (BEGIN-END)로 구성된다.

##### 삽입 작업을 하는 프로시저

- 프로시저 대신 INSERT문으로 삽입 작업을 할 수 있지만, 프로시저로 작성해두면 추후에 인자 값만 바꾸어 수행하거나, 저장해두었다가 필요할 때마다 호출하여 사용할 수도 있다.

```mysql
-- Book 테이블에 한 개의 튜플을 삽입하는 프로시저
use madang
delimiter //
CREATE PROCEDURE InsertBook(
    IN myBookID INTEGER,
    IN myBookName VARCHAR(40),
    IN myPublisher VARCHAR(40),
    IN myPrice INTEGER)
BEGIN
    INSERT INTO Book(bookid, bookname, publisher, price)
    VALUES(myBookID, myBookName, myPublisher, myPrice);
END;
//
delimiter ;
-- InsertBook 프로시저 사용
CALL InsertBook(13, '스포츠과학', '마당과학서적', 25000);
SELECT * FROM Book;
```

- CREATE - BEGIN - END 형식
- 프로시저명 뒤 괄호 안에 인자가 정의되어 있다.
- IN은 입력 인자, OUT은 출력 인자를 뜻한다.
- 프로시저는 해당 데이터베이스의 'Stored Procedures' 항목에 생성된다.
- CALL 문으로 프로시저를 호출할 수 있다.
- ```DROP PROCEDURE 프로시저명;``` 으로 프로시저를 삭제할 수 있다.

##### 제어문을 사용하는 프로시저

저장 프로그램의 제어문

|     구문     |             의미              |                                           문법                                           |
|:----------:|:---------------------------:|:--------------------------------------------------------------------------------------:|
| DELIMITER  |         구문 종료 기호 설정         |                                     DELIMITER(기호)                                      |
| BEGIN-END  |   프로그램 문을 블록화시킴<br>중첩 가능    |                                BEGIN<br>{SQL 문}<br>END                                 |
|  IF-ELSE   | 조건의 검사 결과에 따라 문장을 선택적으로 수행  |                  IF <조건><br>THEN {SQL 문}<br>[ELSE {SQL 문]<br>END IF;                   |
|    LOOP    |  LEAVE 문을 만나기 전까지 LOOP을 반복  |                                  [label:]LOOP<br>{SOL                                  | LEAVE [label]}<br>END LOOP |
|   WHILE    |  조건이 참일 경우 WHILE 문의 블록을 실행  |               WHILE <조건> DO<br>{SQL 문 \| BREAK \| CONTINUE}<br>END WHILE               |
|   REPEAT   | 조건이 참일 경우 REPEAT 문의 블록을 실행  |  [label:] REPEAT<br>{SQL 문 \| BREAK \| CONTINUE}<br>UNTIL <조건><br>END REPEAT [label:]  |
|   RETURN   |    프로시저를 종료<br>상태값 반환 가능    |                                      RETURN[<식>]                                       |

```mysql
-- 동일한 도서가 있는지 점검한 후 삽입하는 프로시저
use madang
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
  myBookID INTEGER,
  myBookName VARCHAR(40), 
  myPublisher VARCHAR(40),
  myPrice INT) 
BEGIN
  DECLARE mycount INTEGER;
  SELECT count(*) INTO mycount FROM Book 
    WHERE bookname LIKE myBookName; 
  IF mycount!=0 THEN
    SET SQL_SAFE_UPDATES=0; /* DELETE, UPDATE 연산에 필요한 설정 문 */
    UPDATE Book SET price = myPrice
      WHERE bookname LIKE myBookName;
  ELSE
    INSERT INTO Book(bookid, bookname, publisher, price)
      VALUES(myBookID, myBookName, myPublisher, myPrice);
  END IF;
END;
//
delimiter ;

-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 25000);
SELECT * FROM Book; -- 15번 투플 삽입 결과 확인
-- BookInsertOrUpdate 프로시저를 실행하여 테스트하는 부분
CALL BookInsertOrUpdate(15, '스포츠 즐거움', '마당과학서적', 20000);
SELECT * FROM Book; -- 15번 투플 가격 변경 확인
```

- 위 프로시저의 매개변수에는 IN/OUT이 생략되어 있어 기본값인 IN으로 설정된다.
- DECLARE 문으로 지역 변수를 선언한다.

##### 결과를 반환하는 프로시저

- 프로시저는 함수처럼 계산된 결과를 반환할 수도 있다.
- 결과값 반환을 위해서는 프로시저 선언 시에 인자의 타입을 OUT으로 지정하고, 해당 인자 변수에 값을 대입한다.

```mysql
-- Book 테이블에 저장된 도서의 평균 가격을 반환하는 프로시저
delimiter //
CREATE PROCEDURE AveragePrice(
  OUT AverageVal INTEGER)
BEGIN
  SELECT AVG(price) INTO AverageVal 
  FROM Book WHERE price IS NOT NULL;
END;
//
delimiter ;

/* 프로시저 AveragePrice를 테스트하는 부분 */
CALL AveragePrice(@myValue);
SELECT @myValue;
```

##### 커서를 사용하는 프로시저

- SQL 문의 실행 결과가 다중 행 또는 다중 열일 경우 프로그램에서 한 행씩 처리한다.
- 커서(cursor)는 실행 결과 테이블을 한 번에 한 행씩 처리하기 위하여 테이블의 행을 순서대로 가리키는 데 사용한다.
- 커서에 관련된 키워드로는 CURSOR, OPEN, FETCH, CLOSE 등이 있다.

|                                키워드                                |     역할      |
|:-----------------------------------------------------------------:|:-----------:|
| CURSOR<cursor 이름> IS <커서 정의> <br> DECLARE <cursor 이름> CURSOR FOR  |   커서를 생성    |
|                         OPEN <cursor 이름>                          | 커서의 사용을 시작  |
|                    FETCH<cursor 이름> INTO <변수>                     | 행 데이터를 가져옴  |
|                         CLOSE <cursor 이름>                         | 커서의 사용을 끝냄  |

```mysql
-- Orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저
delimiter //  
CREATE PROCEDURE Interest()
BEGIN
  DECLARE myInterest INTEGER DEFAULT 0.0;
  DECLARE Price INTEGER;
  DECLARE endOfRow BOOLEAN DEFAULT FALSE; 
  DECLARE InterestCursor CURSOR FOR 
	SELECT saleprice FROM Orders;
  DECLARE CONTINUE handler 
	FOR NOT FOUND SET endOfRow=TRUE;
  OPEN InterestCursor;
  cursor_loop: LOOP
    FETCH InterestCursor INTO Price;
    IF endOfRow THEN LEAVE cursor_loop; 
    END IF;
    IF Price >= 30000 THEN 
        SET myInterest = myInterest + Price * 0.1;
    ELSE 
        SET myInterest = myInterest + Price * 0.05;
    END IF;
  END LOOP cursor_loop;
  CLOSE InterestCursor;
  SELECT CONCAT(' 전체 이익 금액 = ', myInterest);
END;
//
delimiter ;

/* Interest 프로시저를 실행하여 판매된 도서에 대한 이익금을 계산 */
CALL Interest();
```

### 트리거

- 데이터의 변경 (INSERT, DELETE, UPDATE 문이 실행될 때) 자동으로 같이 실행되는 프로시저
- 트리거는 보통 데이터의 변경문이 처리되는 세 가지 시점 (BEFORE, INSTEAD OF, AFTER)에 동작한다.
- 트리거의 정의는 DBMS 종류에 따라 다르다.
- CREATE TRIGGER 문으로 생성한다.

```mysql
-- 신규 도서를 삽입한 후 자동으로 Book_log 테이블에 삽입한 내용을 기록하는 트리거
delimiter //
CREATE TRIGGER AfterInsertBook 
  AFTER INSERT ON Book FOR EACH ROW
BEGIN  
  DECLARE average INTEGER;
  INSERT INTO Book_log 
    VALUES(new.bookid, new.bookname, new.publisher, new.price);
END;
//
delimiter ;

/* 삽입한 내용을 기록하는 트리거 확인 */
INSERT INTO Book VALUES(14, '스포츠 과학 1', '이상미디어', 25000);
SELECT * FROM Book WHERE BOOKID=14;
SELECT * FROM Book_log  WHERE BOOKID_L='14' ; -- 결과 확인
```

- CREATE TRIGGER - BEGIN - END 의 구조이다.
- 3행의 AFTER INSERT .... 은 트리거가 Book 테이블에 INSERT 문이 실행되면 자동으로 실행된다는 의미이다.

### 사용자 정의 함수

- 내장 함수 뿐만 아니라 사용자가 직접 함수를 정의하여 사용할 수 있다.
- 프로시저와 유사하지만 프로시저는 CALL 명령에 의해 실행되는 독립된 프로그램이고, 사용자 정의 함수는 SELECT 문이나 프로시저 내에서 호출될 수 있다.

```mysql
-- 판매된 도서에 대한 이익을 계산하는 함수
delimiter //
CREATE FUNCTION fnc_Interest(
  Price INTEGER) RETURNS INT  
BEGIN
  DECLARE myInterest INTEGER;
-- 가격이 30,000원 이상이면 10%, 30,000원 미만이면 5%
  IF Price >= 30000 THEN SET myInterest = Price * 0.1;
  ELSE SET myInterest := Price * 0.05;
  END IF;
  RETURN myInterest;
END; //
delimiter ;

/* Orders 테이블에서 각 주문에 대한 이익을 출력 */
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) interest 
FROM Orders;
```

- CREATE FUNCTION - BEGIN - END 구조이다.
- 위 함수의 매개변수는 Pruce이다.
- 단일 값을 반환하는 스칼라 함수이다.

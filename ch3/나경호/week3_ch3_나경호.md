# CHAPTER 03 SQL 기초

## SQL 개요

### SQL 특징

- SQL 문은 세미클론(;)으로 끝난다.(생략 가능하지만 좋은 습관은 아니다.)
- SQL 예약어는 대분자로, 테이블이나 속성 이름은 소문자로 적어주는 것이 좋다.
- 문자열 비교 시 인용부호 `''`(작은 따옴표)

**SQL 구분**

- 데이터 정의어(DDL, Data Definition Language)
    - 테이블이나 관계의 구조를 생성하는 데 사용
    - CREATE, ALTER, DROP
- 데이터 조작어(DML, Data Manipulation Language)
    - 테이블에 데이터를 검색, 삽입, 수정, 삭제하는 데 사용
    - SELECT, INSERT, DELETE, UPDATE
- 데이터 제어어(DCL, Data Control Language)
    - 데이터의 사용 권한을 관리하는 데 사용
    - GRANT, REVOKE, COMMIT, ROLLBACK

## 데이터 정의어(DDL)

### CREATE 문

- create 문은 테이블을 구성하고, 속성과 속성에 관한 제약을 정의하며, 기본키 및 외래키를 정의하는 명령
  ```sql
  CREATE TABLE 테이블이름
  ( {속성이름 데이터타입
      [NULL | NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
    }
      [PRIMARY KEY 속성이름(들)]
      [FOREIGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
        [ON DELETE {CASCADE | SET NULL}]
  )
  ```

- 대문자는 키워드, {} 안의 내용은 반복 가능, []은 선택적 사용 가능, | 는 1개 선택, <>은 해당되는 문법 사항이 있음을 나타낸다.
- NOT NULL: NULL 값을 허용하지 않는다.
- UNIQUE: 유일한 값에 대한 제약
- CHECK: 값에 대한 조건을 부여할 때
- PRIMARY KEY, FOREIGN KEY: 각각 기본키, 외래키 지정
- ON DELETE: 투플의 삭제 시 외래키 속성에 대한 동작
    - 옵션: CASCADE, SET, NULL, RESTRICT(default: NO ACTION)
        
        
        | 명령어 | 의미 |
        | --- | --- |
        | RESTRICTED | 자식 릴레이션에서 참조하고 있을 경우 부모 릴레이션의 삭제 작업을 거부함 |
        | CASCADE | 자식 릴레이션의 관련 투플을 같이 삭제 |
        | DEFAULT | 자식 릴레이션의 관련 투플을 미리 설정해둔 값으로 변경 |
        | NULL | 자식 릴레이션의 관련 투플을 NULL 값으로 설정함(NULL 값을 허가한 경우) |
- 예) NewBook 테이블 생성, 정수형은 INTEGER, 문자형은 VARCHAR
    
    ```sql
    CREATE TABLE NewBook (
    	bookid INTEGER,
    	bookname VARCHAR(20),
    	publisher VARCHAR(20),
    	price INTEGER);
    ```
    

**✅ 문자형 데이터 타입 - CHAR, VARCHAR**

- CHAR(n)은 n바이트를 가진 문자형타입
    - 저장되는 문자의 길이가 n보다 작으면 나머지는 공백으로 채워서 저장
- VARCHAR(n) 타입은 마찬가지로 n바이트를 가진 문자형 타입이지만 저장되는 문자의 길이만큼만 기억장소를 차지
- 주의점
    - CHAR(n)에 저장된 값과 VARCHAR(n)에 저장된 값이 비록 같은지라도 CHAR(n)은 공백을 채운 문자열이기 때문에 동등 비교 시 실패할 수 있음.

**PK(기본키) 생성 방법**

```sql
CREATE TABLE NewBook (
	bookid INTEGER,
	bookname VARCHAR(20),
	publisher VARCHAR(20),
	price INTEGER,
	PRIMARY KEY (bookid));
-------------------------------------------
CREATE TABLE NewBook (
	bookid INTEGER PRIMARY KEY,
	bookname VARCHAR(20),
	publisher VARCHAR(20),
	price INTEGER);
-------------------------------------------
/* bookid 속성이 없어서 bookname과 publisher가 기본키가 된다면 */
CREATE TABLE NewBook (
	bookname VARCHAR(20),
	publisher VARCHAR(20),
	price INTEGER,
	PRIMARY KEY (bookname, publisher));
```

**복잡한 제약사항 추가**

- 예) bookname은 NULL 값을 가질 수 없고, publisher는 같은 값이 있으면 안 된다. price에 값이 입력되지 않을 경우 기본값 10000을 저장한다. 또 가격은 최소 1,000원 이상으로 한다.
    
    ```sql
    CREATE TABLE NewBook (
    	bookname VARCHAR(20) NOT NULL,
    	publisher VARCHAR(20) UNIQUE,
    	price INTEGER DEFAULT 10000 CHECK(price >= 1000),
    	PRIMARY KEY (bookname, publisher));
    ```
    

**FK(외래키) 생성 방법**

- 주의할 점
    - 반드시 참조되는 테이블(부모 릴레이션)이 존재해야 하며 참조되는 테이블의 기본키여야 한다.

```sql
CREATE TABLE NewOrders (
	orderid INTEGER,
	custid INTEGER,
	bookid INTEGER NOT NULL,
	saleprice INTEGER,
	orderdate DATE,
	PRIMARY KEY(orderid),
	FOREIGN KEY(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE);
```

**데이터 타입 종류**


| 데이터 타입 | 설명 | ANSI SQL 표준 타입 |
| --- | --- | --- |
| INTEGER<br> INT | 4바이트 정수형을 저장한다. | INTEGER, INT <br>SMALLINT |
| NUMERIC(m, d)<br> DECIMAL(m, d) | 전체 자릿수 m, 소수점이하 자릿수 d를 가진 숫자형을 저장한다. | DECIMAL(p, s) <br>NUMERIC[(p, s)] |
| CHAR(n) | 문자형 고정길이, 문자를 저장하고 남은 공간은 공백 로 채운다. | CHARACTER(n) <br>CHAR(n) |
| VARCHAR(n) | 문자형 가변길이를 저장한다. | CHARACTER VARYING(n) |
| DATE | 날짜형, 연도, 월, 날, 시간을 저장한다. |  |

### ALTER 문

- 생성된 테이블의 속성과 속성에 관한 제약을 변경
- 기본키 및 외래키를 변경

```sql
ALTER TABLE 테이블이름
	[ADD 속성이름 데이터타입]
	[DROP COLUMN 속성이름]
	[ALTER COLUMN 속성이름 데이터타입]
	[ALTER COLUMN 속성이름 [NULL | NOT NULL]
	[ADD PRIMARY KEY(속성이름)]
	[[ADD | DROP] 제약이름];
```

- ALTER 문에서 ADD, DROP은 속성을 추가하거나 제거할 때 사용하고, MODIFY는 속성을 변경할 때 사용한다.
- 기본키로 변경하는 경우 NOT NULL 속성만 가능하다.
    
    ```sql
    ALTER TABLE NewBook ADD PRIMARY KEY(bookid);
    ```
    

### DROP 문

- 테이블을 삭제하는 명령어
- 삭제하려는 테이블의 기본키를 다른 테이블에서 참조 중이라면 참조하고 있는 테이블부터 삭제해야한다.

```sql
DROP TABLE 테이블이름;
```


## 데이터 조작어(DML)-검색

### SELECT 문법

```sql
SELECT 
	[ALL | DISTINCT] 속성이름(들)
	[테이블 이름.]{* | 속성이름 [[AS] 속성이름별칭]}
[FROM 
	{테이블이름 [AS 테이블이름별칭]
	[INNER JOIN | LEFT [OUTER] JOIN | RIGHT [OUTER] JOIN
	{테이블이름[ON 검색 조건]}
	| FULL [OUTER] JOIN {테이블이름}]]
[WHERE 검색조건(들)]
[GROUP BY {속성이름, [..., n]}]
[HAVING 검색조건(들)]
[질의 UNION 질의 | 질의 UNION ALL 질의]
[ORDER BY {속성이름 [ASC | DESC], [..., n]}]
-----------------------------------------------------------------------------
[]: 대괄호 안의 SQL 예약어들은 선택적으로 사용한다.
{}: 중괄호 안의 SQL 예약어들은 필수적으로 사용한다.
| : 선택 가능한 문법들 중 한 개를 사용할 수 있다.
```

### **SELECT/FROM**

- FROM 뒤에는 검색하려는 테이블이 나온다.
- `*`(asterisk)를 사용하면 모든 열을 나타낼 수 있다.
    
    ```sql
    SELECT *
    FROM Book;
    ```
    
- 중복을 제거하고 싶으면 DISTINCT 키워드를 사용한다.
    
    ```sql
    SELECT DISTINCT publiser
    FROM Book;
    ```
    

### **WHERE 조건**

- WHERE 절에 조건으로 사용할 수 있는 술어
    
    
    | 술어 | 연산자 | 사용 예 |
    | --- | --- | --- |
    | 비교 | =, <>, <, <=, >, >= | price < 20000 |
    | 범위 | BETWEEN | price BETWEEN 10000 AND 20000 |
    | 집합 | IN, NOT IN | price IN (10000, 20000, 30000) |
    | 패턴 | LIKE | bookname LIKE '축구의 역사’ |
    | NULL | IS NULL, IS NOT NULL | price IS NULL |
    | 복합조건 | AND, OR, NOT | (price < 20000) AND (bookname LIKE '축구의 역사') |
- 와일드 문자의 종류
    
    
    | 와일드 문자 | 의미 | 사용 예 |
    | --- | --- | --- |
    | + | 문자열을 연결 | ‘골프’ + ‘바이블’ = ‘골프 바이블’ |
    | % | 0개 이상의 문자열과 일치 | ‘%축구%’: 축구를 포함하는 문자열 |
    | [] | 1개의 문자열과 일치 | ‘[TO-5]%’: 0-5 사이 숫자로 시작하는 문자열 |
    | [^] | 1개의 문자열과 불일치 | ‘[^0-5]%’: 0-5 사이 숫자로 시작하지 않는 문자열 |
    | _ | 특정 위치의 1개의 문자와 일치 | ‘_구%’: 두 번째 위치에 '구’가 들어가는 문자열 |

### **ORDER BY**

- SQL 문의 실행 결과를 특정 순서대로 출력
- 예시
    
    ```sql
    SELECT *
    FROM Book
    ORDER BY price, bookname;
    ```
    
- 정렬의 기본은 오름차순이므로 내림차순으로 정렬하려면 열 이름 다음에 DESC 키워드 사용
    
    ```sql
    SELECT *
    FROM Book
    ORDER BY price DESC, publisher ASC;
    ```
    

### GROUP BY와 집계 함수

- 집계를 하기 위한 문법 GROUP BY
- 구체적인 집계 내용은 집계 함수 사용

**집계 함수**

- 집계함수는 여러 개 혼합하여 쓸 수 있다.
- WHERE 문과 같이 사용하면 더 유용하다.
- 집계 함수 종류
    
    
    | 집계 함수 | 문법 | 사용 예 |
    | --- | --- | --- |
    | SUM | SUM (ALL I DISTINCT] 속성이름) | SUM(price) |
    | AVG | AVG([ALL | DISTINCT] 속성이름) | AVG(price) |
    | COUNT | COUNT({[[ALL | DISTINCT] 속성이름] | * }) | COUNT(*) |
    | MAX | MAX(ALL | DISTINCT] 속성이름) | MAX(price) |
    | MIN | MIN(ALL | DISTINCT] 속성이름) | MIN(price) |

**GROUP BY**

- SQL 문에서 GROUP BY 절을 사용하면 속성 값이 같은 값끼리 그룹을 만들 수 있다.
- 예) 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오
    
    ```sql
    SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액
    FROM Orders
    GROUP BY custid;
    ```
    
- HAVING 절은 GROUP BY 절의 결과 나타나는 그룹을 제한하는 역할을 한다.
- 예) 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구하시오.
    
    ```sql
    SELECT custid, COUNT(*) AS 도서수량
    FROM Orders
    WHERE saleprice >= 8000
    GROUP BY custid
    HAVING count(*) >= 2;
    ```
    

- GROUP BY와 HAVING 절의 문법과 주의사항
    
    
    | 문법 | 주의 사항 |
    | --- | --- |
    | GROUP BY<속성> | GROUP BY로 투플을 그룹으로 묶은 후 SELECT 절에는 GROUP BY에서 사용한 <속성>과 집계 함수만 나올 수 있다. |
    | HAVING<검색조건> | WHERE 절과 HAVING 절이 같이 포함된 SQL 문은 검색조건이 모호해질 수 있다. HAVING 절은 
    1. 반드시 GROUP BY 절과 같이 작성해야 하고,
    2. WHERE 절보다 뒤에 나와야 한다.
    3. <검색조건>에는 SUM, AVG, MAX, MIN, COUNT와 같은 집계함수가 와야 한다. |
 
    
### SELECT문 실행 순서 
```sql
SELECT custid, COUNT(*) AS 도서수량    (5)
FROM Orders                          (1)
WHERE saleprice > 8000               (2)
GROUP BY custid                      (3)
HAVING count(*) > 1                  (4)
ORDER BY custid;                     (6)
```

### 두 개 이상 테이블에서 SQL 질의

**조인(Join)**

- 조인은 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는 연산
- 동등조인 예시
- 예) 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
  
  ```sql
  SELECT name, saleprice
  FROM Customer, Orders
  WHERE Customer.custid=Orders.custid;
  ```
  
- 예) 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오
  
  ```sql
  SELECT name, SUM(saleprice)
  FROM Customer, Orders
  WHERE Customer.custid=Orders.custid
  GROUP BY Customer.name
  ORDER BY Customer.name**;**
  ```
  
- 예) 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
  
  ```sql
  SELECT Customer.name, Orders.bookname
  FROM Customer, Orders, Book
  WHERE Customer.custid=Orders.custid AND Orders.bookid=Book.booid
  ```
  
- 외부조인 예시
- 예) 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오
  
  ```sql
  SELECT Customer.name, saleprice
  FROM Customer LEFT OUTER JOIN Orders
    ON Customer.custid=Orders.custid;
  ```
  

- 조인 문법
  - 일반적인 조인
  - SQL 문에서는 주로 동등조인을 사용한다. 두 가지 문법 중 하나를 사용할 수 있다.
      
      ```sql
      SELECT <속성들>
      FROM 테이블1, 테이블2
      WHERE <조인조건> AND <검색조건>
      ```
      
      ```sql
      SELECT <속성들>
      FROM 테이블1 INNER JOIN 테이블2 ON <조인조건>
      WHERE <검색 조건>
      ```
      
  - 외부조인
  - 외부조인은 FROM 절에 조인 종류를 적고 ON을 이용하여 조인조건을 명시한다.
      
      ```sql
      SELECT <속성들>
      FROM 테이블1 {LEFT | RIGHT | FULL [OUTER]}
        JOIN 테이블2 ON <조인조건>
      WHERE <검색조건>
      ```
        

**부속질의**

- SELECT 문의 WHERE 절에 또 다른 테이블 결과를 이용하기 위해 다시 SELECT 문을 괄호로 묶는 것
- 결과는 단일행-단일열(1 x 1), 다중행-단일열(n x 1), 단일행-다중열(1 x n), 다중행-다중열(n x n)
- 예) 가장 비싼 도서의 이름을 보이시오.
    
    ```sql
    SELECT bookname
    FROM Book
    WHERE price = (SELECT MAX(price) FROM Book);
    ```
    
- 부속질의 간에는 상하 관계가 있으며, 실행 순서는 하위 부속질의를 먼저 실행하고 그 결과를 이용해 상위 부속질의를 실행한다.
- 반면, 상관 부속질의는 상위 부속질의의 투플을 이용하여 하위 부속질의를 계산한다.
- 즉, 상위 부속질의와 하위 부속질의는 의존적이다.
- 예) 대한 미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
    
    ```sql
    SELECT name
    FROM Customer
    WHERE custid IN(SELECT custid
            FROM Orders
            WHERE bookid IN(SELECT bookid
                        FROM Book
                        WHERE publisher='대한미디어'));
    ```
    

> 투플변수
테이블 이름이 길 때 테이블의 별칭을 붙여서 사용하는 것, FROM 절의 테이블 이름 뒤에 표기
ex)
…
FROM Book b1
…
> 

조인은 부속질의가 할 수 있는 모든 것을 할 수 있기 때문에, 한 개의 테이블에서만 결과를 얻는 여러 테이블 질의는 조인보다 부속질의가 편하다.

**집합 연산**

- 예) 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오.
    
    ```sql
    SELECT name
    FROM Customer
    WHERE address LIKE '대한민국%'
    UNION
    SELECT name
    FROM Customer
    WHERE custid IN (SELECT custid FROM Orders);
    ```
    
    - 이 때, 중복을 포함하고 싶다면 UNION ALL을 대신 사용하면 된다.

**EXISTS**

- 상관 부속질의문 형식
- 원래 단어에서 의미하는 것과 같이 조건에 맞는 투플이 존재하면 결과에 포함시킨다.
- 예) 주문이 있는 고객의 이름과 주소를 보이시오.
  ```sql
  SELECT name, address
  FROM Customer cs
  WHERE EXISTS(SELECT *
              FROM Orders od
              WHERE cs.custid=od.custid);
  ```


## 데이터 조작어(DML)-삽입, 수정, 삭제

### INSERT 문

- 테이블에 새로운 투플을 삽입하는 명령

```sql
INSERT INTO 테이블이름[(속성리스트)]
	VALUES (값리스트);
```

- 속성 리스트는 생략 가능하다. 대신 입력 순서는 속성의 순서와 일치해야한다.
- 속성 리스트를 생략하지 않은 경우에는  순서가 바뀌어도 된다.(속성에 맞는 값끼리만 맞추면 된다.)

```sql
INSERT INTO Book (bookid, bookname, publisher, price)
	VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
---------------------------------------------------------
INSERT INTO Book
	VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
```

### UPDATE 문

- 특정 속성 값을 수정하는 명령

```sql
UPDATE 테이블이름
SET 속성이름1 = 값1 [, 속성이름1 = 값2, ...]
[WHERE <검색조건>];
```

- 예) Book 테이블에서 14번 ‘스포츠 의학’의 출판사를 imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오
    
    ```sql
    UPDATE Book
    SET publisher = (SELECT publisher
    								 FROM imported_book
    								 WHERE bookid = '21')
    WHERE bookid = '14';
    ```
    
- 주의사항
    - UPDATE 문에서 여러 속성 값을 한꺼번에 수정하는 작업은 가능하나 잘못 사용하면 위험하다.

### DELETE 문

- 기존 투플을 삭제하는 명령

```sql
DELETE FROM 테이블이름
[WHERE 검색조건];
```

- WHERE 절을 빼면 모든 투플 삭제


## 데이터 제어어(DCL)

### GRANT 명령어

- 사용자에게 권한을 부여하기 위한 명령어

```sql
-- 사용자 권한 부여 명령어
GRANT ALL PRIVILEGES ON [dbname.table_name] TO [user@host] IDENTIFIED BY 'my_password';
 
 
-- 예제 (호스트 : 로컬호스트)
GRANT ALL PRIVILEGES ON testDB.testTable TO myuser@localhost IDENTIFIED BY 'testPassword';
 
-- 예제 (호스트 : 원격 접속)
GRANT ALL PRIVILEGES ON testDB.testTable TO myuser@'%' IDENTIFIED BY 'testPassword';
 
-- 예제 (호스트 : 아이피)
GRANT ALL PRIVILEGES ON testDB.testTable TO myuse@192.168.0.100 IDENTIFIED BY 'testPassword';
```

GRANT 명령어 이후 설정한 권한을 적용해야 합니다.

```sql
-- 설정한 권한 적용 명령어
FLUSH PRIVILEGES;
```

### REVOKE 명령어

- REVOKE 명령어는 GRANT 명령어로 적용한 권한을 해제해주는 명령어

```sql
-- 권한 해제 명령어(INSERT, UPDATE, CREATE 권한 해제)
REVOKE insert, update, create ON [dbname.table_name] TO [user@host];
 
-- 권한 해제 명령어(전체 권한 해제)
REVOKE ALL ON [dbname.table_name] TO [user@host];
```

- 해제한 권한이 잘 적용되었는지 확인해보고자 한다면 다음 명령을 사용

  ```sql
  -- 권한 확인 명령어
  SHOW GRANTS FOR [user@host];
  ```

### COMMIT 명령어

- 작업한 결과를 물리적 디스크로 저장하고, 조작 작업이 정상적으로 완료되었음을 관리자에게 알려주는 명령어

- 이 명령어는 INSERT, UPDATE, DELETE 등의 작업 내용에 대해 데이터가 물리 디스크로 완전히 업데이트되며, 모든 사용자가 변경한 데이터의 결과를 볼 수 있게 된다.

```sql
-- 이전 까지의 작업을 완전 저장하는 명령어
COMMIT;
```

### ROLLBACK 명령어

- 작업했던 내용을 원래의 상태로 복구하기 위한 명령
-  INSERT, UPDATE, DELETE 와 같은 트랜잭션의 작업 내용을 취소할 수 있다.

> 주의할 점!💡
>
> COMMIT 명령어를 사용하기 이전의 상태만 ROLLBACK이 가능하다.
> COMMIT을 하게 되면, 물리디스크에 직접 저장하고 알리는 기능이므로, 이미 물리적으로는 이전의 상태가 저장되어 있지 않다는 의미한다.

```sql
-- 이전 까지의 작업을 취소하는 명령어
ROLLBACK;
```

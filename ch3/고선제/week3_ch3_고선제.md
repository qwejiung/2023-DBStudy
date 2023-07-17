# 01 SQL학습을 위한 준비

마당서점의 데이터베이스를 통해 SQL의 개념과 주요 명령어를 살펴보자.

### 1. 마당서점의 데이터베이스

- 마당서점의 데이터베이스는 도서(Book), 고객(Customer), 주문(Orders)에 관한 데이터를 저장하는 3개의 테이블로 구성되어 있다.

  - 테이블이란?
    - 2장에서 관계 데이터베이스의 릴레이션
    - 행과 열로 이루어진 2차원

- Book테이블
  - 속성 : bookid(도서번호), bookname(도서이름), publisher(출판사), price(정가)
  - 기본키 : bookid
- Customer테이블
  - 속성 : custid(고객번호), name(이름), address(주소), phone(전화번호)
  - 기본키 : custid
- Orders 테이블
  - 속성 : orderid(주문번호), custid(고객번호), bookid(도서번호), saleprice(판매가격), orderdate(주문날짜)
  - 기본키 : (bookid, custid)

### 2. 마당서점 데이터베이스의 사용자들

- 프로그래머는 사용자가 원하는 정보가 무엇인지 파악하여 SQL을 다뤄야한다.

### 3. MySQL 샘플 데이터 설치

- MySQL : 오픈소스(open source) 관계형 DBMS이다.
- MySQL은 대용량 웹 사이트에서 많이 사용되고 있으며 구글, 페이스북, 트위터, 유튜브 등에서도 사용되고 있다.
- MySQL은 GUI 방식인 Workbench와 명령어 방식인 Command Line방식으로 접속 가능하다.

| 기능              | 명령어                      | 사용 예                                 |
| ----------------- | --------------------------- | --------------------------------------- |
| MySQL접속         | mysql -u [username] -p;     | 사용자가 username에 접속한다            |
| 데이터베이스 선택 | use [database];             | database를 선택한다.                    |
| 데이터베이스 보기 | show database               | database에 어떤 것들이 있는지 보여준다. |
| 데이터베이스 생성 | create database [database]; | database를 생성한다.                    |
| 테이블 보기       | show tables;                | database에 있는 테이블을 보여준다.      |
| 종료              | exit;                       | 명령창을 종료한다.                      |

→ [cd 경로 주소]로 cmd 경로를 바꿀 수 있다.

# 2. SQL 개요

- SQL과 일반 프로그래밍 언어의 차이점

| 구분   | SQL                                          | 일반 프로그래밍 언어    |
| ------ | -------------------------------------------- | ----------------------- |
| 용도   | 데이터베이스에서 데이터를 추출하여 문제 해결 | 모든 문제해결           |
| 입출력 | 입력은 테이블, 출력도 테이블                 | 모든 형태의 입출력 가능 |
| 번역   | DBMS                                         | 컴파일러                |
| 문법   | SELECT \* FROM Book;                         | int main() {…}          |

- SQL은 기능에 따라 3가지로 나뉨.
  - 데이터 정의어(DDL - Data Definition Language) : 테이블이나 관계의 구조를 생성하는 데 사용하며 CREATE, ALTER, DROP문 등이 있다.
  - 데이터 조작어(DML - Data Manipulation Language) :테이블에 데이터를 검색, 삽입, 수정, 삭제하는 데 사용하며 SELECT, INSERT, DELETE, UPDATE 문 등이 있다. 여기서 SELECT 문은 특별히 질의어(query)라고 부른다.
  - 데이터 제어어(DCL - Data Control Language) : 데이터의 사용 권한을 관리하는 데 사용하며 GRANT, REVOKE 문 등이 있다.

SELECT : 질의 결과 추출되는 속성 리스트를 열거한다.

FROM : 질의에 어느 테이블이 사용되는지 열거한다.

WHERE : 질의의 조건을 작성한다.

EX) 김연아 고객의 전화번호를 찾으시오

SELECT phone

FROM Customer

WHERE name =’김연아’;

- SQL문은 실행 순서가 없는 비절차적인(non procedural)언어이다.
  - (1)FROM절에 있는 테이블을 가져와 (2)WHERE절 조건에 의해 투플을 선택한 다음 (3)SELECT절에 있는 속성들을 결과로 출력

# 3. 데이터 조작어 -검색

```sql
SELECT 속성이름들
FROM 테이블이름들
[WHERE 검색조건들]
[GROUP BY 속성이름]
[HAVING 검색조건들]
[ORDER BY 속성이름]
------------------------------
[] : 대괄호 안의 SQL 예약어들은 선택적으로 사용가능하다.
```

### 1. SELECT문

- 속성을 선택한다.
- 새로 만드는 테이블의 열 순서를 결정한다.
- \*(asterisk)는 모든 열(속성)을 나타낸다.
- 속성 값이 중복될 수 있는데, 중복을 제거하고 싶으면 DISTINCT라는 키워드를 사용한다
  - SELECT DISTINCT publisher

### 2. WHERE 조건

- WHERE 절에 조건으로 사용할 수 있는 술어

| 술어     | 연산자               | 사용 예                                        |
| -------- | -------------------- | ---------------------------------------------- |
| 비교     | =,<>, ≤, >, ≥        | price <20000                                   |
| 범위     | BETWEEN              | price BETWEEN 10000 AND 20000                  |
| 집합     | IN, NOT IN           | price IN(10000, 20000, 30000)                  |
| 패턴     | LIKE                 | bookname LIKE ‘축구의 역사’                    |
| NULL     | IS NULL, IS NOT NULL | price is NULL                                  |
| 복합조건 | AND, OR, NOT         | (price<20000) AND (bookname LIKE ‘축구의 역사’ |

- 패턴
  - ` ` 를 사용해야함.
  - 축구가 포함된 도서를 찾고 싶다면 와일드 문자(%)를 사용
    - WHERE bookname LIKE `%축구%`;
  - 와일드 문자(\_)는 특정 위치에 한 문자만 대신할 때 사용
    - EX) 도서이름의 왼쪽 두번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오
    - WHERE bookname LIKE `_구%`
  - 와일드 문자의 종류

| 와일드 문자 | 의미                          | 사용 예                                         |
| ----------- | ----------------------------- | ----------------------------------------------- |
| +           | 문자열을 연결                 | ‘골프’+’바이블’ : 골프 바이블                   |
| %           | 0개 이상의 문자열과 일치      | %축구% : 축구를 포함하는 문자열                 |
| []          | 1개의 문자와 일치             | ‘[0-5]%’ :0-5사이 숫자로 시작하는 문자열        |
| [^]         | 1개의 문자와 불일치           | ‘[^0-5]%’ :0-5사이 숫자로 시작하지 않는 문자열  |
| \_          | 특정 위치의 1개의 문자와 일치 | ‘\_구%’ : 두 번째 위치에 ‘구’가 들어가는 문자열 |

### 3. ORDER BY \_ 도서를 이름순으로 보고 싶다

- 정렬
  - 내림차순 (DESC) , 오름차순 (ASC)
  - EX) 도서를 가격의 내림차순으로 검색하시오, 만약 가격이 같다면 출판사의 오름차순으로 출력하시오
    - ORDER BY price DESC, publisher ASC;

### 4. GROUP BY

- 집계 함수

  - SUM, AVG, MIN, MAX, COUNT
  - SELECT문에 사용한다.

- GROUP BY
  - GROUP BY 절을 사용하여 속성 값이 같은 값끼리 그룹을 만들 수 있다.
- HAVING
  - GROUP BY절의 결과 나타나는 그룹을 제한하는 역할을 한다.

→ GROUP BY로 투플을 그룹으로 묶은 후 집계 함수만 나올 수 있다.

→ HAVING절은 WHERE절 뒤에 나와야 한다.

### 5. 조인

- 동등조인
  - 동등조건에 의해 테이블을 조인하는 것.
  - 조인이라고 하면 대부분 동등조인을 말함
- 외부조인(outer join)
  - ex) 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
  - FROM Customer LEFT OUTER JOIN Orders ON Customer.custid =Orders.custid;
  - LEFT OUTER JOIN…. ON
  - RIGHT OUTER JOIN ,,,, ON
  - FULL OUTER JOIN … ON
- 셀프 조인 (Self join)

  - 하나의 테이블(자신)을 대상으로 조인하는 것을 말한다.

- 부속 질의
  - SELECT 문의 WHERE절에 또 다른 테이블 결과를 이용하기 위해 다시 SELECT문을 괄호로 묶는 것
  - SQL문의 결과(테이블)
    - 단일행 - 단일열
    - 다중행 - 단일열
    - 단일행 - 다중열
    - 다중행 - 다중열
  - 다중행-단일열로 여러 개의 값을 반환하면 IN키워드를 사용하면 된다.
  - 쿼리를 실행할 때에는 부속질의부터 실행한다.

### 6. 집합 연산

- 합집합을 UNION을 이용하여 나타낸다.
- MySQL은 다른 DBMS와 달리 MINUS, INTERSECT 집합 연산이 없다.
- MINUS 연산은 NOT IN, INTERSECT연산은 IN 연산자를 이용하여 구현한다.

### 7. EXISTS

- EXISTS는 상관 부속질의문 형식
- 조건에 맞는 투플이 존재하면 결과에 포함시킨다. 어떤 행이 조건에 만족하면 참이다.
- 반대로 NOT EXISTS는 부속질의문의 모든 행이 조건에 만족하지 않을 때만 참이다.

# 4. 데이터 정의어

- 데이터를 저장하려면 먼저 데이터를 저장할 테이블의 구조를 만들어야함.
- SQL 정의어(DDL, Data Definition Language)
  - 테이블의 구조를 만드는 CREATE 문
  - 구조를 변경하는 ALTER 문
  - 구조를 삭제하는 DROP 문

### 1. CREATE 문

- CREATE 문 구조

```sql
CREATE TABLE 테이블 이름
( {속성이름 데이터타입
     [NULL | NOT NULL | UNIQUE | DEFAULT 기본값 | CHECK 체크조건]
   }
    [PRIMARY KEY 속성이름(들)]
    [FOREIGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
                     [ON DELECTE {CASCADE | SET NULL}]
)
```

- 문법에서 대문자는 키워드, { }안의 내용은 반복 가능, [ ]은 선택적으로 사용, |는 1개 선택, < >은 해당되는 문법 사항이 있음을 나타낸다.
- NOT NULL :NULL 값을 허용하지 않은 제약
- UNIQUE : 유일한 값에 대한 제약
- DEFALUT : 기본값 설정
- CHECK : 값에 대한 조건 부여
- PRIMARY KEY : 기본키 지정
- FOREIGN KEY : 외래키 지정
- ON DELETE : 투플의 삭제 시 외래키 속성에 대한 동작을 나타낸다.
  - CASCADE
  - SET NULL
  - RESTRICT(명시되지 않으면)

### 2. ALTER 문

- ALTER문은 생성된 테이블의 속성과 속성에 관한 제약을 변경하며, 기본키 및 외래키를 변경한다.

```sql
ALGER TABLE 테이블이름
      [ADD 속성이름 데이터타입]
      [DROP COLUMN 속성이름]
      [MODIFY 속성이름 데이터타입]
      [MODIFY 속성이름 [NULL | NOT NULL]]
      [ADD PRIMARY KEY(속성이름)]
      [[ADD|DROP]제약이름]
```

→ 속성을 변경할때에는 MODIFY를 사용한다.

### 3. DROP문

- DROP문은 테이블을 삭제하는 명령이다. DROP문은 테이블의 구조와 데이터를 모두 삭제하므로 사용에 주의해야 한다.
- 데이터만 삭제하려면 DELETE문을 사용한다.

# 5. 데이터 조작어 - 삽입, 수정, 삭제

### 1. INSERT 문

- INSERT문은 테이블에 새로운 투플을 삽입하는 명령

```sql
INSERT INTO 테이블이름[(속성리스트)]
       VALUES (값리스트)
```

- 대량삽입을 할 때 VALUES대신 SELECT문을 이용한다.

### 2. UPDATE

- UPDATE문은 특정 속성 값을 수정하는 명령이다.

```sql
UPDATE 테이블이름
SET 속성이름 1=값 1[, 속성이름 2=값 2, ...]
[WHERE <검색조건>];
```

→ UPDATE 수행 시 실수를 방지하기 위해 기본키 속성을 사용하는 것이 좋다.

### 3. DELETE문

- DELETE문은 테이블에 있는 기존 투플을 삭제하는 명령이다.

```sql
DELETE FROM 테이블이름
[WHERE 겁색조건];
```

## SQL문제 풀면서 몰랐던 개념

- DATE_FORMAT(USED_GOODS_BOARD.CREATED_DATE, '%Y-%m')
  - DATE 나타낼 때 원하는 자릿수 까지.

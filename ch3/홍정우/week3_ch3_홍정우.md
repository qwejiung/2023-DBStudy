# CHAPTER 03 SQL 기초

## 01 SQL 개요

### SQL (Structed Query Language)
- DBMS에게 원하는 내용을 알려주고 결과룰 얻는 데 사용하는 데이터베이스 전용 언어
- DBMS는 SQL 문을 해석하고 프로그램으로 변환하여 실행한 후 결과를 알려준다.
- 데이터베이스의 데이터와 메타 데이터를 생성하고 처리하는 문법만 갖고 있기 때문에 데이터 부속어(data sublanguage)라고 부른다.

### SQL과 일반 프로그래밍 언어의 차이점
| 구분 | SQL | 일반 프로그래밍 언어 |
| --- | --- | --- |
| 용도 | 데이터베이스에서 데이터를 추출하여 문제 해결 | 모든 문제 해결 |
| 입출력 | 입력은 테이블, 출력도 테이블 | 모든 형태의 입출력 가능 |
| 번역 | DBMS | 컴파일러 |
|  |  |  |

SQL은 기능에 따라 데이터 정의어(DDL)와 데이터 조작어(DML), 데이터 제어어(DCL)로 나뉜다.
- 데이터 정의어 : 테이블이나 관계의 구조를 생성하는 데 사용하며 CREATE, ALTER, DROP 문 등이 있다.
- 데이터 조작어 : 테이블에 데이터를 검색, 삽입, 수정하는 데 사용되면 SLECT, INSERT, DELETE, UPDATE 문 등이 있다. <br>SELECT -> 질의어
- 데이터 제어어 : 데이터의 사용 권한을 관리하는 데 사용하며 GRANT, REVOKE 문 등이 있다.

---

## 02 데이터 조작어 - 검색

### SELECT
- SELECT : 질의 결과 추출되는 속성 리스트를 열거한다.
- FROM : 질의에 어느 테이블이 사용되는지 열거한다.
- WHERE : 질의의 조건을 작성한다.

### WHERE 조건
- 비교 : =, <>, <, <=, >, >=
- 범위 : BETWEEN
- 집합 : IN, NOT IN
- 패턴 : LIKE
- NULL : IS NULL, IS NOT NULL
- 복합조건 : AND, OR, NOT

## 집계 함수와 GROUP BY

### 집계 함수
- 테이블의 각 열에 대해 계산을 하는 함수
- SUM, AVG, MIN, MAX, COUNT 5가지
- 뒤에 AS 키워드를 통해 속성 이름의 별칭을 지칭할 수 있다.

### GROUP BY
- 속성 값이 같은 값끼리 그룹을 만들 수 있다.
- HAVING : GROUP BY 절의 결과 나타나는 그룹을 제한하는 역할

## 두 개 이상 테이블에서 SQL 질의

### 조인
- 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는 연산
- **WHERE 절에 두 테이블의 연결 조건을 추가해야함**

ORDER BY : 정렬

### 외부 조인
| 명령 | 문법 | 설명 |
| --- | --- | --- |
| 외부조인 | SELECT <속성들> <br> FROM 테이블 1 {LEFT I RIGHT I FULL [OUTER]} JOIN 테이블2 ON <조인조건> <br> WHERE <검색조건>  | 외부조인은 FROM 절에 조인 종류를 적고 ON을 이용하여 조인조건을 명시한다.|
||||

### 부속질의
- SQL 문 내에 또 다른 SQL문을 작성
- SELECT 문의 WHERE 절에 또 다른 테이블 결과를 이용하기 위해 다시 SELECT 문을 괄호로 묶는 것

### 집합 연산
- 테이블은 투플의 집합이므로 테이블 간의 집합 연산을 이용하여 합집합, 차집합, 교집합을 구할 수 있다.
- UNION : 합집합

### EXISTS
- 상관 부속질의문 형식
- 원래 단어에서 의미하는 것과 같이 조건에 맞는 투플이 존재하면 결과에 포함시킨다.
  
---

## 03 데이터 정의어

### CREATE 문
- 테이블을 구성하고, 속성과 속성에 관한 제약을 정의하며, 기본키 및 외래키를 정의하는 명령

CREATE TABLE 테이블 이름<br>
( {속성이름 데이터타입<br>
    [NULL I NOT NULL I UNIQUE I DEFAULT 기본값 I CHECK 체크조건]<br>
}<br>
    [PRIMARY KEY 속성이름(들)]<br>
    [FOREIGN KEY 속성이름 REFERENCES 테이블(속성이름)]<br>
        [ON DELETE {CASCADE I NULL}]<br>
)

### 데이터 타입 종류
- INTEGER (INT)
- NUMERIC(m, d) <br> DECIMAL(m, d)
- CHAR(n)
- VARCHAR(n)
- DATE


### ALTER 문
- 생성된 테이블의 속성과 속성에 관한 제약을 변경하며, 기본키 및 외래키를 변경한다.
- ALTER _ ADD, DROP, MODIFY ...

---

## 04 데이터 조작어

### INSERT 문
- 테이블에 새로운 투플을 삽입하는 명령
- INSERT INTO 테이블이름[(속성 리스트)] VALUES (값리스트);
- 새로운 투플을 삽입할 때 속성의 이름은 생략할 수 있다. 단, 데이터의 입력 순서는 속성의 순서와 일치해야 한다.

### UPDATE 문
- 특정 속성 값을 수정하는 명령
- UPDATE 테이블 이름 SET 속성이름 1 = 값 ... [WHERE <검색조건>];

### DELETE 문
- 기존 투플을 삭제하는 명령
- DELETE FROM 테이블이름 [WHERE 검색조건];
- 구조는 그대로 두고 데이터만 삭제 (DML)

--- 
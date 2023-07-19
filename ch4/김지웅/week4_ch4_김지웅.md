# CHAPTER 04 SQL 고급
## 내장 함수
### SQL 내장 함수
- SELECT, WHERE, UPDATE 절에서 모두 사용가능

| 구분 |  | 함수 |
| --- | --- | --- |
| 단일행 함수 | 숫자함수 | ABS, CEIL, COS, EXP, FLOOR, LN, LOG, MOD, POWER, RAND, ROUND, SIGN, TRUNCATE |
|  | 문자 함수(문자 반환) | CHAR, CONCAT, LEFT, RIGHT, LOWER, UPPER, LPAD, RPAD, LTRIM, RIRIM, REPLACE, REVERSE, RIGHT, SUBSTR, TRIM |
|  | 문자 함수(숫자 반환) | ASCI, INSTR, LENGTH |
|  | 날짜, 시간 함수 | ADDDATE, CURRENT DATE, DATE, DATEDIFF, DAYNAME, LAST_DAY, SYSDATE, TIME |
|  | 변환 함수 | CAST, CONVERT, DATE_FORMAT, STR_TO_DATE |
|  | 정보 함수 | DATABASE, SCHEMA, ROW_COUNR, USER, VERSION |
|  | NULL 관련 함수 | COALESCE, ISNULL, IFNULL, NULLIF |
| 집계 함수 | | AVG, COUNT, MAX, MIN, STD, STDDEV, SUM |
| 윈도우 함수 (혹은 분석 함수) |  | CUME DIST, DENSE_RANK, FIRST_VALUE, LAST_VALUE, LEAD, NTILE, RANK, ROW _NUMBER |
#### 숫자 함수
| 함수 | 설명 |
| --- | --- |
| ABS(숫자) | 숫자의 절댓값을 계산 |
| CEIL(숫자) | 숫자보다 크거나 같은 최소의 정수 |
| FLOOR(숫자) | 숫자보다 작거나 같은 최소의 정수 |
| ROUND(숫자, m) | 숫자의 반올림, m은 반올림 기준 자릿수 |
| LOG(n, 숫자) | 숫자의 자연로그 값을 반환 |
| POWER(숫자, n) | 숫자의 n제곱 값을 계산 |
| SQRT(숫자) | 숫자의 제곱근 값을 계산(숫자는 양수) |
| SIGN(숫자) | 숫자가 음수면 -1, 0이면 0, 양수면 1 |
- ABS
    ```sql
    SELECT  ABS(-78),ABS(+78);
    ```
- ROUND
    ```sql
    SELECT  ROUND(4.875,1)
    # 4.9
    ```
#### 문자 함수
*** s: 문자열, c: 문자, n: 정수, k: 정수
| 반환 구분 | 함수 | 설명 |
| --- | --- | --- |
| 문자값 반환 함수 | CONCAT(s1, s2) | 두 문자열을 연결 |
|  | LOWER(s) | 대상 문자열을 모두 소문자로 변환 |
|  | LPAD(s, n, c) | 대상 문자열의 왼쪽부터 지정한 자리수까지 지정한 문자로 채움 |
|  | REPLACE(s1, s2, s3) | 대상 문자열의 지정한 문자를 원하는 문자로 변경 |
|  | RPAD(s, n, c) | 대상 문자열의 오른쪽부터 지정한 자리수까지 지정한 문자로 채움 |
|  | SUBSTR(s, n, k) | 대상 문자열의 지정된 자리에서부터 지정된 길이 만큼 잘라서 반환 |
|  | TRIM(c FROM s) | 대상 문자열의 양쪽에서 지정된 문자를 삭제<br>(문자열만 넣으면 기본값으로 공백 제거) |
|  | UPPER(s) | 대상 문자열을 모두 대문자로 변환 |
| 숫자값 반환 함수 | ASCII(c) | 대상 알파벳 문자의 아스키 코드 값을 반환 |
|  | LENGTH(s) | 대상 문자열의 Byte 반환, 알파벳 1byte, 한글 3byte (UTF8) |
|  | CHAR_LENGTH(s) | 문자열의 문자 수를 반환 |
- REPLACE 함수<br>
    **도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오**
    ```sql
    SELECT bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, price
    FROM Book;
    ```
- LENGTH, CHAR_LENGTH 함수
    - LENGTH는 바이트를, CHAR_LENGTH는 문자의 수를 가져온다<br>
    **굿스포츠에서 출판한 도서의 제목과 제목의 문자 수, 바이트 수를 보이시오**
    ```sql
    SELECT bookname '제목', CHAR_LENGTH(bookname) '문자수',
    FROM Book
    WHERE publisher='굿스포츠';
    ```
- SUBSTR 함수
    - 특정 위치부터 지정한 길이만큼 문자열을 반환<br>
    **마당서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오**
    ```sql
    SELECT SUBSTR(name, 1, 1) '성', COUNT(*) '인원'
    FROM Customer
    GROUP BY SUBSTR(name, 1, 1);
    ```
#### 날짜,시간 함수
| 함수 | 반환형 | 설명 |
| --- | --- | --- |
| STR_TO_DATE(string, format) | DATE | 문자열(STRING) 데이터를 날짜형(DATE)으로 반환 |
| DATE_FORMAT(date, format) | STRING | 날짜형(DATE) 데이터를 문자열 (VARCHAR)로 반환 |
| ADDDATE(date, interval) | DATE | DATE 형의 날짜에서 INTERVAL 지정한 시간만큼 더함 |
| DATE(date) | DATE | DATE 형의 날짜 부분을 반환 |
| DATEDIFF(date1, date2) | INTEGER | DATE 형의 date1 - date2 날짜 차이를 반환 |
| SYSDATE | DATE | DBMS 시스템상의 오늘 날짜를 반환하는 함수 |
- 날짜형 데이터는 -와 +를 사용하여 원하는 날 짜로부터 이전과 이후를 계산할 수 있음
```sql
SELECT ADDDATE('2019-07-01',INTERVAL -5 DAY) AFTER5;
       ADDDATE('2019-07-01',INTERVAL 5 DAY) AFTER5;
```
- format의 주요 지정자
| 인자 | 설명 |
| --- | --- |
| %w | 요일 순서(0~6, Sunday=0) |
| %W | 요일(Sunday~Saturday) |
| %a | 요일의 약자(Sun~Sat) |
| %d | 1 달 중 날짜(00~31) |
| %j | 1 년 중 날짜(001~366) |
| %h | 12시간(01~12) |
| %H | 24시간(00~23) |
| %i | 분(0~59) |
| %m | 월 순서(01~12, January=01) |
| %b | 월 이름 약어(Jan~Dec) |
| %M | 월 이름(January~December) |
| %s | 초(0~59) |
| %Y | 4자리 연도 |
| %y | 4자리 연도의 마지막 2 자리 |
- STR_TO_DATE 함수, DATE_FORMAT 함수
    - STR_TO_DATE 함수는 문자형을 날짜형으로, DATE_FORMAT 함수는 날짜형을 문자형으로 변환
    ```sql
    SELECT orderid '주문번호', STR_TO_DATE(orderdate, '%Y-%m-%d') '주문일', custid '고객번호', bookid '도서번호'
    FROM Orders
    WHERE orderdate=DATE_FORMAT('20140707', '%Y%m%d');
    ```
- SYSDATE 함수
    - 현재 날짜와 시간을 반환
    ```sql
    SELECT SYSDATE(), DATE_FORMAT(SYSDATE(), '%Y/%m/%d %M %h:%s') 'SYSDATE_1';
    ```
### NULL 값 처리
- NULL 값이란 아직 지정되지 않은 값
- =,<> 등과 같은 연산자로 비교 못함
**NULL 값에 대한 연산과 집계 함수**
    - ‘NULL+숫자’ 연산의 결과는 NULL이다.
    - 집계 함수를 계산할 때 NULL이 포함된 행은 집계에서 빠진다.
    - 해당되는 행이 하나도 없을 경우 SUM, AVG 함수의 결과는 NULL이 되고, COUNT 함수의 결과는 0이다.
- IS NULL, IS NOT NULL
```sql
SELECT  *
FROM    MYbook
WHERE   price IS NULL
```
- IFNULL 함수
    - NULL 값을 임의의 다른 값으로 변경
### 행번호 출력
- SQL 문 결과로 나오는 행에 번호를 붙이거나 행번호에 따라 결과의 개수를 조절하는 방법
- 변수 이름 앞에 @ 기호를 붙이며 치환문에는 SET과 := 기호를 사용함<br>
**고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오**
```sql
SET @seq:=0;
SELECT (@seq:=@seq+1) '순번', custid, name, phone
FROM Customer
WHERE @seq < 2;
```
## 부속질의
- 조인을 사용할 경우 : Customer 테이블과 Orders 테이블의 고객번호로 조인한 후 필요한 데이터를 추출
- 부속질의를 사용할 경우 : Customer 테이블에서 박지성 고객의 고객번호를 찾고, 찾은 고객번호를 바탕으로 Orders 테이블에서 확인
- 데이터의 형태와 양에 따라 조인을 쓸지 부속질의를 쓸지가 결정됨
| 명칭 | 위치 | 영문 및 동의어 | 설명 |
| --- | --- | --- | --- |
| 스칼라 부속질의 | SELECT 절 | scalar subquery | SELECT 절에서 사용되며 단일 값을 반환하기 때문에 스칼라 부속질의라고 함 |
| 인라인 뷰 | FROM 절 | inline view, table subquery | FROM 절에서 결과를 뷰(view) 형태로 반환하기 때문에 인라인 뷰라고 함 |
| 중첩질의 | WHERE 절 | nested subquery, predicate subquery | WHERE 절에 술어와 같이 사용되며 결과를 한정시키기 위해 사용된다. 상관 혹은 비상관 형태 |
### 스칼라 부속질의 - SELECT 부속질의
- 단일 행, 단일 열의 스칼라 값으로 반환<br>
**마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력)**
```sql
SELECT (SELECT name
    	FROM Customer cs
    	WHERE cs.custid=od.custid) 'name', SUM(saleprice) 'total'
FROM Orders od
GROUP BY od.custid;
```
**bookiud가 1번인 도서의 이름을 수정**
```sql
UPDATE  Orders
SET bname='피겨교본'
WHERE   bookid=1;
```
<br>

**Orders 테이블에 각 주문에 맞는 도서이름을 입력하시오**
    
```sql
ALTER TABLE Orders ADD bname VARCHAR(40);
    
UPDATE Orders
SET bname=(SELECT bookname
		   FROM Book
    	   WHERE Book.bookid=Orders.bookid);
```
### 인라인 뷰-FROM 부속질의
<br>

**고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력)**
 ```sql
SELECT cs.name, SUM(od.saleprice) 'total'
FROM (SELECT custid, name
      FROM Customer
      WHERE custid <= 2) cs, Orders od
WHERE cs.custid=od.custid
GROUP BY cs.name; 
```
### 중첩질의-WHERE 부속질의
| 술어 | 연산자 | 반환 행 | 반환 열 | 상관 |
| --- | --- | --- | --- | --- |
| 비교 | =, >, <. >=, <=, <> | 단일 | 단일 | 가능 |
| 집합 | IN, NOT IN | 다중 | 다중 | 가능 |
| 한정 | ALL, SOME(ANY) | 다중 | 단일 | 가능 |
| 존재 | EXISTS, NOT EXISTS | 다중 | 다중 | 필수 |
- 비교 연산자
    - 부속 질의가 단일 행, 단일 열 반환<br>
    **평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오**
    ```sql
    SELECT orderid, saleprice
    FROM Orders
    WHERE saleprice <= (SELECT AVG(saleprice)
                        FROM Orders);
    ```
- IN,NOT IN
    - 다중 행, 다중 열을 반환<br>
    **대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오**
    ```sql
    SELECT SUM(saleprice) 'total'
    FROM Orders
    WHERE custid IN (SELECT custid
                     FROM Customer
                     WHERE address LIKE '%대한민국%');
    ```
- ALL,SOME(ANY)
    - 비교 연산자와 함께 사용<br>
    **3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 보이시오**
    ```sql
    scalar_expression { 비교연산자 ( =, <>, !=, >, >=, !>, <, <=, !< ) }
    				 { ALL | SOME | ANY } (부속질의)
    ```
## 뷰
- 실제 데이터를 수정하면 저장 용량이 늘어나 가상의 테이블을 만든다
- 편리성 및 재사용성 : 미리 정의된 뷰를 일반 테이블처럼 사용할 수 있기 때문에 편리하다
- 보안성 : 각 사용자별로 보안이 필요한 데이터를 제외하여 선별하여 보여줄 수 있다.
- 독립성 : 논리 데이터베이스의 원본 데이블의 구조가 변해도 응용 프로그램에 영향을 주지 않도록 하는 논리적 독립성을 제공하는 방법
### 뷰의 생성
```sql
CREATE VIEW vw_Customer
AS SELECT *
FROM Customer
WHERE address LIKE '%대한민국%';
```
### 뷰의 수정<br>
**대한민국인 고객을 영국의 주소를 가진 고객으로 변경**
```sql
CREATE OR REPLACE VIEW vw_Customer(custid, name, address)
AS SELECT   custid,name,address
FROM    Customer
WHERE   address LIKE '%영국%'
```
### 뷰의 삭제
```sql
DROP VIEW vw_Customer
```
## 인덱스
### 인덱스와 B-tree
- B-tree
    - 루트노드, 내부노드, 리프노드로 구성된 균형트리
    - 부모 노드는 왼쪽 자식노드보다는 크고 오른쪽 자식노드보다는 작다
- 인덱스의 특징
    - 인덱스는 테이블에서 한 개 이상의 속성을 이용하여 생성
    - 빠른 검색과 함께 효율적인 레코드 접근이 가능
    - 순서대로 정렬된 속성과 데이터의 위치만 보유하므로 테이블보다 작은 공간을 차지
    - 저장된 값들은 테이블의 부분집합이 됨
    - 일반적으로 B-tree 형태의 구조를 가짐
    - 데이터의 수정, 삭제 등의 변경이 발생하면 인덱스의 재구성이 필요
### MYSQL 인덱스
- 클러스터 인덱스
    - 기본적인 인덱스로 테이블 생성 시 기본키를 지정하면 기본 키에 대하여 클러스터 인덱스를 생성
    - 기본키를 지정하지 않으면 먼저 나오는 UNIQUE 속성에 대하여 클러스터 인덱스를 생성
    - 기본키나 UNIQUE 속성이 없는 테이블은 MYSQL이 자체 생성한 행번호를 이용하여 클러스터 인덱스를 생성
- 보조 인덱스
    - 클러스터 인덱스가 아닌 모든 인덱스는 보조 인덱스이며 보조 인덱스의 각 레코드는 보조 인덱스 속성과 기본키 속성 값을 갖고 있음
    - 보조 인덱스를 검색하여 기본키 속성 값을 찾은 다음 클러스터 인덱스로 가서 해당 레코드를 찾음
### 인덱스의 생성
- 인덱스 생성 시 고려사항
    - 인덱스는 WHERE 절에 자주 사용되는 속성이어야 한다
    - 인덱스는 조인에 자주 사용되는 속성이어야 한다
    - 단일 테이블에 인덱스가 많으면 속도가 느려질 수 있다.(테이블 당 4~5개 정도 권장)
    - 속성이 가공되는 경우 사용하지 않는다
    - 속성의 선택도가 낮을 때 유리하다(속성의 모든 값이 다른 경우)
```sql
CREATE INDEX ix_Book ON Book(bookname);
```
### 인덱스의 재구성과 삭제
- Book 테이블의 인덱스를 최적화하시오
 ```sql
ANALYZE TABLE 테이블이름;
```
- 인덱스 ix_Book을 삭제하시오
 ```sql
DROP INDEX ix_Book ON Book;
```


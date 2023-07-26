# Chapter 04 SQL 고급

## 내장 함수

### SQL 내장 함수

- 상수나 속성 이름을 입력 값으로 받아 단일 값을 결과로 반환한다.
- 모든 내장 함수는 최초에 선언될 때 유효한 입력 값을 받아야 한다.
- 선언에 위배된 값이 입력되면 질의는 실행을 중지하고 에러 메시지를 출력

**SQL 내장 함수는 SELECT 절, WHERE 절, UPDATE 절에서 사용 가능**

```sql
SELECT ... 함수명(인자1, 인자2, ...)
FROM 테이블 이름
WHERE ... 열이름=함수명(인자1 인자2, ...);

UPDATE 테이블 이름
SET ... 열이름=함수명(인자1, 인자2, ...);
```

| 구분 |  | 함수 |
| --- | --- | --- |
| **단일행 함수** | 숫자함수 | ABS, CEIL, COS, EXP, FLOOR, LN, LOG, MOD, POWER, RAND, ROUND, SIGN, TRUNCATE |
|  | 문자 함수(문자 반환) | CHAR, CONCAT, LEFT, RIGHT, LOWER, UPPER, LPAD, RPAD, LTRIM, RIRIM, REPLACE, REVERSE, RIGHT, SUBSTR, TRIM |
|  | 문자 함수(숫자 반환) | ASCI, INSTR, LENGTH |
|  | 날짜, 시간 함수 | ADDDATE, CURRENT DATE, DATE, DATEDIFF, DAYNAME, LAST_DAY, SYSDATE, TIME |
|  | 변환 함수 | CAST, CONVERT, DATE_FORMAT, STR_TO_DATE |
|  | 정보 함수 | DATABASE, SCHEMA, ROW_COUNR, USER, VERSION |
|  | NULL 관련 함수 | COALESCE, ISNULL, IFNULL, NULLIF |
| **집계 함수** |  | AVG, COUNT, MAX, MIN, STD, STDDEV, SUM |
| **윈도우 함수** (혹은 분석 함수) |  | CUME DIST, DENSE_RANK, FIRST_VALUE, LAST_VALUE, LEAD, NTILE, RANK, ROW _NUMBER |
- [MySQL 8.0 버전에서 제공하는 내장함수](https://dev.mysql.com/doc/refman/8.0/en/functions.html)

### **숫자 함수**

| 함수 | 설명 |
| --- | --- |
| ABS(숫자) | 숫자의 절댓값을 계산 예) ABS(-4.5) → 4.5 |
| CEIL(숫자) | 숫자보다 크거나 같은 최소의 정수 예) CEL(4.1) → 5 |
| FLOOR(숫자) | 숫자보다 작거나 같은 최소의 정수 예) FLOOR(4.1) → 4 |
| ROUND(숫자, m) | 숫자의 반올림, m은 반올림 기준 자릿수 예) ROUND(5.36, 1) → 5.40 |
| LOG(n, 숫자) | 숫자의 자연로그 값을 반환 예) LOG(10) → 2.30259 |
| POWER(숫자, n) | 숫자의 n제곱 값을 계산 예) POWER(2,3) → 8 |
| SQRT(숫자) | 숫자의 제곱근 값을 계산(숫자는 양수) 예) SORT(9.0) → 3.0 |
| SIGN(숫자) | 숫자가 음수면 -1, 0이면 0, 양수면 1 예) SIGN(3.46) → 1 |

**숫자 함수의 연산**

- 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
    
    ```sql
    SELECT custid '고객번호', ROUND(SUM(saleprice)/COUNT(*), -2) '평균금액'
    FROM Orders
    GROUP BY custid;
    ```
    

### **문자 함수**

- 주로 CHAR나 VARCHAR의 데이터 타입을 대상으로 단일 문자나 문자열을 가공한 결과를 반환
  | 반환 구분 | 함수 | 설명 |
  | --- | --- | --- |
  | 문자값 반환 함수 | CONCAT(s1, s2) | 두 문자열을 연결<br>예) CONCAT (’마당’, ‘서점') → ‘마당 서점’ |
  | s: 문자열 | LOWER(s) | 대상 문자열을 모두 소문자로 변환 <br>예) LOWER(’MR.SCOTTY’) → ‘mr. scott’ |
  | c: 문자 | LPAD(s, n, c) | 대상 문자열의 왼쪽부터 지정한 자리수까지 지정한 문자로 채움 <br>예) LPAD('Page 1', 10, ‘*’) → ‘****Page 1’ |
  | n: 정수 | REPLACE(s1, s2, s3) | 대상 문자열의 지정한 문자를 원하는 문자로 변경 <br>예) REPLACE(’JACK & JUE’, ‘J’, ‘BL') → ‘BLACK & BLUE’ |
  | k: 정수 | RPAD(s, n, c) | 대상 문자열의 오른쪽부터 지정한 자리수까지 지정한 문자로 채움 <br>예) RPAD(’AbC’, 5, ‘*') → ‘AbC**’ |
  |  | SUBSTR(s, n, k) | 대상 문자열의 지정된 자리에서부터 지정된 길이 만큼 잘라서 반환 <br>예) SUBSTR(’ABODEFG’, 3, 4) → 'CDEF’ |
  |  | TRIM(c FROM s) | 대상 문자열의 양쪽에서 지정된 문자를 삭제 (문자열만 넣으면 기본값으로 공백 제거)<br>예) TRIM(’=’ FROM ‘== BROWNING ==’) → ‘BROWNING’ |
  |  | UPPER(s) | 대상 문자열을 모두 대문자로 변환 <br>예) UPPER(’mr. soott’) → ‘MR. SCOTT’ |
  | 숫자값
  반환 함수 | ASCII(c) | 대상 알파벳 문자의 아스키 코드 값을 반환<br>예) ASCII(’D’) → 68 |
  |  | LENGTH(s) | 대상 문자열의 Byte 반환, 알파벳 1byte, 한글 3byte (UTF8)<br>예) LENGTH(’CANDIDE’) → 7 |
  |  | CHAR_LENGTH(s) | 문자열의 문자 수를 반환<br>예) CHAR_LENGTH(’데이터’) → 3 |

**REPLACE 함수**

- 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오.
  ```sql
  SELECT bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, price
  FROM Book;
  ```

**LENGTH, CHAR_LENGTH 함수**

- 굿스포츠에서 출판한 도서의 제목과 제목의 문자 수, 바이트 수를 보이시오.

  ```sql
  SELECT bookname '제목', CHAR_LENGTH(bookname) '문자수',
  FROM Book
  WHERE publisher='굿스포츠';
  ```

**SUBSTR 함수**

- 마당서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.

  ```sql
  SELECT SUBSTR(name, 1, 1) '성', COUNT(*) '인원'
  FROM Customer
  GROUP BY SUBSTR(name, 1, 1);
  ```

### 날짜, 시간 함수

| 함수 | 반환형 | 설명 |
| --- | --- | --- |
| STR_TO_DATE(string, format) | DATE | 문자열(STRING) 데이터를 날짜형(DATE)으로 반환 <br>예)STR_TO_DATE(’2019-02-14', %Y-%m-%d’) → 2019-02-14 |
| DATE_FORMAT(date, format) | STRING | 날짜형(DATE) 데이터를 문자열 (VARCHAR)로 반환 <br>예) DATE FORMAT (’2019-02-14’, ‘%Y-%m-%d’) → ‘2019-02-14’ |
| ADDDATE(date, interval) | DATE | DATE 형의 날짜에서 INTERVAL 지정한 시간만큼 더함 <br>예) ADDDATE(’2019-02-14’, INTERVAL 10 DAY) → 2019-02-24 |
| DATE(date) | DATE | DATE 형의 날짜 부분을 반환 <br>예) DATE(’2003-12-31 01:02:03’); → 2003-12-31 |
| DATEDIFF(date1, date2) | INTEGER | DATE 형의 date1 - date2 날짜 차이를 반환 <br>예) DATEDIFF (’2019-02-14’, ‘2019-02-04’) → 10 |
| SYSDATE | DATE | DBMS 시스템상의 오늘 날짜를 반환하는 함수 <br>예) SYSDATE() → 2019-06-30 21:47:01 | 

- 날짜형 데이터는 ‘-’와 ‘+’를 사용하여 원하는 날짜로부터 이전(-)과 이후(+)를 계산할 수 있다.
    
    ```sql
    SELECT ADDDATE('2023-07-01', INTERVAL -5 DAY) BEFORE5,
    			 ADDDATE('2023-07-01', INTERVAL 5 DAY) AFTER5,
    ```
    
- 마당서점은 주문일로부터 10일 후 매출을 확정한다 각 주문의 확정일자를 구하시오.
    
    ```sql
    SELECT orderid '주문번호', orderdate '주문일', ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
    FROM Orders;
    ```

**format의 주요 지정자(specifier)**

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

**STR_TO_DATE 함수, DATE_FORMAT 함수**

- 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 단, 주문일은 ‘%Y-%m-%d’ 형태로 표시한다.
    
    ```sql
    SELECT orderid '주문번호', STR_TO_DATE(orderdate, '%Y-%m-%d') '주문일', 
    				custid '고객번호', bookid '도서번호'
    FROM Orders
    WHERE orderdate=DATE_FORMAT('20140707', '%Y%m%d');
    ```
    

**SYSDATE 함수**

- DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
    
    ```sql
    SELECT SYSDATE(),
    				DATE_FORMAT(SYSDATE(), '%Y/%m/%d %M %h:%s') 'SYSDATE_1';
    ```
    

### NULL 값 처리

**NULL 값에 대한 연산과 집계 함수**

집계 함수를 사용할 때 NULL 값이 포함된 행에 대하여 다음과 같은 주의가 필요하다.

- ‘NULL+숫자’ 연산의 결과는 NULL이다.
- 집계 함수를 계산할 때 NULL이 포함된 행은 집계에서 빠진다.
- 해당되는 행이 하나도 없을 경우 SUM, AVG 함수의 결과는 NULL이 되고, COUNT 함수의 결과는 0이다.

**NULL 값을 확인하는 방법 - IS NULL, IS NOT NULL**

NULL 값을 찾을 때는 ‘=’ 연산자가 아닌 ‘IS NULL’을 사용하고, NULL이 아닌 값을 찾을 때는 ‘<>’연산자가 안닌 ‘IS NOT NULL’을 사용한다.

**IFNULL 함수**

- IFNULL 함수는 NULL 값을 다른 값으로 대치하여 연산하거나 다른 값으로 출력하는 함수이다.
- IFNULL 함수를 사용하면 NULL 값을 임의의 다른 값으로 변경할 수 있다.

  ```sql
  IFNULL(속성, 값) /* 속성 값이 NULL이면 '값'으로 대치한다. */
  ```

- 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시하시오.
    
    ```sql
    SELECT name '이름', IFNULL(phone, '연락처없음') '전화번호'
    FROM Customer;
    ```
    

### 행번호 출력

- SQL 문 결과로 나오는 행에 번호를 붙이거나 행번호에 따라 결과의 개수를 조절하는 방법
- 변수 이름 앞에 @ 기호를 붙이며 치환문에는 SET과 := 기호를 사용한다.
- 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
    
    ```sql
    SET @seq:=0;
    SELECT (@seq:=@seq+1) '순번', custid, name, phone
    FROM Customer
    WHERE @seq < 2;
    ```
    

## 부속질의

- **조인을 사용할 경우**: Customer 테이블과 Orders 테이블의 고객번호로 조인한 후 필요한 데이터를 추출한다.
- **부속질의를 사용할 경우**: Customer 테이블에서 박지성 고객의 고객번호를 찾고, 찾은 고객번호를 바탕으로 Orders 테이블에서 확인한다.

**부속질의의 종류**

| 명칭 | 위치 | 영문 및 동의어 | 설명 |
| --- | --- | --- | --- |
| 스칼라 부속질의 | SELECT 절 | scalar subquery | SELECT 절에서 사용되며 단일 값을 반환하기 때문에 스칼라 부속질의라고 한다. |
| 인라인 뷰 | FROM 절 | inline view,
table subquery | FROM 절에서 결과를 뷰(view) 형태로 반환하기 때문에 인라인 뷰라고 한다. |
| 중첩질의 | WHERE 절 | nested subquery,
predicate subquery | WHERE 절에 술어와 같이 사용되며 결과를 한정시키기 위해 사용된다. 상관 혹은 비상관 형태다. |

**동작 방식**

- **상관 부속질의**: 주질의의 특정 열 값을 부속질의가 상속받아 부속질의의 질의에 사용하는 형태
- **비상관 부속질의(일반 부속질의)**: 독립된 질의를 수행해서 결과 값을 가져오는 형태이다.

**반환하는 결과의 형태**

부속질의가 단일 행을 반환하느냐 혹은 다중 행을 반환하느냐에 따라 분류할 수 있다.

- **단일행 부속질의**: 부속질의의 결과 하나의 행을 반환하여 주질의에 전달한다. 비교 연산자의 수행이나 스칼라 부속질의 등에서 나타난다.
- **다중행 부속질의**: 부속질의의 결과 여러 개의 행을 반환한다. IN 연산자를 사용하여 여러 행을 처리한다.

### 스칼라 부속질의 -SELECT 부속질의

- SELECT 절에서 사용되는 부속질의
- 부속질의의 결과 값을 단일 행, 단일 열의 스칼라 값으로 반환한다.
- 결과 값이 다중 행이거나 다중 열이라면 DBMS는 그 중 어떠한 행, 어떠한 열을 출력해야 하는지 알 수 없어 에러를 출력한다. 또 결과가 없는 경우에는 NULL 값을 출력한다.
- 스칼라 부속질의는 원칙적으로 스칼라 값이 들어갈 수 있는 모든 곳에 사용 가능하며, 일반적으로 SELECT 문과 UPDATE SET 절에 사용된다.
- 주질의와 부속질의와의 관계는 상관/비상관 모두 가능하다.

- 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력)
    
    ```sql
    SELECT (SELECT name
    				FROM Customer cs
    				WHERE cs.custid=od.custid) 'name', SUM(saleprice) 'total'
    FROM Orders od
    GROUP BY od.custid;
    ```
    
- Orders 테이블에 각 주문에 맞는 도서이름을 입력하시오.
    
    ```sql
    ALTER TABLE Orders ADD bname VARCHAR(40);
    
    UPDATE Orders
    SET bname=(SELECT bookname
    					 FROM Book
    					 WHERE Book.bookid=Orders.bookid);
    ```
    

### **인라인 뷰-FROM 부속질의**

- 인라인 뷰는 FROM 절에서 사용되는 부속질의
- 부속질의 결과 반환되는 데이터는 다중 행, 다중 열이어도 상관없다.
- 가상의 테이블인 뷰 형태로 제공되기 때문에 상관 부속질의로 사용될 수는 없다.(주질의의 특정 열 값을 부속질의가 상속받아 부속질의의 질의에 사용할 수 없다.)
- 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).
    
    ```sql
    SELECT cs.name, SUM(od.saleprice) 'total'
    FROM (SELECT custid, name
    			FROM Customer
    			WHERE custid <= 2) cs,
    			Orders od
    WHERE cs.custid=od.custid
    GROUP BY cs.name; 
    ```
    

### 중첩질의-WHERE 부속질의

- 중첩질의는 WHERE 절에서 사용되는 부속질의
- WHERE 절은 보통 데이터를 선택하는 조건 혹은 술어와 같이 사용된다. (때문에 중첩질의를 술어 부속질의라고도 부른다.)
- 주질의에 사용된 자료 집합의 조건을 WHERE 절에 서술한다.
- 주질의의 자료 집합에서 한 행씩 가져와 부속질의를 수행하며, 연산 결과에 따라 WHERE 절의 조건이 참인지 거짓인지 확인하여 참일 경우 주질의의 해당 행을 출력한다.

**중첩질의 연산자의 종류**

| 술어 | 연산자 | 반환 행 | 반환 열 | 상관 |
| --- | --- | --- | --- | --- |
| 비교 | =, >, <. >=, <=, <> | 단일 | 단일 | 가능 |
| 집합 | IN, NOT IN | 다중 | 다중 | 가능 |
| 한정 | ALL, SOME(ANY) | 다중 | 단일 | 가능 |
| 존재 | EXISTS, NOT EXISTS | 다중 | 다중 | 필수 |

**비교 연산자**

- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
    
    ```sql
    SELECT orderid, saleprice
    FROM Orders
    WHERE saleprice <= (SELECT AVG(saleprice)
                        FROM Orders);
    ```
    

**IN, NOT IN**

- IN 연산자는 주질의의 속성 값이 부속질의에서 제공한 결과 집합에 있는지 확인하는 역할을 한다.
- 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
    
    ```sql
    SELECT SUM(saleprice) 'total'
    FROM Orders
    WHERE custid IN (SELECT custid
                     FROM Customer
                     WHERE address LIKE '%대한민국%');
    ```
    

**ALL, SOME(ANY)**

- ALL, SOME(ANY)는 비교 연산자와 함께 사용된다.
- 연산자 구문구조
    
    ```sql
    scalar_expression { 비교연산자 ( =, <>, !=, >, >=, !>, <, <=, !< ) }
    				 { ALL | SOME | ANY } (부속질의)
    ```
    
- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 보이시오.
    
    ```sql
    SELECT orderid, saleprice
    FROM Orders
    WHERE saleprice > ALL (SELECT saleprice
                           FROM Orders
                           WHERE custid='3');
    /* saleprice 값이 6000, 12000, 13000 일 때, ALL 연산자이므로 13000보다 큰 판매금액을 결과로 출력 */
    ```
    

**EXISTS, NOT EXISTS**

- 데이터의 존재 유무를 확인하는 연산자이다.
- 연산자 구문구조
    
    ```sql
    WHERE [NOT] EXISTS (부속질의)
    ```
    
- EXISTS 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
    
    ```sql
    SELECT SUM(saleprice) 'total'
    FROM Orders od
    WHERE EXISTS (SELECT *
                  FROM Customer cs
                  WHERE address LIKE '%대한민국%' AND cs.custid=od.custid);
    ```
    

## 뷰

- 하나 이상을 테이블을 합하여 만든 가상의 테이블
- 합한다는 말은 앞서 배운 SELECT 문을 통해 얻은 최종 결과를 뜻함.
- 뷰의 장점
    - **편리성 및 재사용성**
    - **보안성**
    - **독립성**

### 뷰의 생성

```sql
CREATE VIEW 뷰이름 [(열이름 [,...n])]
AS SELECT 문
```

- ‘뷰이름’은 생성할 뷰의 이름
- ‘열이름’은 뷰에서 사용할 열의 이름
- 열 이름과 SELECT 문에서 추출하는 속성은 일대일로 대응된다.
- 주소에 ‘대한민국’을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.
    
    ```sql
    CREATE VIEW vw_Customer
    AS SELECT *
    	 FROM Customer
    	 WHERE address LIKE '%대한민국%';
    
    /* 결과 확인 */
    SELECT *
    FROM vw_Customer;
    ```
    

> 뷰는 실제 데이터가 저장되는 게 아니라 뷰의 정의가 DBMS에 저장되는 것이다.
> 

### 뷰의 수정

```sql
CREATE OR REPLACE VIEW 뷰이름 [(열이름 [,...n])]
AS SELECT 문
```

### 뷰의 삭제

```sql
DROP VIEW 뷰이름 [,...n];
```

## 인덱스

- 도서의 색인이나 사전과 같이 데이터를 쉽고 빠르게 찾을 수 있도록 만든 데이터 구조이다.

### 데이터베이스의 물리적 저장

- DBMS가 하드디스크에 데이터를 저장하고 읽어올 때는 근본적인 속도 문제가 발생할 수밖에 없다.
    - 컴퓨터 시스템에서 처리되는 연산 속도는 빠른데, 디스크의 액세스 속도는 느리기 때문이다.
- 디스크는 주기억장치보다 1000배 이상 느리다. 이러한 속도 문제를 줄이기 위해 주기억장치에 DBMS가 사용하는 공간 중 일부를 버퍼 풀로 만들어 사용하는 방법이 있다.
    - DB는 버퍼에 자주 사용하는 데이터를 저장해두며 LRU(Least Recently Used) 알고리즘을 이용하여 사용빈도가 높은 데이터 위주로 저장하고 관리한다.

MySQL InnoDB 엔진 데이터베이스의 파일

| 파일 | 설명 |
| --- | --- |
| 데이터 파일(ibdata) | - 사용자 데이터와 개체를 저장 <br>- 테이블과 인덱스로 구성 <br>- 확장자는 *.ibd |
| 폼파일(frm File) | - 테이블에 대한 각종 정보와 테이블을 구성하는 필드, 데이터 타입에 대한 정보 저장<br>- 데이터베이스 구조 등의 변경사항이 있을 때 자동으로 업데이트 됨 |

### 인덱스와 B-tree

- 인덱스란 자료를 쉽고 빠르게 찾을 수 잇도록 만든 데이터 구조이다.
    - 일반적인 RDBMS의 인덱스는 대부분 B-tree 구조로 되어있다.

**B-tree**

- B-tree : 데이터의 검색 시간을 단축하기 위한 자료구조
    - 루트 노드(root node)
    - 내부노드(internal node)
    - 리프노드(leaf node)
- 루트 노드에서 값을 비교하고 중간 단계인 내부 노드에서 해당 노드를 찾고, 없으면 리프 노드에 도달한다.
- 리프 노드에는 해당 데이터의 저장 위치에 대응하는 rowid(RID, Row IDentify, 테이블의 행에 대한 논리적 위치)를 가지고 있어 찾고자 하는 행을 바로 찾을 수 있다.

**인덱스 특징**

- 인덱스는 테이블에서 한 개 이상의 속성을 이용하여 생성
- 빠른 검색과 함께 효율적인 레코드 접근
- 순서대로 정렬된 속성과 데이터의 위치만 보유하므로 테이블보다 작은 공간을 차지한다.
- 저장된 값들은 테이블의 부분집합이 된다.
- 일반적으로 B-tree 형태의 구조를 가진다.
- 데이터의 수정, 삭제 등의 변경이 발생하면 인덱스의 재구성이 필요

**MySQL 인덱스의 종류**

| 인덱스 명칭 | 설명/ 생성 예 |
| --- | --- |
| 클러스터 인덱스 | - 기본적인 인덱스로 테이블 생성 시 기본키를 지정하면 기본 키에 대하여 클러스터 인덱스를 생성한다.<br>- 기본키를 지정하지 않으면 먼저 나오는 UNIQUE 속성에 대하여 클러스터 인덱스를 생성한다. <br>- 기본키나 UNQUE 속성이 없는 테이블은 MySQL 이 자체 생성한 행번호(Row ID)를 이용하여 클러 스터 인덱스를 생성한다. |
| 보조 인덱스 | - 클러스터 인덱스가 아닌 모든 인덱스는 보조 인덱스이며 보조 인덱스의 각 레코드는 보조 인덱스 속성과 기본키 속성 값을 갖고 있다. <br>- 보조 인덱스를 검색하여 기본키 속성 값을 찾은 다음 클러스터 인덱스로 가서 해당 레코드를 찾는다. |

### 인덱스의 생성

- 의미 없이 인덱스를 생성하면 검색이 더 느려지고 저장 공간만 낭비하게 된다.
- 인덱스 생성 시 고려사항
    - 인덱스는 WHERE 절에 자주 사용되는 속성이어야 한다.
    - 인덱스는 조인에 자주 사용되는 속성이어야 한다.
    - 단일 테이블에 인덱스가 많으면 속도가 느려질 수 있다.(테이블 당 4~5개 정도 권장).
    - 속성이 가공되는 경우 사용하지 않는다.
    - 속성의 선택도가 낮을 때 유리하다(속성의 모든 값이 다른 경우).

- 인덱스 문법
    
    ```sql
    CREATE [UNIQUE] INDEX [인덱스이름]
    ON 테이블이름 (컬럼 [ASC | DESC] [{, 컬럼 [ASC | DESC]} ...])[;]
    ```
    
- Book 테이블의 bookname 열을 대상으로 인덱스 ix_Book을 생성하시오.
    
    ```sql
    CREATE INDEX ix_Book ON Book(bookname);
    ```
    
- 생성된 인덱스 확인 명령어
    
    ```sql
    SHOW INDEX FROM Book;
    ```
    

### 인덱스의 재구성과 삭제

- B-tree 인덱스는 데이터의 수정, 삭제, 삽입이 잦으면 노드의 갱신이 주기적으로 일어나 **단편화(fragmentation) 현상**이 나타난다.
- **단편화**: 삭제된 레코드의 인덱스 값 자리가 비게 되는 상태, 성능 저하로 이어진다.
- 이럴 때 재구성 필요
- 재구성 문법
    
    ```sql
    ANALYZE TABLE 테이블이름;
    ```
    
- Book 테이블의 인덱스를 최적화하시오.
    
    ```sql
    ANALYZE TABLE Book;
    ```
    
- 인덱스 ix_Book을 삭제하시오.
    
    ```sql
    DROP INDEX ix_Book ON Book;
    ```
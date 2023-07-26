# CHAPTER 03 SQL 기초
## SQL 개요
- 데이터 정의어 : 테이블이나 관계의 구조를 생성하는 데 사용
    - CREATE, ALTER, DROP
- 데이터 조작어 : 테이블에 데이터를 검색, 삽입, 수정, 삭제하는데 사용
    - SELECT, INSERT, DELETE, UPDATE
- 데이터 제어어 : 데이터의 사용 권한을 관리하는 데 사용
    - GRANT, REVOKE
## 데이터 조작어 - 검색
### SELECT
- 어떤 테이블에서 어떤 조건을 가진 어떤 속성을 보고싶다 할 때 사용<br/>
*** 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오<br/>
*** SELECT bookid, bookname, publisher, price<br/>FROM Book;<br/>
- WHERE 조건
    - 비교 : =,<>,<,<=,>,>=
    - 범위 : BETWEEN
    - 집합 : IN, NOT IN
    - 패턴 : LIKE
    - NULL : IS NULL, IS NOT NULL
    - 복합조건 : AND, OR, NOT<br/>
*** 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오<br/>
*** SELECT *<br/>FROM Book<br/>WHERE publisher IN('굿스포츠','대한미디어);<br/>
- ORDER_BY<br/>
*** 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
*** SELECT *<br/>FROM Book<br/>ORDER BY price, bookname;
### 집계합수와 GROUP BY
- 집계 함수는 테이블의 각 열에 대해 계산을 하는 함수로 SUM, AVG, MIN, MAX, COUNT 등<br/>
*** 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오<br/>
*** SELECT SUM(saleprice) AS Total,<br/>        AVG(saleprice) AS Average,<br/>     MIN(saleprice) AS Minimum,<br/>     MAAX(saleprice) AS Maximum<br/>FROM Orders;<br/>
- GROUP BY : 속성 값이 같은 값끼리 그룹을 만들 수 있음
- HAVING : GROUP BY 절의 결과 나타나는 그룹을 제한하는 역할<br/>
*** 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.<br/>단, 두 권 이상 구매한 고객만 구하시오.<br/>
*** SELECT custid, COUNT(*) AS 도서수량<br/>FROM Orders<br/>WHERE saleprice >= 8000<br/>GROUP BY custid<br/>HAVING count(*) >= 2;
### 두 개 이상 테이블에서 SQL 질의
- 조인 : 한 테이블의 행을 다른 테이블의 행에 연결하여 두 개 이상의 테이블을 결합하는 연산<br/>
*** 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.<br/>
*** SELECT name,SUM(saleprice)<br/>FROM Customer, Orders<br/>WHERE Customer.custid=Orders.custid<br/>GROUP BY Customer.name<br/>ORDER BY Customer.name;<br/>
-  부속질의 : SQL 문 내에 또 다른 SQL 문을 작성<br/>
*** 가장 비싼 도서의 이름을 보이시오<br/>
*** SELECT bookname<br/>FROM Book<br/>WHERE price = (SELECT MAX(price) FROM Book);<br/>
*** 도서를 구매한 적이 있는 고객의 이름을 검색하시오.<br/>
*** SELECT name<br/>FROM Customer<br/>WHERE custid IN(SELECT custid FROM Orders);<br/>
    - 부속질의는 SELECT 문에 나오는 결과 속성을 FROM 절의 테이블에서만 얻을 수 있음
    - 조인은 조인한 모든 테이블에서 결과 속성을 얻을 수 있음
    - 조인은 부속질의가 할 수 있는 모든 것을 할 수 있음
- 집합 연산<br/>
*** 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오.<br/>
*** SELCET name<br/>FROM Customer<br/>WHERE address LIKE '대한민국%'<br/>UNION<br/>SELECT name<br/>FROM Customer<br/>WHERE custid IN(SELECT custid FROM Orders);<br/>
- EXISTS : if문 같은 느낌<br/>
*** 주문이 있는 고객의 이름과 주소를 보이시오.<br/>
*** SELECT name, address<br/>FROM Customer cs<br/>WHERE EXISTS(SELECT * FROM Orders od  WHERE cs.custid=od.custid);
## 데이터 정의어
### CREATE 문
- 테이블을 구성, 속성과 속성에 관한 제약을 정의, 기본키 및 외래키를 정의하는 명령<br/>
*** CREATE TABLE    NewBook(<br/> bookid    INTEGER,<br/> bookname      VARCHAR(20),<br/>publisher      VARCHAR(20),<br/> price     INTEGER,<br/> PRIMARY KEY       (bookid));
### ALTER 문
- 생성된 테이블의 속성과 속성에 관한 제약을 변경, 기본키 및 외래키를 변경<br/>
*** ALTER TABLE NewBook MODIFY isbn INTEGER;<br/>
*** ALTER TABLE NewBook DROP COLUMN isbn;<br/>
*** ALTER TABLE NewBook MODIFY bookid INTEGER NOT NULL;<br/>
*** ALTER TABLE NewBook ADD PRIMARY KEY(bookid);<br/>
### DROP 문
- 테이블을 삭제하는 명령<br/>
*** DROP TABLE NewBook;
## 데이터 조작어 - 삽입,수정,삭제
### INSERT 문
- 테이블에 새로운 투플을 삽입하는 명령<br/>
*** INSERT INTO Book<br/>       VALUES(11,'스포츠 의학','한솔의학서적',90000);
### UPDATE 문
- 특정 속성 값을 수정하는 명령어<br/>
*** Customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오.<br/>
*** UPDATE  Customer<br/>SET    address='대한민국 부산'<br/>WHERE   custid=5;
### DELETE 문
- 테이블에 있는 기존 투플을 삭제하는 명령<br/>
*** DELETE FROM Book<br/>WHERE  bookid='11';

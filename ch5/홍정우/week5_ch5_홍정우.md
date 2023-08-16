## 01 데이터베이스 프로그래밍의 개념

프로그래밍

- 프로그램을 설계하고 서스코드를 작성하여 디버깅하는 과정

데이터베이스 프로그래밍

- DBMS에 데이터를 정의하고 저장된 데이터를 읽어와 데이터를 변경하는 프로그램을 작성하는 과정

삽입 프로그래밍

- SQL 단독으로 프로그래밍하는 것은 절차가 필요한 복잡한 로직을 구현하기 어렵고, GUI 응용을 구현할 수 없는 등 일반 사용자가 사용하기에 한계가 있다. 따라서 일반 프로그래밍 언어에 SQL 문을 삽입하여 각 언어의 장점을 살린 프로그래밍을 하는 것이 좋다.

호스트 언어

- SQL 문이 삽입되는 프로그래밍 언어

데이터베이스 프로그래밍의 네 가지 대표적인 방법

1. SQL 전용 언어를 사용하는 방법
2. 일반 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
3. 웹 프로그래밍 언어에 SQL을 삽입하여 사용하는 방법
4. 4GL(4th Generation Language) - Delphi, Power Builder…

## 02 저장 프로그램

저장 프로그램

- 데이터 응용 프로그램을 작성하는 데 사용하는 MySQL의 SQL 전용 언어
- SQL 전용 언어는 SQL문에 변수, 제어, 입출력 등의 프로그래밍 기능을 추가하여 SQL만으로 처리하기 어려운 문제를 해결한다.
- 프로그램 로직을 프로시저로 구현하여 객체 형태로 사용한다.
- 함수와 비슷한 개념
- 저장 프로그램은 저장 루틴, 트리거, 이벤트로 구성되며, 저장 루틴은 프로시저와 함수로 나눈다.
- 프로시저를 정의하려면 CREATE PROCEDURE 문을 사용

프로시저는 선언부와 실행부(BEGIN-END)로 구성된다. 선언부에선ㄴ 변수와 매개변수를 선언하고 실행부에서는 프로그램 로직을 구현한다.

매개변수 : 저장 프로시저가 호출될 때 그 프로시저에 전달되는 값

변수 : 저장 프로시저나 프리거 내에서 사용되는 값

삽입 작업을 하는 프로시저

- 테이블에 데이터를 삽입하는 프로시저

제어문을 사용하는 프로시저

- 저장 프로그램의 제어문은 어떤 조건에서 어떤 코드가 실행되어야 하는 지를 제어하기 위한 문법

| 구문 | 의미 | 문법 |
| --- | --- | --- |
| DELIMITER | 구문 종료 기호 설정 | DELIMITER{기호} |
| BEGIN-END | 프로그램 문을 블록화시킴중첩가능 | BEGIN{SQL 문}END |
| IF-ELSE | 조건의 검사 결과에 따라 문장을 선택적으로 수행 | IF<조건> THEN {SQL 문}[ELSE {SQL 문}]END IF; |
| LOOP | LEAVE 문을 만나기 전까지 LOOP을 반복 | [label:] LOOP{SQL 문 |LEAVE [label]}END LOOP |
| WHILE | 조건이 참일 경우 WHILE 문의 블록을 실행 | WHILE <조건> DO{SQL 문| BREAK | CONTINUE}END WHILE |
| REPEAT | 조건이 참일 경우 REPEAT 문의 블록을 실행 | [label:]REPEAT{SQL 문|BREAK|CONTINUE}UNTIL<조건>END REPEAT [label:] |
| RETURN | 프로시저를 종료. 프로시저를 종료상태값 반환 가능 | RETURN [<식>] |

결과를 반환하는 프로시저

- 프로시저를 선언할 때 인자의 타입을 OUT으로 설정한 후, 이 인자 변수에 값을 주면 된다.

**프로시저, 트리거, 사용자 정의 함수의 공통점과 차이점**

| 구분 | 프로시저 | 트리거 | 사용자 정의 함수 |
| --- | --- | --- | --- |
| 공통점 | 저장 프로시저 | 저장 프로시저 | 저장 프로시저 |
| 정의 방법 | CREATE |  |  |
| PROCEDURE 문 | CREATE TRIGGER 문 | CREATE FUNCTION 문 |  |
| 호출 방법 | CALL 문으로 직접 호출 | INSERT, DELETE, UPDATE 문이 실행될 때 자동으로 실행됨 | SELECT 문에 포함 |
| 기능의 차이 | SQL 문으로 할 수 없는 복잡한 로직을 수행 | 기본값 제공, 데이터 제약 준수, SQL 뷰의 수정, 참조무결성 작업 등을 수행 | 속성 값을 가공하여 반환, SQL 문에서 직접 사용 |

### 저장 프로그램 문법 요약

| 구분 | 명령어 |
| --- | --- |
| 데이터 정의어 | CREATE TABLECREATE PROCEDURECREATE FUNCTIONCREATE TRIGGERDROP |
| 데이터 조작어 | SELECTINSERTDELETEUPDATE |
| 데이터 타입 | INTEGER, VARCHAR(n), DATE |
| 변수 | DECLARE 문으로 선언 치환(SET, = 사용) |
| 연산자 | 산술연산자(+, -, *, /)비교연산자(=, <,>.>=, <=, <>)문자열연산자( |
| 주석 | —, /* */ |
| 내장 함수 | 숫자 함수(ABS, CEIL, FLOOR, POWER 등)집계 함수(AVG, COUNT, MAX MIN, SUM)날짜 함수(SYSDATE, DATE, DATNAME 등)문자 함수(CHAR, LEFT, LOWER, SUBSTR 등) |
| 제어문 | BEGIN-ENDIF-THEN-ELSEWHILE, LOOP |
| 데이터 제어어 | GRANTREVOKE |
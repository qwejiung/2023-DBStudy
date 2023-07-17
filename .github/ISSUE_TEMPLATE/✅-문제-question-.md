---
name: "✅ 문제 Question "
about: 주차 별 문제 풀이 시에 고민했던 내용을 공유해주세요.
title: "[문제 Question]"
labels: ''
assignees: ''

---

Issue:  ✅ 문제 Question
주차 별 문제 풀이 시에 고민했던 내용을 공유해주세요.

주차
예시:
week2

문제 이름 및 링크
예시:
[강원도에 위치한 생산공장 목록 출력하기](https://school.programmers.co.kr/learn/courses/30/lessons/131112)

공유 내용
예시:
```sql
/* 틀린 풀이 */ 
SELECT CATEGORY, MAX(PRICE) AS MAX_PRICE, PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
GROUP BY CATEGORY
ORDER BY MAX_PRICE DESC
```
이런 식으로 문제를 풀었는데 틀린 이유를 잘 모르겠습니다! 
또는
~식으로 해결 했는데 기가 막힌 풀이라 공유합니다~!

ETC
기타사항

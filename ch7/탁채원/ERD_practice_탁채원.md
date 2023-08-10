# ERD_practice_탁채원

### 실습 과제(7주차까지)

- 책의 실습을 꼭 직접 해보고 정리해보시길 바랍니다.
- 주어진 요구 사항에 맞게 직접 erd를 작성하고, erd에 맞게 구현하시면 됩니다.
- 이번 과제는 7주차 주차별 학습 pr을 올릴 때 함께 올려주시면 됩니다.
    - 제출 양식
    - 자신의 7주차 폴더에 ERD_practice_자신의이름.md 파일에 ER 모델 요구사항과 자신이 구현한 ER 모델 이미지를 작성해주세요.
        - 예시) ch7/나경호/ERD_practice_나경호.md
    - 구현한 ERD의 쿼리를 추출하여 ERD_query_자신의이름.sql 파일에 작성해주세요.
        - 예시) ch7/나경호/ERD_query_나경호.sql

### 파일 구성 예시(아래의 폼으로 작성해주세요.)

## ER 모델 요구사항

### 회원(Member)

- MEMBER_ID, 이름, 주소(city, street, zipcode)를 가진다.

### 주문(Orders)

- ORDER_ID, **외래키 2개**, 주문 날짜를 가진다.

### 주문상품(OrderItem)

- ORDER_ITEM_ID, **외래키 2개**, 주문 금액( `orderPrice` ), 주문 수량( `count` ) 을 가진다.

### 상품(Item)

- ITEM_ID, 이름, 가격, 재고수량( `stockQuantity` )을 가진다.

### 카테고리(Category)

- CATEGORY_ID, 이름을 가진다.

### 배송(Delivery)

- DELIVERY_ID, 주소(city, street, zipcode)를 가진다.

## 연관 관계

**회원과 주문**

**주문상품과 주문**

**주문상품과 상품**

**상품과 카테고리** -> 다대다 관계입니다!

**주문과 배송**

## ER 모델 구현

- 이곳에 본인이 구현한 ER의 이미지를 첨부해주세요.
<img width="919" alt="ERD_practice_탁채원" src="https://github.com/noweahct/2023-DBStudy/assets/128283286/c0b3d9c9-564f-486e-85a8-ddf52b2c82c9">

### 참고 자료

[ERD / 맥북 Mac ERD 그리기 & 윈도우 ERwin 다운로드 설치](https://m.blog.naver.com/15elly/221883856527)

[DB구현-EER 모델링 관계 정의](https://velog.io/@woods0611/DB구현-EER-모델링-관계-정의)

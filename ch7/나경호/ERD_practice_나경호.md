## ER 모델 요구사항

### 회원(Member)

- MEMBER_ID, 이름, 주소(city, street, zipcode)를 가진다.

### 주문(Orders)

- ORDER_ID, **외래키 2개**, 주문 날짜를 가진다.

### 주문상품(OrderItem)

- ORDER_ITEM_ID, **외래키 2개**, 주문 금액( `orderPrice` ), 주문 수량( `count` ) 을 가진다.

### 상품(Item)

- ITEM_ID, 이름, 가격, 재고수량( `stockQuantity` )을 가진다.

### 카테고리(Category)

- CATEGORY_ID, 이름을 가진다.

### 배송(Delivery)

- DELIVERY_ID, 주소(city, street, zipcode)를 가진다.

## 연관 관계

**회원과 주문**

**주문상품과 주문**

**주문상품과 상품**

**상품과 카테고리** 

**주문과 배송**


## ER 모델 구현

<img width="434" alt="스크린샷 2023-08-08 오후 10 02 37" src="https://github.com/Hoya324/2023-DBStudy/assets/96857599/f87e0848-6a08-48fc-b4cd-421b9b8b45b4">

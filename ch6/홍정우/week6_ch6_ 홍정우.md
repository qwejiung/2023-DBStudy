# CHAPTHER 06 데이터 모델링

## 데이터 모델링의 개념

**데이터베이스 생명주기**

- 데이터베이스의 생성과 운영에 관련된 특징
1. 요구사항 수집 및 분석
2. 설계
3. 구현
4. 운영
5. 감시 및 개션

**데이터 베이스 모델링 과정**

요구사항 수집 및 분석

1. 현실 세계의 대상 및 사용자의 요구사항을 정리하고 분석한다.

설계

1. 중요 개념을 구분한 후 (개념적 모델링)
2. 각 개념을 구체화 (논리적 모델링)
3. 데이터베이스 생성 계획에 따라 개체. 인덱스 등을 생성 (물리적 모델링)

******************************************************요구사항 수집 및 분석******************************************************

- 실제 문서를 수집하고 분석
- 담당자와의 인터뷰나 설문조사를 통해 요구사항을 직접 수렴
- 비슷한 업무를 처리하는 기존의 데이터베이스 분석
- 각 업무와 연관된 모든 부문을 살펴본다.

********************************개념적 모델링********************************

- 요구사항을 수집하고 분석한 결과를 토대로 업무의 핵심적인 개념을 구분하고 전체적인 뼈대를 만드는 과정
- 개체를 추출, 개체들 간의 관계를 정의 → ER 다이어그램 ( 실체들의 관계를 표현)

**********************************논리적 모델링**********************************

- 개념적 모델링에서 만든 ER 다이어그램을 사용하고자 하는 DBMS에 맞게 매핑하여 실제 데이터 베이스로 구현하기 위한 모델을 만드는 과정
- 개념적 모델링에서 추출하지 않았던 상세 속성들을 모두 추출
- 정규화 수행
- 데이터의 표준화 수행

**************물리적 모델링**************

- 작성된 논리적 모델을 실제 컴퓨터의 저장 장치에 저장하기 위한 물리적 구조를 정의하고 구현하는 과정
- 응답시간을 최소화해야 한다.
- 얼마나 많은 트랜잭션을 동시에 발생시킬 수 있는지 검토해야 한다.
- 데이터가 저장될 공간을 효율적으로 배치해야 한다.

## ER 모델

**********************개체와 개체 타입**********************

- 개체 : 유무형의 정보를 가지고 있는 독립적인 실체
- 개체는 비슷한 속성을 가진 개체 타입을 구성하며, 개체 집합으로 묶인다.
- 개체 타입 : 개체 집합의 동일한 특징을 나타내는 용어

******************개체 특징******************

- 유일한 식별자에 의해 식별이 가능하다.
- 꾸준한 관리를 필요로 하는 정보이다.
- 두 개 이상 영속적으로 존재한다.
- 업무 프로세스에 이용된다.
- 반드시 자신의 특징을 나타내는 속성을 포함한다.
- 다른 개체와 최소 한 개 이상의 관계를 맺고 있다.

****************************************************************************개체 타입의 ER 다이어그램 표현****************************************************************************

강한 개체 타입 : 직사각형 - 다른 개체의 도움 없이 독자적으로 존재할 수 있다.

약한 개체 타입 : 이중 직사각형 - 반드시 상위 개체 타입을 가진다.

******속성******

- 개체가 가진 성질
- ER 다이어그램 표현 : 타원으로 표현, 속성이 개체를 유일하게 식별할 수 있는 키일 경우 속성 이름에 밑줄을 긋는다.

**************************속성의 유형**************************

단순 속성과 복합 속성

- 단순 속성 : 더 이상 분해 불가능한 속성
- 복합 속성 : 독립적인 의미를 가진 속성

******************관계와 관계 타입******************

- 관계 : 개체 사이의 연관성을 나타내는 개념
- 관계 타입 : 개체 타입과 개체 타입 간의 연결 가능한 관계를 정의한 것
- 관계 집합 : 관계로 연결된 집합
- 관계 타입은 마름모로 표현

****************************************관계 타입의 유형****************************************

차수에 따른 관계 타입의 유형
<img src='https://blog.kakaocdn.net/dn/SVQx5/btqAPeDvUxj/oTxGigRuhSY1zDygqzHx41/img.png'>

************************************************************관계 대응 수에 따른 유형************************************************************

<img src='https://slidesplayer.org/slide/11328329/61/images/26/3.2+관계+타입의+유형+관계+대응수%28cardinality%29+%3A+두+개체+타입의+관계에+실제로+참여하는+개별+개체+수.jpg'>

********************ISA 관계********************

- 일부 개체 집합들이 맺고 있는 관계 중 상하 관계를 보이는 관계, 상위 개체 타입의 특성에 따라 하위 개체 타입이 결정되는 형태
- 상위 개체 타입을 슈퍼클래스, 하위 개체 타입을 서브클래스라 한다.
- 역삼각형으로 표현

**********************************참여 제약 조건**********************************

- 전체 참여 : 개체 집합의 모든 개체가 관계에 참여
- 부분 참여 : 일부만 참여

********역할********

- 개체 타입 간의 관계를 표현할 때 각 개체들은 고유한 역할을 담당
- 역할이 명확하지 않을 경우에는 반드시 표기해야 함.

******************************순환적 관계******************************

- 하나의 개체 타입이 동일한 개체 타입과 순환적으로 관계를 가지는 형태

**********************************************************약한 개체 타입과 식별자**********************************************************

<img src ='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAWIAAACOCAMAAAA8c/IFAAABvFBMVEX////G2fGfn5/V1dXJ3faKkZq4y+O8urji4uK+vr7IyMjr6+unp6f8//////3n5+ejxeL///nz8/Pb29v39/f2+f2hoaH0//+QkJCUorSvwNWbqr3T4fSJiYn///bDw8OWlpZ9fX2wsLAAAAD///Ckpp3P6Pd5eXmCiZNLRFpzncudtNOjvdv/+epwcHB6enqTosCaiHf06drH2OW2nYxwV1GhhnBzhJifkZLL5PPr/v+tzeTZy6qPjaC41/dYhrfo0LZraHG+oIKLg4q/xs6psLuqm4/z38JTZHSLrs7g8Prt3s7kz7nJubC2qZ/+8dqacGiag399dF+TpaJ8eInj//9pbIRiYmK8m4izz91EOU9CVHVxeoapmoZ7bXB6aHZ7l7UkOXBTN0eo0fUAMXBeR1tnlcVQNTZ/ZkKDrtloSUpUdZRaSUMrV4tUUFkAFE8uKT1SZpTPtJV4gahiaolSSU+nioBhVWycdFrNs568lGf//+JpfaWztsyBaGWFaFGxiH6+297h9uhSa4vLqZFnZ5MxQmWhlKNEMVnd1LeOrbKUeoKCma7CsJe/p6pXXnTsyaF7fZtDAAhUJiWfqvVbAAAb0UlEQVR4nO1dj1/bRpYfJIx/STKyjSzbkS1rDbgFEZAA2xBSB/8KkmXHCSFJQ8B3e7u3aXdzt042LZuUpk12c2lgk9z9wzczksE2P2yC3dLU388HZP2YsfzV05v3Zt68AWCAAQaA8PeuKqaHdV0cuBO2c+LauWs4wOa1nlV1EZA3KR4bPi+CI+euooFQuGdVXQRcsigeOicgxeet4gCQ4p7VdQEwoLjvGFDcd3RBMVQnQyG8GT75p3ekGJUeGWlsTsXPQPHwULc3c350pjiXSHx278urapC4Hw6feFUnioedm5vTD75IbyVnHs59fjqF/ac4vb2cX/hcvZa8U1vocDPnRzdSTP6b+tnVoZBtc/ZkGjtRrP7778n/KHyR/sPVB3/8xSkeVv/z4cjNz9V3V//08OaFoPj7zyHF6a9Gh+f+eOLtdJRiYmPm4YMLQnFu4yo3NYd+1Z++/vNFoHjuL8PwZobnXiYerX00xVjvIYpH5355iocu2fZsyelLwURytPrwF6d4WHo+PAQpHhkZ/6+R0Ik8dqIYavREcuaLS/lgcPSXp1hN7NnuPBy+FNsLXhvt83d1IcXIjMh9eTUfRjjxfrqUYmyWXACK/3sqBMVFvbYW2nrY5+/q1i4OmTbbOYw2BMtAugBGWygUwm8k/N/37xq4Hn1HDynuFS/DnyjFI+fFXujcVTQQDvasqosA1aTYaz8vBOrcVTRA8T2r6iLAdf7ufBNRb69qAp6e3dSnBae7Z1U5BhQfiwHFfceA4rPAF6O6gNBKRD8oVggiXJkF3uJf/cVZuM+WiVDqyhqjbwRWx0fhAYMg1LtpECkHtcwUiBTydH0KFTREFWRpxrBp8QQ8G6brw7g4J3LBgCKKzpWnE3r5eq60Zn6RsYQ3jEFozx7D7+UItWe/5liQvm6u8vSfYgCKjysrfpIT8yVMHaiEU1dG5fKGehdTnAoAMD8B7qYrH95MgcWJzFRmGpWqgepSFmTW4k8YG5gfev95Pamh4qW/hVAls8zrp5penQwXa2PosLIQptG2vhZflx8D+ZsA+Ha4Zz/nOJAkEDjiVHCx9te5xxSz+DHHt5YqCS0TJFeUa1iudtJPH4yCStK1gClevEVMrCa1FxNyElK8CeS9K4jizCymGMr34q0kyAbiH64gxuJEzu0iNFB8zrzdvV1fU9b167DWiJQDuoSqr49GspBiUKK4PN2zn3McIMVEp2u4PlP899+lAdBtGpRbUNwzVhQsxcoKeLo/CnYeTbxqlmKZIzRdBVt0ZRZLMWsQ94Ad7CyDbSjFVe3Z8/oelGI9ajzKRVXwanMpuzshz82E9WVUaRQhR2NNoka+i6QkCELr2e85Bt1QTPSZYt0GX2G/IXI8FC9DoxUkZUpWA1BRVJLy+nxDF+cL8FmkoHIIgUwilsYUA/Aa1K8COVuYjthAKVFN15dpVJ3mdbvHMmsVDupiVHgO6WK/23sj7cZmfRw+Qg1EYFtUnejZzzkOPaFYF9XIOg3YqsZmAW5JQvXoLGCvgcwt1HTBpiyfWUPXXYr/o7XoYc27GsjUAHi7xOBd9B82d+ijqYsR5iHF30O2pvD5Oqa4FMsLiQD6FEmYh4dwoQZvEUTxok3kh8z9F7fN7f6mFKtBdQPAq77r4iaKZU5UXUAuxxLBwOHRThRXnoCnP+yGdE4kyAQ+wn6ou2Yj5Tt5A1OcgRQV11DL9PbHJ63ff1gza1A5uNGhARNq3JyCu1V0X+NFRh8M+Gab+wrasFC5LslYebPk4eHDeliSHENSTFi1kuYvg0XIgK7Bb6WovuqJI1KcSRNIvVG5scNjHSl+Du7+sBuOpKKppd0wOlKcqt+qAfCNsmtS/DURKl5XoSA//fFEKf5k0UYxVFA37+m2B/lUk7HYUVFAxQDyIJ4lUxpSFCCSDSCKi3+7mmmWYrYshiIrrUV/cxQrosbagFIWxfwZpBjoHDWepIGSG2MkuBtJpQFUFPH1wJapKHQbQRhQrZYmUOPUgt8cxX7YZtmgp+Fw2Jqu6caiYLdpLKwIDHw89WgNwI0pxQhQikE9SY2/bC13WLOe1yIrAVngYzxSNowhUSOoIYKaNEuzZSpPZ2n0loHUEjxJqegSqEfx2wavlfLwMDz1or+K9SNwxKJgcJvBRJsOdUUxtDWh4UCsWM2k7kBtF1BcDYWDLDEo7QdNmYWDmovP5Y3IegDIc9fC5hv0ahmsXgXQ1AXw8YH4BtyUoCOkVpfA03ugXsPmQ/Ex/vYorWtAR2d/BRQfg37bxThSHppad9PZQGlTY4wk4liu7tGQ4shXE2BrCUTmhsBCSMna1+3bS+zbAKh8gKegcWHaEllkpLEFKeH66iJSzHW6pv/eHdTR9WVwV8sGDKrwGYU6ZiLEkhLaSYOSOAsWcgr0/aAalzkqaGwvAZ0n4IHIW4qnvoMSzuz/7dZCQpPXHSnpq9s9u7ce4SL0UWSuQ/7kdeMDUhQlftKGBVFOcZQwUVmhd+5tAaQECOglyFJLl8KBI5OlkYJQ8hr4tr+u2kfg4vS0sT4a2iBgQQP1tcax1avsGNQj2yapcANPxbeWDPzoVbjJ4q7IEiFwvBjCTaq/v306H4EL01+MwDphmykKhwZjyRRJCdPGwA30ik7ps1FE7rTTvyYMRj36jgHFfceA4r5jEEfRAV7xdCOtI7hJvoOd131VfKxXVV0I2Hv1kAZS3HcMdHHfMaC47xhQ3HcMKO47+kVxxAH/VBDxWPs+RUNxLLqj4RQ7TNfaHABt7AEgX8Ll5EuNcvBM5BLw+caOLac0qjM/yA4SsB6Ixm3IjqYN6/D9Er0e/YlpG39emQXGg39KBhr1YMuFWurKmlz4LGQO8i8ShDqfBpVNYSQzBQyiUJtHPRhKVhgt3leNB/cpHY2wyMRc+PV8Wp+7n+NxgMSijVBX00DPwnJrYCchDL1CQSs6Mb65Mw1KxKb+0xNUi/A/KNgts4xjuDJJLvxmFsACFS4bOP7WPxp+ajImOE6/pj9S/H6qck1lDG6iiEexQTGUujIN5BUrjiK1hOMobtyOrLxB4UJyEFMM/21DTliDmKiYg1iZe6/Ro5hlUpjiAhTV1WE0eLKRWYuvg/iTHUQxFOEUCp5jqnM/fQDFd4SIB2zwSO6syfQseA8p3troLcU+gXdgmqOn5ezpeTQQ+hF6EgVc1UeZbWUTD2UUtMWbo6Byn9w1pViStNU9rT5dql2B1Lz9cW8VxQeWwnqyeP9SfZp5V3mCyjHVQPVRGrx/WbpmSnEel9sJvalBoSzZhDSimHG/CkevJC/B8pmfPrDG5cuXJ0O0JcXfqJmkpBY31OImZad6KcVeu0A1nAqXwJ0syv2IaTPyHp8egu85ESrimDYoYqkro+xTftSMaav+4HMguTVyAEWwvA2MmQE/ho0kVaBwYggHzYL95QiU4vgWr5pSPKc6HKtWOXMgEVHMRl3R6P40UBKOeUQxz/O2HOQys+dzvEHi6/DBDdTEpDPXM13sEAU8MuqVBApR6OCEk1r7vkRmFnI+IwTAv2jAoues5FHA1agSYiQzpk0hSR8KuNolyf1pnYhxecwg4yPJnc8BsMNyqFGDjwlRnFmOS6Yu9sBykGKmCstNKQSRs1eRomBeQ3EdYcoaKEJFUdmKxbAuZuHVkFu4IRHF9Wmf3itF4YxhXpGmIIFPFNCv9kdj3LGucl908TzlLECKv/3JLuWsQ1ZM22prTBsv3jQDkF80xpCKf0T6wC5Zo93xFXQdlPuDeECoi5nDcri5Yxckq0ARNnfFLydnNpYa1dXMDaJ4z2k86QXFXmLS/KXOGcrUwX5pRsIM8LFjRp7609z5vUgKGa/Xe9AOWBGETPO+3+u3zjONNxh9QOWawmuaijfK+Q/KWV9nFUC7jNvt9jRX1zh+TK0fAd9lAVPmJWaaNQN5WcSHqRlne4mB63EWeKUYFldACryn/ZxoamNXjGg9NaC4e/isJs4tCcf3dDrNps9DtDR9x1HsNd8ud+NtM98v+J5Z+6z5vjFtz7F1eBRezLrN5g5Xhsaf3eDwXbU++Meaq0SvOWitBb3fB60I23r2SNlDg8HdVtP5YfEHSF5sKFxWQ1+uRMfcjVvwEfgp+BsX44JtN4La5acaNAaKwQXUwhjEeHB1mDGIvTqOaSsmcAg3isw8MYQbenc16DuQV+67SqZ3J4Zhcxcx3lnTaeZN707m+TT07hReRMG0qByXZBKAfU2D4jLQufFZWIssxGJ3cFsnBwGalwTk9QAa0I5/B70JucBr781AglQAnVBEQoR2n+sPOUdb4Oi54G4IJtQUh2ZDJeksTMdXPHv12sHD9dtjEmooGlbdMRR/P4EovnFrbs1s5X3xD/uwUY9/c9MMfl3GYYM4vvjEEG54RWVd9ZZFVbdmLIWQXawnNcu7o7Er90KTkXcHnbz1NyZN8Q+I4l1OWlwDLueDh5DiyiZBmAEvlfv0s21VpvI+Ih+oJwu14tfaznLl8XvTSNldiq/T4O+/hz+c9htiXt6+d05eD+CbFPEb6xZjZPPxynWiOsoUiHATxQCbcuhyv30SK+52indyr2lI8ff5ueRXmOIbt3PI9ao34ouTHArhLtaYt8eFcCs4vqeyQVeC0BCNr1szluYnsHe3cThjSYOVri5XPkDvLpNITRVNiuvLbAK+OeUN6hLws7tLkGJFEIQsqkSu2sPxD2j2zAq0ECDFz2GheY1dz7xEp+P/OxHfDSMDbmYCRaI/8K30wH7AcP7OUonEnRabLFKmcFw+w+itER+OGQFv/TMz4AjFMnzJVDIA321JygfQuytxVCENJcOwouRHGYDnehAamwOtFWPvbhi+xEHar4RBJVEIVkzvrgZQH8X8zJDl3S0BBnl35Txtzk/AVWIrFlJsUIV3FKEyi8ugMhspQ2eND6KJSxoglVlQEqEqIEbg1YyuglfDzz6YUnz3h/XIOl3iKIKjQqDEh9pv7xzwczGnaSW26AmAHFPUaWBPNVEMNYVpLpO4B+OoFCuSZN++DZ1fStpG5eQQmjUnvw4AUxfD83k0eXPnnltZby2KpRi7qGXKjqZjGDTu0wRKkMYzloLs6weYYl2ScmjG0lbAXZqGfnbeVUCPQg8CRLHFzXwIzWZs0sUlmx05NIbk3P8CsDfyaJ6InIpNYF0MffRSfiUAMkFnOYT8DHv5Qy97Ll0CYfZCkILYJMr/QmLIUfkDl8ZBWI61XWg8jOMsCqgoKhsOs4u28tJHmn219dYQ7k1RPDGE+yl0oGE7d+MHkmz0jnTw7jKN2LdIAsS3octrigXSxY8mJzfx3k7IsVMzDz+HClv1WVNz3jfKoji6ethh7MHbC/n0nlIMTbFGL4SbEuwn9KxFBQrrFJ/IHyrt4yiGtg/rI9HsIHD4AdpbjUuRleT1+XwnGm2MD1PrJg8pdpvWmfvAvEEfPL5GV3uz0cY4DihGZh/pcrnMs45GYCSy3TyHF7UYbfAi+N8Lz7b7BueGPxqz+tagKB/lzQutDkx9owfDwsD1OBMcwmXzMbtb/WfI+iSPqfSLk208DCg+K6gZS03YZw76ixv9QICMCUcIHVB8drhiVtMHDWAk076DvmPT62hDXyg2xDRsemR+7hGPptywBYLXtmmgCzyfhI2/yBFhEClsjMdgW2dwnDkZtMTBTxOsZ1cde3HhwuPb4G40fahH3hr8aGnimtEPios1dovNBlhSpIKo7ZHXQUbdokEpQRBJZAOCyAa8rKoifxg2eW+e42JGQB8Cil3Mu25cdIpR09fohfAhwW3plGhDjymW0YNszFhK5BxGAs/9ADvqbo7OQIqDDYp1F3HHsGmRbdJhWRXzS5kREMn6CuqvgGLQ3AvhFk8cVQJ9GLsbxkO/T5eyAdK1/5krqllSvKshPcELYagoZqCiUMoCL+Q1pjz+Dk9VAqUF283NNFuVsvavfhUUQ+BWjpw8xoJrQq9HoKEjByLVuRqasfTKxsXQsBBbJkQNKgp9MnZ5D12ZwsPUFPWgBreRRlfHXa2+DJ9HrmmY6eLDNznTKUq2XxYF8rR2Ve/+dOMAbO52lr3eTaATHIVauEUbmqJk4D0V9YZQHEUF6eJjv/fTWkmobzOWSBpE7NRhEgG4r1AUdziptzlbRRNk+0GSik8EA7u47xhQ3HcMKO47BhT3HYPpNB0wmBTWPwwmhf16MNDFHw2HUxR5AULkeYo82V0aUPxxiMZiUhOtDqcweXzo64Dij4JHnDyma9jDx45lYEDxmeEVxZMaMOnniy/+lOGaPGWGkp84mmRsQPEZQXVI1OaabD8yoPhskKhOVzhm2g4MKD4THHzna1xtT2FA8ZkQ62a0gG9tDbugGMWpgyOTRI7igGJYYAyND8W/AzjhM9ynXboKIjlguNLWAUND02AAPAxg9Yp13Vgjw6e/8d/VqxDWXsDRUU3gq6SW3S4ojtjtjwJCFzUfRMnb9/+K5kCPb1AGigpkjbI5B/pRYw60067Np0FmrzCVmQI7wXIYhw3KzvJ9Buf+ZvSFEKSW2Q54qhdpBMTeVbZB0KpNuqBY58pPwFkoRtPhKtfUOEWNVBKYoYw1B9p9A1P8NEeOrYYDN26zZpR83IyS17kHNUxxhMu5SU4DlUdpMnuRKJa6U6tnphhSMtQtxfX7kBFmZ+pgDvQenoCXWkJR8sV/ehatCbqOwN0QndkrIylWCDFtBr8ybzUUJQ+UqGs351KVRIDSCheK4u6iPc9MMbs4DbqlGGd+NUiDkqDqNQjVnMs8v4xCuONbRs1SFLekXAFeGB0zlbUVXyxX7wFMsd/gRT4/xtAKlb9IDANnVy26X2wt1Jli3BSdSVHsaqC0Z0bpNypAc6BVQLYtOkFRc2aU/AMcJX8JmBQjyOs0KD5Hq190/uafDV6xm6tcrbZBt0ZbF/Zgc9ggJ6p41kxjeQhEMdrcHV+2DiCKFxHFeM+c8Q/BNtKyyysBIBcIItjrLB3ngtghvQdGrHV3YBefCf4j7vFREIMQ7nMBu8cuu/ME2P1AktqKDCg+Ixx3vMDrPgleILQzPKD47Lh8hMRD+O4cdU4GFJ8drhnn8V0VvthxDvaA4o+BSxDJtpEPv+P4mR4Dij8WbifBU3bS4YEK2EE6KZ6XTrLnBhR/PNy+qFOSJMoZJT2ndHIOKO47BtFAHXB6TBuHcWrgFjcpDmLajscgpu0Xh5eUOF4gRJHgBVFynaxwB7r4o+CWeMLpOxBPv8dFCcQJQyIDij8C5LF0uqXYscplQPGZ4b1MnWSiuWaOiXXrzzTzfAANdzx7DHQziRilEldGD/MXlygOJRFD12WmgMxpGWIKJ/+p47Q2XF6ZTS0pGnDhNMYyR/lez0+gxJep6gRT5nkBrwONFo7M06gYQ9JoACC+EgBNiZDMj76xg1U+e4Po5GkD/dTRsYt+UFyfljcq36AF1jiXlUQsnLoyKhfeWSPQVXPB+NXlSu3NFNgNrL8R13DC0bpJxosfZ6tLmc3xL/H0UjS6CinW596hZNzsnCDcbPTrs2+XQD3JFZ7QOrRmopDi+tXGKYPPqjSaiWrM9ZJiqsOyjb72YKCeL4yJWoC7afBW+UYt2sp7FTOJ2M5QYR9KcVJfaCQ6n1hNai9ux1feTMU/gNU7iOJv7xnfYzLYxLMPb5cy0+zCeA3XPK+9rkIprhnXIcU3BUEYsb6SyQbAq2W/sk6zBSnrzWrgfdJaqNCl6Uu6ChQ+3FMppjracu72Xvt+LIwpE+JQ5TuQCesrCpZieYV+CkUp85n2qjkVXoUX1eJI5AkoGJDiyrU9S4p3lp9tbC/JZTHsMFPm1iLZLSj0L+lUVdtHScWQptAJTiC2Ql5DFMW8VnkO6ve27rkdEChpEdQuVZuUjxABPVRcPuWuzwZfx9VdYWPYdk3PF8ZEg/oGRYko3Rc5pqCxOzml4SRiSSVppojeJ4g8SiIm4aHTeedsSVyLb2ulKUxxKQieQUWBMrLdRJkqlATUsvMTmdqbIMoUXebFOYuzG7dh5Ubu+3ukDxhiOLJOK0aOJHGWJgVq6vUltAwkle9dQFFXAVdtE/s7Umyt00DijXzacHCLRYFyMzdGoFFyq9SVNXYM+I+OQE8B1kFn+DW04rQXU+ylQeUxpPjFD2Y+LO8YiK88nfDTIJI1FcXlJoqhCjeshNBoavvfrzbdBDwvQ5oPV+c8L7oMuGq96lSKI1DVCYGIDdQTnwVKc9fDmdNutoViJYdSmh6OQKOYNogS2ViwA8W0QWkn8GHdWmNat87KuWgAyh/XmJUeyRn44UYNjS1ARWHpYsxtSaQIMxUdWsC6JMI3pJGgDZ1XOCLUs4RtvQ+4kv+wBPhAZFfaTW8FQKUGuqf408SJyWla0T3FkZQjSEOKq1I1CN/B93+hi9fVky//DVDc84ArxeczcvDlkyVJWqHlhDFd/I1LcbSrn+g9g6JQYOu8CTVEQpKSKCDYXuqaYitFt7+leg8NrNEXT3Nex2Yw1gWO5rPtFyGggfafPfTY20VQFHwQ0ZbdjhaFEADFJ06nEzco77uiWKGojcgKrRPjNej0sv8iuCpqnxT7n/PqNi2XZ0QVL5VSEgUNmseKSHCbmK1KEKUlhYbe3VtPgDG3GaovwzZzbvTVMlDQUuyoyYugHN3TgDEIbrGnjnFXOKk3rQVt/l03djGDFnUwl8g+rW0+oFinyi8hxSipdtFaKwlZBowuhphtgNMXI4rj/4CmXT2Jn50Z4lp8icIGK5vSV7fXcaIslI8JFB/WcZ8EQNnAQWThFrW4BtgqQYjpLn5vj3HEPT4Kvu0x9CPDFVodPr5C15PcveI72D7qExkUHCiv06vp78OB+P+lMcVg3yZoO/ADE6VxjmXZVppiMMULtzagp/gFqH+tLdqIS3W0ApMRwGtdsbvQmIYUF5r86J8RbsSx2+MBHo8bbr1w6/V7PH609aItEPsccIXztIF6DUApRj0yWIrryyUkhnLW8zS9hXKpr9CmotDYEoofZt4GzLRiHrfhyyFFI0lhUNl7OgGlGIo8eIWK37hdRs/BjVZIcPv3odss8pdOuZ0+wT3jAGTUCZxREricDuB0+txOp9vrdDocTqffL/R76RQ0iwagZRAgxZkERxizwOdbXTPTFMtRFWzTShjoIUzx6lWd4FSW9G2pPuxE6s6oHSXVtEnjSSalRfL7y2DeRlCFIdbnW1BxLWTUuO5yaqAginPDPbv3M8DPn9JPEY0djaboV5e8vII1BpRiEqPheW+b2tykeG1+c2soQpIoDbWl5VEId32PdJn7ddNTfrXMmheZjSJKpxfZikZXf/7mDoMUTuiTj14+bmJXvyhmzHEtpt2usoa7/IhBvwMaXm0NKCrn9zgc5ipJ/pb1VZqrZjwNxn8JOPijqwiSQntuaAuDgaWPBMnHBMrlc3jcDgdp54XYCaGEA4rPBTfptEuUXSJPnZ4woLgD/OTJ8B3gtIuI6ClnzwSfkzrtm351cHSmuDv0kpVPimGyu67hAQa46Ph/e6SzYuVeZbQAAAAASUVORK5CYII='>

******IE 표기법******
<img src='https://images.velog.io/images/kw78999/post/cd3e7c15-476d-40f2-9489-e02526b80f5d/image.png'>
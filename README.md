# Bithumb-CoinTradeApp

## 동작화면


## 설계


## 🖥 기술 스택 / 라이브러리 / 라이브러리 선택 이유

* iOS Deployment Target: 14.0
  * 애플 스토어의 버전 지분 기준 14이상이 압도적이었음 
  * @@@@@@@사진 또는 링크 추가@@@@@@@
* Xcode Version: 13.1
  * 재영이랑 힉스가 13.1 이어서 리을이 맞춰줌
* Architecture: MVVM
  * MVC 보다는 계층이 분리되어 책임/코드 분리 측면에서 용이함
  * 다른 아키텍쳐에 비해 팀원들이 익숙해 학습 비용이 낮음
  * RxSwift와 궁합이 잘맞음
* Asynchronous Programming: RxSwift
  * 비동기 처리에 많은 도움을 줌
  * Combine 보다 RxSwift가 팀원들이 익숙해 학습 비용이 낮음
  * RxCocoa등 다양한 익스텐션 활용 가능 -> 생산성 증가
* UI: UIKit, Code based
  * 스토리보드는 충돌 및 코드 파악이 쉽지 않음
  * 코드로 만든 뷰는 재활용 가능
  * SwiftUI에 익숙하지 않음
* SnapKit, Then
  * 조금 더 편하고 생산성 증가를 위해 채택
* Charts
  * 차트를 쉽게 구현하게 하기 위해 Charts 라이브러리 채택
  * 차트 라이브러리 중 가장 유명 -> 참고할만한 자료가 많음
* Alamofire, Starscream (Web Socket)
  * 네크워크 요청을 쉽게 하기 위해 채택
  * URLSession 웹소켓은 직접 계속 receive를 호출해야 데이터를 받아올 수 있음 -> 성능/구현 상으로 깔끔해보이지 않음
  * Starscream은 delegate로 이벤트가 발생할 때마다 알려줌
* Code Convention: SwiftLint
  * 협업시 코딩 컨벤션 유지를 위해 사용
* Database: Realm
  * 속도가 빠름 > CoreData, SQLite
  * Realm Studio를 통해 데이터 저장된 것을 쉽게 확인 가능
* Dependency Manager: Cocoapods
  * SPM, Carthage가 지원하지 않는 라이브러리가 존재할 수 있음 -> SwiftLint
  * 팀원 모두 코코아팟이 익숙함

## 기능별 구현 설명


## 🎨 (간략한) 화면 설계

![image](https://user-images.githubusercontent.com/15073405/155553921-aeafe20a-2fec-4d7f-99d5-6c58b4bdc9ff.png)

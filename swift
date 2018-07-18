Var a : int  이런식으로 선언. 즉 타입이 콜론 뒤에 가장 마지막으로 들어감.


접근 한정자
 * open : like public in other languages
 * public : sub class 생성, override에 제한
 * internal : 디폴트 값. 외부 모듈에서 접근 불가
 * fileprivate : 소속 소스 파일 내에서 접근 가능
 * private

옵셔널
? : nil 가능
! : 옵셔널 변수에 값이 있다고 가정하고 값에 바로 접근하는 방법이나 이는 런타임 익셉션을 불러올 가능성이 있음.

옵셔널 바인딩
 If 문을 이용해서 nil 값을 가지고 있으면 거를 수 있음. 이는 콤마 (,) 를 이용해서 && 과 같은 역할을 하는 연산이 가능함.

메소드
 * 인스턴스 메소드
  * 일반적인 메소드
 * 클래스 메소드
  * 
 * 스테틱 메소드


iOS
 * 버튼 등의 뷰에 제약을 걸어서 (constraint) 사방의 여백 거리 혹은 뷰 크기를 비율에 맞게 조정 가능. -> 한자 / 한영 키 아이패드에서 테스트 시 너무 작아지지 않게 사용 가능할 듯. -> 픽스 후 테스트 해봐야 할 것.
 * 화면 전환
  * 스택과 같은 느낌..... push를 통해 화면 전환 시 pop을 하듯 화면을 빼야 함...
  * 뷰 컨트롤러에서 다른 뷰 컨트롤러를 호출하기
  
presentViewController(_:animated:completion:)
dismissViewControllerAnimated(_:completion:)
이 방법에서 주의해야할 점은 위 메소드를 호출하는 객체가 동일하다는 것이다.
뷰 컨트롤러 A가 self.presentViewController(_:animated:completion:)로 뷰 컨트롤러 B를 호출하면 B와 A사이에는 다음과 같은 속성을 갖는다.
A.presentedViewController => B
B.presentingViewController => A

여기서 B에서 A로 돌아갈 땐 A에서 B로 갈 때처럼 self.dismissViewControllerAnimated(_:completion:)이 아니라 다음과 같이 A를 참조하여 호출한다. self.presentingViewController?.dismissViewControllerAnimated(_:completion:)

3. 네비게이션 컨트롤러 사용하기
pushViewController(_:animated:)
popViewControllerAnimated(_:)
이 방법은 전체적인 화면 관리를 navigationController가 맡아서 한다는 것이 특징이다. 2번 방법은 뷰 컨트롤러가 직접 메소드를 호출했지만, 3번 방법은 2가지 메소드 모두 아래와 같이 navigationController가 호출한다.
self.navigationController?.pushViewController(_:animated:)
self.navigationController?.popViewControllerAnimated(_:)

네비게이션 컨트롤러를 이용한 방법의 특징 중 하나는 pushViewController(_:animated:)를 이용하여 화면 전환을 하게 되면 전환된 뷰 컨트롤러에 자동으로 네비게이션 바가 탑재되고, 네비게이션 바 왼쪽에 아이템을 별도로 지정하지 않았을 경우 자동으로 popViewControllerAnimated(_:)를 이용한 Unwind가 구현된다는 것이다.

4. 화면 전환용 객체 세그웨이(Segueway) 사용하기
Action Segue
Manual Segue
세그웨이는 스위프트 코드가 아닌 스토리보드 상에서 그래피컬하게 전환을 설정한다. 세부적으로 코딩도 들어가긴 하지만 기본적인 전환 관계를 스토리보드상에서 연결하며 직관적으로 알아보기 쉽게 화살표로 표시를 해준다. 세그웨이엔 2가지 ‘Action Segue’와 ‘Manual Segue’가 존재한다. 액션 세그는 버튼등 이벤트가 발생하는 객체와 뷰 컨트롤러를 직접 연결할 때 사용하며, 매뉴얼 세그는 뷰 컨트롤러와 뷰 컨트롤러를 직접 연결하며 performSegueWithIdentifier(_:sender:)를 특정 시점에 호출하여 전환을 한다. 세그웨이를 이용한 전환에서 Unwind의 경우 스토리보드에서 뷰 컨트롤러를 선택시 윗 부분에 나타나는 3개의 아이콘 중에서 오른쪽 끝에 있는 Exit 아이콘에 연결하여 복귀할 뷰 컨트롤러 클래스에서 정의된 Unwind 메소드를 지정함으로써 구현한다.

세그웨이는 UIStoryboardSegue 클래스를 상속받아 커스텀 세그를 구현할 수 있다. 이미 정의되어있는 perform(_:) 메소드를 override하여 구현한다.

prepareForSegue(segue: UIStoryboardSegue, sender: Anyobject?) 메소드를 전환 되는 시점의 뷰 컨트롤러 클래스에 재정의(override)하여 세그웨이가 실행되기 전 특정 코드를 실행할 수 있다.

출처 : http://blog.lattecom.xyz/2016/06/06/swift-ios-scene-transition/

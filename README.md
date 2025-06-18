# oknawa-supabase


## TODO 개발사항 250617

### 최종 구현 대상 엔드포인트 목록

---
중간지점 추천 관련
1. 중간지점 추천받기
   - POST /location/points ✅
     - 설명: 사용자들간의 중간지점역 찾기 (추천받기)

~~2. 추천받기 결과 조회 (Polling) ✅~~
  - 테이블 API 대체

3. 선호도 투표 ✅
   - POST /location/points/{map_id}/vote 
     - 설명: 선호도 투표 하기


~~4. 선호도 투표 확정 ✅~~
  - 테이블 API 대체

---

결과확정 및 핫플레이스 관련

~~5. 중간지점 결과(share_key)로 조회 ✅~~
   - 테이블 API 대체

6. 결과확정페이지에서 핫플레이스(만날장소) 리스트
   - GET /location/point/place/{category} 
     - 설명: category(food, cafe, drink), x/y/radius/page/size/sort 쿼리

---

함께 입력 기능(동시 위치 입력) 관련
7. 호스트 출발지 입력 및 공간 생성
   - POST /location/together 
     - 설명: 호스트 출발지 입력(방 생성)

8. 함께 입력방 현황 조회 (Polling)
   - GET /location/together/{room_id}/polling 
     - 설명: 방 현황 polling

9. 클라이언트 출발지 입력 
- POST /location/together/{room_id} 
  - 설명: 참여자(클라이언트) 출발지 입력

10. 호스트/클라이언트 출발지 수정 
- PUT /location/together/{room_id} 
  - 설명: 출발지 정보 수정(room_host_id 필요)

---

부가 기능(주요 지하철역 upsert 등)
11. 주요 지하철역 데이터 upsert ✅
- POST /location/meeting 
  - 설명: 주요 지하철역 DB upsert


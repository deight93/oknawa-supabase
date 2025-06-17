# 1. 방 생성
curl -X POST http://localhost:54321/functions/v1/location-points \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -d '{
    "participant": [
      { "name": "김동환", "start_x": 127.129347097241, "start_y": 37.4860140096538 },
      { "name": "김디팔", "start_x": 127.113273744844, "start_y": 37.5064595683176 },
      { "name": "김띨팔", "start_x": 126.917252, "start_y": 37.494990 }
    ]
  }'



# 2. meeting 함수 호출 (옵션: 필요시 사용)
curl -X POST http://localhost:54321/functions/v1/meeting \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json"



# 3. polling (map_id는 실제 반환값으로 대체)
curl -X GET "http://localhost:54321/functions/v1/location-points-polling/{MAP_ID}" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json"



# 4. vote (map_id, share_key 실제값으로 대체)
curl -X POST "http://localhost:54321/functions/v1/location-points-vote/{MAP_ID}" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"share_key\": \"{SHARE_KEY}\"}"



# 5. confirm
curl -X POST "http://localhost:54321/functions/v1/location-points-confirm/{MAP_ID}" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"map_host_id\": \"{MAP_HOST_ID}\", \"share_key\": \"{SHARE_KEY}\"}"

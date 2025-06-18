# local edge func 실행
supabase functions serve --env-file ./.env

# 1. POST location/meeting (EDGE FUNCTION)
curl -X POST http://localhost:54321/functions/v1/location-meeting \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json"


# 2. POST location/points (EDGE FUNCTION)
curl -X POST http://localhost:54321/functions/v1/location-points \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -d '{
    "participant": [
      { "name": "김동환", "region_name": "A동", "start_x": 127.129347097241, "start_y": 37.4860140096538 },
      { "name": "김디팔", "region_name": "B 장소", "start_x": 127.113273744844, "start_y": 37.5064595683176 },
      { "name": "김띨팔", "region_name": "C장소", "start_x": 126.917252, "start_y": 37.494990 }
    ]
  }'


# 3. GET location/points/{map_id}/polling (TABLE API)
curl --request GET 'http://127.0.0.1:54321/rest/v1/location_result?map_id=eq.{MAP_ID}&select=*,station_info!station_info_map_id_fkey(*)' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Accept: application/vnd.pgrst.object+json"



# 4. POST location/points/{map_id}/vote (EDGE FUNCTION)
# TODO: RPC로 변경할것
curl -X POST "http://localhost:54321/functions/v1/location-points-vote/{MAP_ID}" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"share_key\": \"{SHARE_KEY}\"}"



# 5. POST location/points/{map_id}/confirm (TABLE API)
curl --request PATCH \
  'http://127.0.0.1:54321/rest/v1/location_result?map_id=eq.73f8aaaa-e86e-46ca-8622-3b7ca570b8a5&map_host_id=eq.aaaa8f37' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "confirmed": "05a8662d-08e8-4971-b77a-866c8d4f9c2f" }'


# 6. GET location/point/{share_key} (TABLE API)
curl --request GET 'http://127.0.0.1:54321/rest/v1/station_info?share_key=eq.{SHARE_KEY}&select=*' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Accept: application/vnd.pgrst.object+json"


# 7. POST location/together (EDGE FUNCTION)
# TODO: RPC로 변경할것
curl -X POST http://localhost:54321/functions/v1/location-together \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "김동환",
    "region_name": "A동",
    "start_x": 127.129347097241,
    "start_y": 37.4860140096538
  }'


# 8. GET location/together/{room_id}/polling (TABLE API)
curl --request GET 'http://127.0.0.1:54321/rest/v1/location_room?room_id=eq.{ROOM_ID}&select=*,participant!participant_room_id_fkey(*)' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Accept: application/vnd.pgrst.object+json"


# 9. POST location/together/{room_id} (TABLE API)
# -H "Prefer: resolution=merge-duplicates" -> upsert
# https://supabase.com/docs/reference/javascript/upsert
curl -X POST 'http://127.0.0.1:54321/rest/v1/participant' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "room_id": "c233535d-312b-4b74-b164-df29be8eaa45",
    "name": "김띨팔", "region_name": "C장소", "start_x": 126.917252, "start_y": 37.494990 }'


# 9. PUT location/together/{room_id} (RPC API)
curl -X POST 'http://127.0.0.1:54321/rest/v1/rpc/replace_participants_for_room' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "room_id": "d1bd4ab5-6dcb-43d9-8350-e70a2cb90887",
    "room_host_id": "5ba4db1d",
    "participants": [
      { "name": "김띨팔", "region_name": "C장소", "start_x": 126.917, "start_y": 37.4949 },
      { "name": "홍길동", "region_name": "A장소", "start_x": 127.00, "start_y": 37.50 }
    ]
  }'

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
curl --request GET 'http://127.0.0.1:54321/rest/v1/location_result?map_id=eq.{map_id}&select=*,station_info!station_info_map_id_fkey(*)' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Accept: application/vnd.pgrst.object+json"



# 4. POST location/points/{map_id}/vote (RPC API)
curl -X POST "http://127.0.0.1:54321/rest/v1/rpc/location_points_vote" \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "map_id": "{map_id}",
    "share_key": "{share_key}"
  }'



# 5. POST location/points/{map_id}/confirm (TABLE API)
curl --request PATCH \
  'http://127.0.0.1:54321/rest/v1/location_result?map_id=eq.{map_id}&map_host_id=eq.{map_host_id}' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{ "confirmed": "{share_key}" }'


# 6. GET location/point/{share_key} (TABLE API)
curl --request GET 'http://127.0.0.1:54321/rest/v1/station_info?share_key=eq.{SHARE_KEY}&select=*' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Accept: application/vnd.pgrst.object+json"


# 7. POST location/together (RPC API)
curl -X POST "http://localhost:54321/rest/v1/rpc/location_together" \
  -H "apikey: SUPABASE_SERVICE_ROLE_KEY" \
  -H "Authorization: Bearer SUPABASE_SERVICE_ROLE_KEY" \
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
    "room_id": "{room_id}",
    "name": "김띨팔", "region_name": "C장소", "start_x": 126.917252, "start_y": 37.494990
  }'


# 10. PUT location/together/{room_id} (RPC API)
curl -X POST 'http://127.0.0.1:54321/rest/v1/rpc/location_together_room_id' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "room_id": "{room_id}",
    "room_host_id": "{room_host_id}",
    "participants": [
      { "name": "김띨팔", "region_name": "C장소", "start_x": 126.917, "start_y": 37.4949 },
      { "name": "홍길동", "region_name": "A장소", "start_x": 127.00, "start_y": 37.50 }
    ]
  }'


# 11. GET /location/point/place/{category} (EDGE FUNCTION)
# default category food
# curl -X GET "http://localhost:54321/functions/v1/location-point-place/drink?x=127.0276&y=37.4979" \
# curl -X GET "http://localhost:54321/functions/v1/location-point-place/cafe?x=127.0276&y=37.4979" \
# curl -X GET "http://localhost:54321/functions/v1/location-point-place/food?x=127.0276&y=37.4979" \
curl -X GET "http://localhost:54321/functions/v1/location-point-place?x=127.0276&y=37.4979" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json"
# local edge func 실행
supabase functions serve --env-file ./.env

# 1. 투표방 생성 (EDGE FUNCTION)
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


# 2. location-meeting (EDGE FUNCTION)
curl -X POST http://localhost:54321/functions/v1/location-meeting \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json"



# 3. polling (TABLE API)
curl --request GET 'http://127.0.0.1:54321/rest/v1/location_result?map_id=eq.{MAP_ID}&select=*,station_info!station_info_map_id_fkey(*)' \
  -H "apikey: SUPABASE_ACCESS_TOKEN" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Accept: application/vnd.pgrst.object+json"



# 4. vote (EDGE FUNCTION)
curl -X POST "http://localhost:54321/functions/v1/location-points-vote/{MAP_ID}" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"share_key\": \"{SHARE_KEY}\"}"



# 5. confirm (TABLE API)
curl --request PATCH \
  'http://127.0.0.1:54321/rest/v1/location_result?map_id=eq.73f8aaaa-e86e-46ca-8622-3b7ca570b8a5&map_host_id=eq.aaaa8f37' \
  -H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0" \
  -H "Content-Type: application/json" \
  -d '{ "confirmed": "05a8662d-08e8-4971-b77a-866c8d4f9c2f" }'
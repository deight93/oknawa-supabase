curl -X POST http://localhost:54321/functions/v1/location-points \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer SUPABASE_ACCESS_TOKEN" \
  -d '{
    "participant": [
     {
       "name": "김동환",
       "start_x": 127.129347097241,
       "start_y": 37.4860140096538
     },
     {
       "name": "김디팔",
       "start_x": 127.113273744844,
       "start_y": 37.5064595683176
     },
       {
         "name": "김띨팔",
         "start_x": 126.917252,
         "start_y": 37.494990
       }
   ]
  }'


curl -X POST http://localhost:54321/functions/v1/meeting \
  -H 'Authorization: Bearer SUPABASE_ACCESS_TOKEN' \
  -H 'Content-Type: application/json'
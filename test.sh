border()
{
    title="[ $1 ]"
    edge=$(echo "$title" | sed 's/./=/g')
    echo -e "$edge"
    echo -e "$title"
    echo -e "$edge"
}

# Basic Authorization is passed inthe form of "Authorization: Basic CLINET_NAME:CLIENT_SECRET"
# CLINET_NAME:CLIENT_SECRET must be Base64 encoded
# Use https://www.blitter.se/utils/base64-decoder-and-encoder/ to encode and decode

border "Using Token for username:password wael:wael"
export access_token=$(\
   curl -s -X POST http://localhost:8180/auth/realms/auth-demo/protocol/openid-connect/token \
   -H 'Authorization: Basic YXBpLXNlcnZpY2U6YmZlYjczZDUtNTFiYS00YjRlLWI0NWYtYTYwMzA5ZTBmM2Y5' \
   -H 'content-type: application/x-www-form-urlencoded' \
   -d 'username=wael&password=wael&grant_type=password' | jq --raw-output '.access_token' \
)

#echo -e "\033[5m\033[42mTest user role to access /api/user \033[0m"
echo -e "\033[7mTest user role to access /api/user \033[0m"
export response=$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/user -H "Authorization: Bearer "$access_token)
if [ $response -eq 200 ]
then
echo -e "\033[102mResponse code: "$response
else
echo -e "\033[101mResponse code: "$response
fi
echo -e "Response : "$(curl -s -X GET http://localhost:8080/api/user -H "Authorization: Bearer "$access_token)"\033[0m"

echo -e "---------------------------------------------------"

echo -e "\033[7mTest admin role to access /api/admin \033[0m"
export response=$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/admin -H "Authorization: Bearer "$access_token)
if [ $response -eq 200 ]
then
echo -e "\033[102mResponse code: "$response
else
echo -e "\033[101mResponse code: "$response
fi
#echo -e "\033[101mResponse code: "$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/admin -H "Authorization: Bearer "$access_token)"\033[0m"
echo -e "Response : "$(curl -s -X GET http://localhost:8080/api/admin -H "Authorization: Bearer "$access_token)"\033[0m"

echo -e "---------------------------------------------------"

echo -e "\033[7mTest API Key (Claim) to access /api/claim \033[0m"
export response=$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/claim?api-key=123456 -H "Authorization: Bearer "$access_token)
if [ $response -eq 200 ]
then
echo -e "\033[102mResponse code: "$response
else
echo -e "\033[101mResponse code: "$response
fi
#echo -e "\033[105mResponse code: "$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/claim?api-key=123456 -H "Authorization: Bearer "$access_token)"\033[0m"
#echo -e "Response : "$(curl -s -X GET http://localhost:8080/api/claim?api-key=123456 -H "Authorization: Bearer "$access_token)"\033[0m"
echo -e "Response : "$(curl -s -X GET http://localhost:8080/api/claim?api-key=123456 -H "Authorization: Bearer "$access_token)"\033[0m"


border "Using Token for username:password alice:alice"
export access_token=$(\
   curl -s -X POST http://localhost:8180/auth/realms/auth-demo/protocol/openid-connect/token \
   -H 'Authorization: Basic YXBpLXNlcnZpY2U6YmZlYjczZDUtNTFiYS00YjRlLWI0NWYtYTYwMzA5ZTBmM2Y5' \
   -H 'content-type: application/x-www-form-urlencoded' \
   -d 'username=alice&password=alice&grant_type=password' | jq --raw-output '.access_token' \
)

echo -e "\033[7mTest user role to access /api/user \033[0m"
export response=$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/user -H "Authorization: Bearer "$access_token)
if [ $response -eq 200 ]
then
echo -e "\033[102mResponse code: "$response
else
echo -e "\033[101mResponse code: "$response
fi
#echo -e "\033[102mResponse code: "$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/user -H "Authorization: Bearer "$access_token)"\033[0m"
echo -e "Response : "$(curl -s -X GET http://localhost:8080/api/user -H "Authorization: Bearer "$access_token)"\033[0m"

echo -e "---------------------------------------------------"

echo -e "\033[7mTest admin role to access /api/admin \033[0m"
export response=$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/admin -H "Authorization: Bearer "$access_token)
if [ $response -eq 200 ]
then
echo -e "\033[102mResponse code: "$response
else
echo -e "\033[101mResponse code: "$response
fi
#echo -e "\033[103mResponse code: "$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/admin -H "Authorization: Bearer "$access_token)"\033[0m"
echo -e "Response : "$(curl -s -X GET http://localhost:8080/api/admin -H "Authorization: Bearer "$access_token)"\033[0m"

echo -e "---------------------------------------------------"

echo -e "\033[7mTest API Key (Claim) to access /api/claim \033[0m"
export response=$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/claim?api-key=wrong-value -H "Authorization: Bearer "$access_token)
if [ $response -eq 200 ]
then
echo -e "\033[102mResponse code: "$response
else
echo -e "\033[101mResponse code: "$response
fi
#echo -e "\033[105mResponse code: "$(curl -s -o /dev/null -w "%{http_code}" -X GET http://localhost:8080/api/claim?api-key=wrong-value -H "Authorization: Bearer "$access_token)"\033[0m"
echo -e "Response : "$(curl -s -X GET http://localhost:8080/api/claim?api-key=wrong-value -H "Authorization: Bearer "$access_token)"\033[0m"

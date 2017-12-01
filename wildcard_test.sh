WILDCARD_EXPECTED="[GET] file.txt[POST] file.txt[GET] path/to/file.txt[POST] path/to/file.txt[GET] path/to/file.txt[POST] path/to/file.txt[GET] path/to/file.txt[POST] path/to/file.txt[GET] path/file.txt[POST] path/file.txt"
WILDCARD_RESULT=$(curl -sL -X GET http://localhost:3000/files/file.txt; \
curl -sL -X POST http://localhost:3000/files/file.txt; \
curl -sL -X GET http://localhost:3000/files/path/to/file.txt; \
curl -sL -X POST http://localhost:3000/files/path/to/file.txt; \
curl -sL -X GET http://localhost:3000/files/path/to//file.txt; \
curl -sL -X POST http://localhost:3000/files/path/to//file.txt; \
curl -sL -X GET http://localhost:3000/files/path/to/./file.txt; \
curl -sL -X POST http://localhost:3000/files/path/to/./file.txt; \
curl -sL -X GET http://localhost:3000/files/path/to/../file.txt; \
curl -sL -X POST http://localhost:3000/files/path/to/../file.txt);

if [ "$WILDCARD_RESULT" != "$WILDCARD_EXPECTED" ]; then
        echo "FAIL wildcard test"
        echo $(diff <(echo -e "$WILDCARD_RESULT") <(echo -e "$WILDCARD_EXPECTED"))
        exit 1
else
        echo "(ok) wildcard test"
        exit 0
fi

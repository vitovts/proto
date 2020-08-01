#HTTP



Get/HTTP1.1 (запрос) ---->>> ||| <<<<---  (ответ) HTTP 1.0/ 200 ok

Brouzer - -->>> JavaScript interp...

GET == POST
1. создает /// отправляет
2. get игнорирует body



### https://habr.com/ru/post/335158/ ###
Способы отправки данных:
1. SOAP
2. REST  (GET /books/1) <<<--JSON
3. GRAPHQL (GET /graphql?query={ book(id: "1") { title, author { firstName } } }) <<<---JSON
    (type /// input)




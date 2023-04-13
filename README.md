lib
    - firebase (база данных) 
        - auth (авторизация) [auth_controller.dart, seller_auth_controller.dart, logout]
            - auth_controller.dart (авторзациия покупателя)
            - seller_auth_controller.dart (авторизация продавца)
            - logout - выход из аккаунта
        - ...coming soon... (получение данных)
    - models
    - view (визуал)
        - auth (страницы автризации)
        - chat (страницы чата)
        - customWidgets (кастомные виджеты)
        - mainPages (страницы главного экрана)
    - main.dart

архитектура "похер что где, главное что всё понятно и работает"

Слушай сюда, да не отвлекайся. В каталоге "Firebase" все нужные коннекты, стоит перенести всю связь из файлов с визуализацией сюда, чтобы 
не путаться.
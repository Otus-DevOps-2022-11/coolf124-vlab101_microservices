# coolf124-vlab101_microservices
coolf124-vlab101 microservices repository
#ДЗ docker-2
#создан image docker redit 
#image redit загружен на docker hub https://hub.docker.com/r/coolf124/otus-reddit
#image запущен на локальном ПК docker run --name reddit -d -p 9292:9292 coolf124/otus-reddit:1.0
#есть проблема с образом , почему то не работает самое приложение reddit - после нажатия на любую кнопку
#приложение начинает показывать код html вместо вывода форм <h2>Log In</h2> <form action='/login' method='post' role='form'> <div class='form-group'> <label for='username'>Username:</label> <input class='form-control' id='username' name='username' placeholder='Your username'> </div> <div class='form-group'> <label for='password'>Password:</label> <input class='form-control' id='password' name='password' placeholder='Your password'> </div> <div class='form-group'> <input class='btn btn-primary' type='submit' value='Log in'> </div> </form> 

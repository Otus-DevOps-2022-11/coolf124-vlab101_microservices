# coolf124-vlab101_microservices
coolf124-vlab101 microservices repository
#ДЗ docker-2
#создан image docker redit 
#image redit загружен на docker hub https://hub.docker.com/r/coolf124/otus-reddit
#image запущен на локальном ПК docker run --name reddit -d -p 9292:9292 coolf124/otus-reddit:1.0
#есть проблема с образом , почему то не работает самое приложение reddit - после нажатия на любую кнопку
#приложение начинает показывать код html вместо вывода форм <h2>Log In</h2> <form action='/login' method='post' role='form'> <div class='form-group'> <label for='username'>Username:</label> <input class='form-control' id='username' name='username' placeholder='Your username'> </div> <div class='form-group'> <label for='password'>Password:</label> <input class='form-control' id='password' name='password' placeholder='Your password'> </div> <div class='form-group'> <input class='btn btn-primary' type='submit' value='Log in'> </div> </form>
#ДЗ docker-3
#1) скачан и распакован арх  с приложением в папку /src
#2) созданы Dokerfile файлы (3 шт) для контейнеров с сервисами
#3) создан скрипт /src/start4_reddit.sh для запуска контейнров
#4) создана сеть для приложения
docker network create reddit
#5) изменен image ui на ruby-2.6.5-alpine

#ДЗ-19.Устройство Gitlab CI. Построение процесса непрерывной интеграции 
# gitlab-ci-1
Создана новая ветка gitlab-ci-1
Развернута ВМ для gitlab с помощью скрипта
На ВМ установлен Docker С помощью docker-machine
СОзданы директории под data volumes, docker-compose.yml
Запущен контейнер Gitlab
Изменен пароль на repository
Созданы новая группа homework и  новый проект example
Добавлен к  coolf124-vlab101_microservices\gitlab-ci-1  remote branch c названием  gitlab-ci-1  к репо git@62.84.125.180:homework/example.git
Создан pipeline .gitlab-ci.yml
Добавлен gitlab-runner в виде контейнера
    docker run -d --name gitlab-runner --restart always -v /srv/gitlab-
    runner/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock
    gitlab/gitlab-runner:latest
Gitlab-runner зарегистрирован с помощью  действия
    docker exec -it gitlab-runner gitlab-runner register \
    --url http://<your-ip>/ \
    --non-interactive \
    --locked=false \
    --name DockerRunner \
    --executor docker \
    --docker-image alpine:latest \
    --registration-token <your-token> \
    --tag-list "linux,xenial,ubuntu,docker" \
    --run-untagge
Добавлен исходный код reddit 
    git clone https://github.com/express42/reddit.git && rm -rf ./reddit/.git
    git add reddit/
    git commit -m "Add reddit app"
    git push gitlab gitlab-ci-1
Добавлены тесты в pipeline
Добавлена библиотека rack-test в файл reddit/Gemfile
Добавлено окружения dev
Добавлены этапы Staging и Production и новые окружения
Добавлено условия проверки тега для запуска этапа Production
Добавлены диномические окружения 
    ...
    branch review:
    stage: review
    script: echo "Deploy to $CI_ENVIRONMENT_SLUG"
    environment:
    name: branch/$CI_COMMIT_REF_NAME
    url: http://$CI_ENVIRONMENT_SLUG.example.com
    only:
    - branches
    except:
    - master
    staging:
    ...
Выполнено задание с *10.1*. Запуск reddit в контейнере через этап build. Файл сохранен в .gitlab-ci.yml.0
    build_job:
  image: docker:stable
  stage: build
  script:
    - echo 'Building'
    - docker info
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - cd reddit
    - docker pull $CI_REGISTRY_USER/reddit:latest  || true  
    - docker build  --cache-from $CI_REGISTRY_USER/reddit:latest -t $CI_REGISTRY_USER/reddit:gitlab-$CI_COMMIT_SHORT_SHA -t $CI_REGISTRY_USER/reddit:latest . 
    - docker run --name "reddit_gitlab_$CI_ENVIRONMENT_SLUG_$CI_COMMIT_SHORT_SHA" -d -p 9292 $CI_REGISTRY_USER/reddit:gitlab-$CI_COMMIT_SHORT_SHA
    - apk add curl
    - build_env_ip=$(curl ipinfo.io/ip)
    - echo "reddit_gitlab_$CI_ENVIRONMENT_SLUG_$CI_COMMIT_SHORT_SHA"
    - cut --help
    - head --help
    - sleep 7
    - build_env_reddit_port=$(docker port "reddit_gitlab_$CI_ENVIRONMENT_SLUG_$CI_COMMIT_SHORT_SHA" 9292/tcp | head -1 | cut -d ':' -f 2)
    - cd ..
    - touch build.env
    - echo "env_build_env_ip=$build_env_ip" >> build.env
    - echo "env_build_env_reddit_port=$build_env_reddit_port" >> build.env
    - echo "Finished build actions"
    - docker push $CI_REGISTRY_USER/reddit:gitlab-$CI_COMMIT_SHORT_SHA
    - docker push $CI_REGISTRY_USER/reddit:latest 
  artifacts:
    reports:
      dotenv: build.env
Выполнено задание 10.2*. Автоматизация развёртывания GitLab Runner (по желанию) через скрипт /gitlab/create-gitlab-runner.sh
Выполнено задание 10.3 10.3*. Настройка оповещений в Slack (вместо slack настроен telegram). В сообщение указаны актуальная ветки, hash commit, ссылка на развернутое в контейнере приложение
   branch review:
  stage: review
  script: 
    - echo "Deploy to $CI_ENVIRONMENT_SLUG"
    - echo "http://$env_build_env_ip:$env_build_env_reddit_port"
    - apk add curl
    - 'curl -X POST -H "Content-Type: application/json" -d "{\"chat_id\": \"-852858068\", \"text\": \"CI Gitlab: Для ветки $CI_COMMIT_REF_NAME загружен новый commit $CI_COMMIT_SHORT_SHA, посмотреть приложение: http://$env_build_env_ip:$env_build_env_reddit_port\"}" https://api.telegram.org/bot$TOKEN_ID/sendMessage '
  needs:
    - job: build_job
      artifacts: true


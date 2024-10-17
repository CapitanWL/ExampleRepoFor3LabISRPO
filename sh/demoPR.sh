#!/bin/bash

LOG_FILE="../logs/logFileByCpt.txt"

log()
{
echo "$(date '+%F %H:%M:%S') --- $1" >> $LOG_FILE
}

# Настройки
GITHUB_TOKEN="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"
REPO="CapitanWL/ExampleRepoFor3LabISRPO"
BASE_BRANCH="master"
FEATURE_BRANCH="advanced-feature"
PR_TITLE="Pull Request: Объединение $FEATURE_BRANCH в $BASE_BRANCH"
PR_BODY="Pull Request для объединения ветки $FEATURE_BRANCH в $BASE_BRANCH."

log "------------------------"
log "Скрипт 5. Операции с удаленными репозиториями."

if [[ $# -eq 0 ]]; then

# скрипт запущен без параметров

echo "переключение на ветку test..."
log "переключение на ветку test..."

git switch test

echo "коммит неотслеживаемых локальных изменений (если они присутствуют)"
log "коммит неотслеживаемых локальных изменений"

git add .

if ! git commit; then
echo "не удалось добавить в ОБД изменения, тк рабочее дерево не изменялось"
fi
    echo "пуш изменений на удаленный репозиторий..."
    if ! git push origin test; then
        echo "Не удалось отправить изменения на удаленный репозиторий"
        log "Не удалось отправить изменения на удаленный репозиторий"
    else

    echo "выполняется сравнение различий между веткой master и advanced-feature посредством git diff..."
    log "сравнение различий между ветками master и advanced-feature (diff)"

    git diff master advanced-feature

    echo "создание pull request с помощью API GitHub..."
    log "создание pull request с помощью API GitHub"

curl -v -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$REPO/pulls \
  -d @- <<EOF
{
  "title": "$PR_TITLE",
  "body": "$PR_BODY",
  "head": "$FEATURE_BRANCH",
  "base": "$BASE_BRANCH"
}
EOF
fi

else

echo "Вы ввели неверное кол-во параметров для скрипта. Запустите скрипт без параметров."

fi
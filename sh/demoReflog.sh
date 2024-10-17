#!/bin/bash

LOG_FILE="logFileByCpt.log"

log()
{
echo "$(date '+%F %H:%M:%S') --- $1" >> $LOG_FILE
}

log "Скрипт 4. Откат коммитов и работа с reflog."

# скрипт запущен с двумя параметрами (название ветки и хэш коммита)"

log "---------------------"

if [[ $# -eq 2 ]]; then

log "скрипт запущен с двумя параметрами (название ветки и хэш коммита)"

BRANCH_NAME=$1
COMMIT_HASH=$2

git switch "$BRANCH_NAME" || { 
    echo "Ошибка: не удалось переключиться на ветку '$BRANCH_NAME'."
    log "Ошибка: не удалось переключиться на ветку '$BRANCH_NAME'."
    exit 1 
}

git revert "$COMMIT_HASH" || {
    echo "Ошибка: не удалось откатить коммит '$COMMIT_HASH'."
    log "Ошибка: не удалось откатить коммит '$COMMIT_HASH'."
    exit 1
}
log "Откат ветки '$BRANCH_NAME' до коммита '$COMMIT_HASH' с помощью revert."

echo "Доступные коммиты:"
git reflog

echo "Доступные коммиты:"
git reflog

read -p "Введите хэш коммита для восстановления: " COMMIT_HASH
git reset --hard "$RESTORE_COMMIT_HASH" || {
    echo "Ошибка: не удалось восстановить коммит '$RESTORE_COMMIT_HASH'."
    log "Ошибка: не удалось восстановить коммит '$RESTORE_COMMIT_HASH'."
    exit 1
}
echo "Восстановлен коммит '$RESTORE_COMMIT_HASH' в ветке '$BRANCH_NAME'."
log "Восстановлен коммит '$RESTORE_COMMIT_HASH' в ветке '$BRANCH_NAME'."

log "Скрипт завершен успешно."
log "------------------------"

elif [[ $# -eq 0 ]]; then

# скрипт запущен с параметрами по умолчанию

log "скрипт запущен с параметрами по умолчанию"

BRANCH_NAME="advanced-feature"

git switch "$BRANCH_NAME" || { 
    echo "Ошибка: не удалось переключиться на ветку '$BRANCH_NAME'."
    log "Ошибка: не удалось переключиться на ветку '$BRANCH_NAME'."
    exit 1 
}

git log
read -p "Введите хэш коммита для отката: " COMMIT_HASH

git revert "$COMMIT_HASH" || {
    echo "Ошибка: не удалось откатить коммит '$COMMIT_HASH'."
    log "Ошибка: не удалось откатить коммит '$COMMIT_HASH'."
    exit 1
}
log "откат ветки '$BRANCH_NAME' до коммита '$COMMIT_HASH' с помощью revert"

echo "Доступные коммиты:"
git reflog

read -p "Введите хэш коммита для восстановления: " COMMIT_HASH
git reset --hard "$COMMIT_HASH" || {
    echo "Ошибка: не удалось восстановить коммит '$COMMIT_HASH'."
    log "Ошибка: не удалось восстановить коммит '$COMMIT_HASH'."
    exit 1
}
echo "Восстановлен коммит '$COMMIT_HASH' в ветке '$BRANCH_NAME'."
log "Восстановлен коммит '$COMMIT_HASH' в ветке '$BRANCH_NAME'."

log "Скрипт завершен успешно."
log "------------------------"

else 

echo "Вы ввели неверное кол-во параметров для скрипта. Запустите скрипт без параметров или двумя параметрами,
 представляющими собой название ветки и хэш коммита."

fi

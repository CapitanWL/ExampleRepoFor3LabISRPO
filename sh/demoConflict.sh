#!/bin/bash

LOG_FILE="logFileByCpt.log"

log()
{
echo "$(date '+%F %H:%M:%S') --- $1" >> $LOG_FILE
}

log "Скрипт 1. Автоматизация слияния и разрешения конфликтов."

# скрипт запущен с 3-мя парметрами

if [[ $# -eq 3 ]]; then

FIRST_BRANCH=$1
SECOND_BRANCH=$2
FILE_NAME=$3

log "Скрипт запущен с параметрами $1, $2, $3."

# работа с первой веткой

echo "Переключение на ветку $FIRST_BRANCH..."
log "Переключение на ветку $FIRST_BRANCH..."
git switch $FIRST_BRANCH || 
{
echo "Ошибка переключения на ветку $FIRST_BRANCH";
log "Ошибка переключения на ветку $FIRST_BRANCH";
exit 1;
}

echo "Добавление изменений в файл $FILE_NAME..."
log "Добавление изменений в файл $FILE_NAME..."

echo "Изменение в файле на ветке $FIRST_BRANCH" >> $FILE_NAME  ||
{
    echo "Ошибка изменения файла $FILE_NAME на ветке $FIRST_BRANCH";
    log "Ошибка изменения файла $FILE_NAME на ветке $FIRST_BRANCH";
    exit 1;
}

git add $FILE_NAME
git commit -m "Изменение файла $FILE_NAME в ветке $FIRST_BRANCH"
log "Коммит изменений файла $FILE_NAME в ветке $FIRST_BRANCH выполнен."

# работа со второй веткой

echo "Переключение на ветку $SECOND_BRANCH..."
log "Переключение на ветку $SECOND_BRANCH..."
git switch $SECOND_BRANCH ||
{
echo "Ошибка переключения на ветку $SECOND_BRANCH";
log "Ошибка переключения на ветку $SECOND_BRANCH";
exit 1;
}

echo "Добавление изменений в файл $FILE_NAME..."
log "Добавление изменений в файл $FILE_NAME..."

echo "Изменение в файле в ветке $SECOND_BRANCH" >> $FILE_NAME  ||
{
    echo "Ошибка изменения файла $FILE_NAME в ветке $SECOND_BRANCH";
    log "Ошибка изменения файла $FILE_NAME в ветке $SECOND_BRANCH";
    exit 1;
}
git add $FILE_NAME
git commit -m "Изменение файла $FILE_NAME в ветке $SECOND_BRANCH"
log "Коммит изменений файла $FILE_NAME в ветке $SECOND_BRANCH выполнен."

echo "Слияние веток $FIRST_BRANCH и $SECOND_BRANCH..."
log "Слияние веток $FIRST_BRANCH и $SECOND_BRANCH..."

if ! git merge $FIRST_BRANCH; then
    log "Конфликт при слиянии веток. Запуск редактора для разрешения конфликта."
    git mergetool
    log "Конфликт разрешен. Завершение слияния."
    git commit -m "Разрешение конфликта между $FIRST_BRANCH и $SECOND_BRANCH"
else
    log "Слияние прошло успешно без конфликтов."
fi

log "Скрипт завершен успешно."
log "------------------------"


elif [[ $# -eq 0 ]]; then

log "Скрипт 1. Автоматизация слияния и разрешения конфликтов."

# скрипт запущен с параметрами по умолчанию

FIRST_BRANCH="advanced-feature"
SECOND_BRANCH="test"
FILE_NAME="TestFile.md"

log "Скрипт запущен с параметрами по умолчанию."
echo "Скрипт запущен с параметрами по умолчанию."

# работа с первой веткой

echo "Переключение на ветку $FIRST_BRANCH..."
log "Переключение на ветку $FIRST_BRANCH..."
git switch $FIRST_BRANCH || 
{
echo "Ошибка переключения на ветку $FIRST_BRANCH";
log "Ошибка переключения на ветку $FIRST_BRANCH";
exit 1;
}

echo "Добавление изменений в файл $FILE_NAME..."
log "Добавление изменений в файл $FILE_NAME..."

echo "Изменение в файле на ветке $FIRST_BRANCH" >> $FILE_NAME  ||
{
    echo "Ошибка изменения файла $FILE_NAME на ветке $FIRST_BRANCH";
    log "Ошибка изменения файла $FILE_NAME на ветке $FIRST_BRANCH";
    exit 1;
}

git add $FILE_NAME
git commit -m "Изменение файла $FILE_NAME в ветке $FIRST_BRANCH"
log "Коммит изменений файла $FILE_NAME в ветке $FIRST_BRANCH выполнен."

# работа со второй веткой

echo "Переключение на ветку $SECOND_BRANCH..."
log "Переключение на ветку $SECOND_BRANCH..."
git switch $SECOND_BRANCH ||
{
echo "Ошибка переключения на ветку $SECOND_BRANCH";
log "Ошибка переключения на ветку $SECOND_BRANCH";
exit 1;
}

echo "Добавление изменений в файл $FILE_NAME..."
log "Добавление изменений в файл $FILE_NAME..."

echo "Изменение в файле в ветке $SECOND_BRANCH" >> $FILE_NAME  ||
{
    echo "Ошибка изменения файла $FILE_NAME в ветке $SECOND_BRANCH";
    log "Ошибка изменения файла $FILE_NAME в ветке $SECOND_BRANCH";
    exit 1;
}
git add $FILE_NAME
git commit -m "Изменение файла $FILE_NAME в ветке $SECOND_BRANCH"
log "Коммит изменений файла $FILE_NAME в ветке $SECOND_BRANCH выполнен."

echo "Слияние веток $FIRST_BRANCH и $SECOND_BRANCH..."
log "Слияние веток $FIRST_BRANCH и $SECOND_BRANCH..."

if ! git merge $FIRST_BRANCH; then
    log "Конфликт при слиянии веток. Запуск редактора для разрешения конфликта."
    git mergetool
    echo "Конфликт разрешен. Завершение слияния."
    log "Конфликт разрешен. Завершение слияния."
    git commit -m "Разрешение конфликта между $FIRST_BRANCH и $SECOND_BRANCH"
else
    log "Слияние прошло успешно без конфликтов."
fi

log "Скрипт завершен успешно."
log "------------------------"

else

echo "Вы передали кол-во параметров >3 || >0 && <3. Передайте в качестве параметров название двух веток и файла для редактирования.
Например: sh sc1.sh master test readme.md"
log "Ошибка выполнения скрипта из-за неверного количествва параметров."
log "------------------------"

fi
#!/bin/bash

# Путь к лог-файлу
LOG_FILE="/var/log/monitoring.log"
PROCESS_NAME="test"
MONITORING_URL="https://test.com/monitoring/test/api"
PREV_PID_FILE="/tmp/test_pid"

# Функция записи в лог
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Проверка наличия процесса
PROCESS_PID=$(pgrep -x "$PROCESS_NAME")

if [ -n "$PROCESS_PID" ]; then
    # Если процесс найден
    if [ -f "$PREV_PID_FILE" ]; then
        # Если файл с PID существует, проверим, не изменился ли процесс
        PREV_PID=$(cat "$PREV_PID_FILE")
        if [ "$PREV_PID" != "$PROCESS_PID" ]; then
            # Если PID изменился (процесс был перезапущен)
            log_message "Процесс $PROCESS_NAME был перезапущен. Новый PID: $PROCESS_PID"
        fi
    fi

    # Обновим PID процесса в файле
    echo "$PROCESS_PID" > "$PREV_PID_FILE"

    # Проверка доступности сервера мониторинга
    if curl --silent --head --fail "$MONITORING_URL" > /dev/null; then
        # Стучимся на сервер мониторинга
        curl -s -X POST "$MONITORING_URL"
    else
        # Логируем ошибку, если сервер не доступен
        log_message "Ошибка: сервер мониторинга $MONITORING_URL недоступен."
    fi
fi
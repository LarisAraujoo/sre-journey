#!/bin/bash

# Cores
VERDE="\e[32m"
AMARELO="\e[33m"
VERMELHO="\e[31m"
AZUL="\e[36m"
RESET="\e[0m"

echo -e "${AZUL}Monitoramento rápido do sistema${RESET}"
echo "_____________"
echo -E "Data/Hora: ${VERDE}$(date)${RESET}"
echo ""

# Usuário e Host

echo -e "${AMARELO}Usuário logado:${RESET} $(whoami)"
echo -e "${AMARELO}Hostname:${reset} $(hostname)"
echo ""

# Uso de Disco com alerta
echo -e "${AZUL}Uso de disco:${RESET}"
DISK_USE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
df -h /

if [ "$DISK_USE" -ge 80]; then
    echo -e "${VERMELHO}[ALERTA] Disco acima de 80% (${DISK_USE}%)${RESET}"
else
    echo -e "${VERDE}Disco OK (${DISCK_USE}%)${RESET}"
fi
echo ""

# Memória

echo -e "${AZUL}Memória atual:${RESET}"
free -h
echo ""

# Load Average
echo -e "${AZUL} Carga do sistema (Load Average):${RESET}"
LOAD=$(uptime | awk -F 'LOAD AVERAGE:' '{PRINT $2}')
echo -e "${VERDE}${LOAD}${RESET}"
echo ""

# Top 5 processos por uso de CPU
echo -e "${AZUL}Top 5 processos por CPU:${RESET}"
ps -eo pid,ppid,cmd,%cpu  --sort=-%cpu | head -n 6
echo ""

# Top 5 processos por uso de memória
echo -e "${AZUL}Top 5 processos por memória:${RESET}"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6
echo ""

# Log automático
LOG_FILE="monitor.log"
echo -e "\n[+] Salvando saída no arquivo $LOG_FILE..."
echo "========== $(date) ==========" >> $LOG_FILE
./monitor.sh 2> /dev/null >> $LOG_FILE

echo -e "${VERDE}Monitoramento concluído!${RESET}"

#!/bin/bash

echo "Monitoramento rápido do sistema"
echo "_____________"
echo "Usuário logado: $(whoami)"
echo "Hostname: $(hostname)"
echo "Uso de disco:"
df -h /
echo "Memória atual:"
free -h
echo "Processos ativos (top 5 por uso de memória):"
ps aux --sort=-%mem | head -5

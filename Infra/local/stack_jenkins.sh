#!/bin/bash

#Criado por: Melquis Marques
#Data: 11/04/22


echo "O que deseja fazer?"
echo "1. Criar a Stack Jenkins do Lab"
echo "2. Executar a Stack Jenkins do Lab"
echo "3. Parar a Stack Jenkins do Lab"
echo "4. Destruir a Stack Jenkins do Lab"
echo "5. Não executar a Stack Jenkins do Lab"
echo -n "Escolha uma das opções acima [1,2,3]: "
read VAR

if [ $VAR = 1 ] 
then
  #Setar valores requeridos para o SonarQube
  echo "*****************************************************************"
  echo "****** Setando parametros de host requeridos pelo SonarQube. ****"
  echo "***************## REQUER ACESSO ROOT DA MÁQUINA ##***************"
  echo "*****************************************************************"
  echo ""
  sudo sysctl -w vm.max_map_count=524288
  sudo sysctl -w fs.file-max=131072
  ulimit -n 131072
  ulimit -u 8192
  #Subir a Stack do Lab
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "**************** Criando a Stack Jenkins do Lab. *****************"
  echo "*****************************************************************"
  echo ""
  docker compose up -d
  sleep 45
  docker exec -it -u 0 jenkins chmod 666 /var/run/docker.sock
  clear
  echo ""
  echo "*****************************************************************"
  echo "************** Verificando se o ambiente subiu OK. **************"
  echo "*****************************************************************"
  echo ""
  docker compose ps
  echo ""
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "********** Stack criada e inicializada com sucesso! *************"
  echo "*****************************************************************" 
  echo ""

elif [ $VAR = 2 ] 
then
  #Setar valores requeridos para o SonarQube
  echo "*****************************************************************"
  echo "****** Setando parametros de host requeridos pelo SonarQube. ****"
  echo "***************## REQUER ACESSO ROOT DA MÁQUINA ##***************"
  echo "*****************************************************************"
  echo ""
  sudo sysctl -w vm.max_map_count=524288
  sudo sysctl -w fs.file-max=131072
  ulimit -n 131072
  ulimit -u 8192
  #Subir a Stack do Lab
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "**************** Subindo a Stack Jenkins do Lab. *****************"
  echo "*****************************************************************"
  echo ""
  docker compose start
  sleep 45
  clear
  echo ""
  echo "*****************************************************************"
  echo "************** Verificando se o ambiente subiu OK. **************"
  echo "*****************************************************************"
  echo ""
  docker compose ps
  echo ""
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "************** Stack inicializada com sucesso! ******************"
  echo "*****************************************************************" 
  echo ""

elif [ $VAR = 3 ] 
then
  #Parar a Stack do Lab
  echo ""
  echo "*****************************************************************"
  echo "**************** Parando a Stack Jenkins do Lab. *****************"
  echo "*****************************************************************"
  echo ""
  docker compose stop
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "************** Verificando se o ambiente parou OK. **************"
  echo "*****************************************************************"
  echo ""
  docker compose ps
  echo ""
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "***************** Stack parada com sucesso! *********************"
  echo "*****************************************************************" 
  echo ""

elif [ $VAR = 4 ] 
then
  #Parar a Stack do Lab
  echo ""
  echo "*****************************************************************"
  echo "************** Destruindo a Stack Jenkins do Lab. ****************"
  echo "*****************************************************************"
  echo ""
  docker compose down
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "************** Verificando se o ambiente parou OK. **************"
  echo "*****************************************************************"
  echo ""
  docker compose ps
  echo ""
  sleep 5
  clear
  echo ""
  echo "*****************************************************************"
  echo "***************** Stack parada com sucesso! *********************"
  echo "*****************************************************************" 
  echo ""

else
  echo "*****************************************************************"
  echo "**************** Nenhum comando foi executado!!! ****************"
  echo "*****************************************************************"
fi
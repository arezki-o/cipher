root@soc-mgmt-server:/home/ecs-user/workspace/agents-logs-monitoring/bin# ls -al
total 60
drwxrwxr-x 2 ecs-user ecs-user 4096 Jan  9 19:01 .
drwxrwxr-x 5 ecs-user ecs-user 4096 Jul 23  2024 ..
-rwxrwxr-x 1 ecs-user ecs-user 2081 May 16  2024 backup.sh
-rwxr-xr-x 1 root     root     5086 Jun 12  2024 bck.sh
-rwxr-xr-x 1 ecs-user ecs-user 6442 Jan  9 19:01 monitor_agents_logs.new
-rwxr-xr-x 1 ecs-user ecs-user 6438 Jan  9 18:36 monitor_agents_logs.sh
-rwxr-xr-x 1 ecs-user ecs-user 5382 Jul 14  2024 monitor_agents_logs.sh.20241202
-rwxr-xr-x 1 ecs-user ecs-user 5147 Jul  2  2024 script.sh.20240714
-rwxr-xr-x 1 ecs-user ecs-user  636 Dec  3 15:48 start_monitor_agents_logs_hrc.sh
-rwxr-xr-x 1 ecs-user ecs-user 2705 Sep 17 15:55 start_monitor_agents_logs.sh
root@soc-mgmt-server:/home/ecs-user/workspace/agents-logs-monitoring/bin# cat start_monitor_agents_logs.sh
#!/bin/bash

WORK_DIR=/home/ecs-user/workspace/agents-logs-monitoring
BIN_DIR=$WORK_DIR/bin
TMP_DIR=$WORK_DIR/tmp

SCRIPT=$BIN_DIR/monitor_agents_logs.sh

cd $TMP_DIR

#
# Start Monitoring Agents Logs
#
echo "`date` : Starting Monitoring Agents Logs ..."

# Monitoring Cipher Logs
echo "`date` : Monitoring Cipher Agents Logs ..."
#$SCRIPT "https://ecipher.ciphersa.net" "https://kcipher.ciphersa.net" "elastic" "tm4743XYBIq09no9miV043zt" "cipher"

# Monitoring Misk Logs
echo "`date` : Monitoring Misk Agents Logs ..."
$SCRIPT "https://emisk.ciphersa.net" "https://kmisk.ciphersa.net" "elastic" "k5J7K7s5t0o2p9X1TK5X4zzC" "misk"

# Monitoring WTTCO Logs
echo "`date` : Monitoring WTTCO Agents Logs ..."
$SCRIPT "https://ewttco.ciphersa.net" "https://kwttco.ciphersa.net" "elastic" "cfR7V993Cu63hbo77nyzj60i" "wttco"

# Monitoring JDA Logs
echo "`date` : Monitoring JDA Agents Logs ..."
$SCRIPT "https://ejda.ciphersa.net" "https://kjda.ciphersa.net" "elastic" "rOfjzJ180y94UA2199H1yTKy" "jda"

# Monitoring HRC Logs
echo "`date` : Monitoring HRC Agents Logs ..."
$SCRIPT "https://ehrc.ciphersa.net" "https://khrc.ciphersa.net" "elastic" "Q9Wmj7n0uNJ4VH1R6M4e1S29" "hrc"

# Monitoring KSF Logs
echo "`date` : Monitoring KSF Agents Logs ..."
$SCRIPT "https://eksf.ciphersa.net" "https://kksf.ciphersa.net" "elastic" "6f26774Q9Hx9lAfs4tW9DJsg" "ksf"

# Monitoring OSH Logs
echo "`date` : Monitoring OSH Agents Logs ..."
$SCRIPT "https://eosh.ciphersa.net" "https://kosh.ciphersa.net" "elastic" "R8EHW92a47cg1r7MhS96Ii3f" "osh"

# Monitoring FA Logs
echo "`date` : Monitoring FA Agents Logs ..."
$SCRIPT "https://efa.ciphersa.net" "https://kfa.ciphersa.net" "elastic" "ftmu3W74N87Ubv8xjJee1586" "fa"

# Monitoring SVC Logs
echo "`date` : Monitoring SVC Agents Logs ..."
$SCRIPT "https://esvc.ciphersa.net" "https://ksvc.ciphersa.net" "elastic" "OrTd63tN59FOSa5753X8BtP4" "svc"

# Monitoring Innova Logs
echo "`date` : Monitoring Innova Agents Logs ..."
$SCRIPT "https://einnova.ciphersa.net" "https://kinnova.ciphersa.net" "elastic" "64B44crD0Vsk83mTCWb5o7u5" "innova"

# Monitoring Latis Logs
echo "`date` : Monitoring LATIS Agents Logs ..."
$SCRIPT "https://elatis.ciphersa.net" "https://klatis.ciphersa.net" "elastic" "48gTgbf281c34Yf3qlg1TQi9" "latis"

# Monitoring SAIP Logs
echo "`date` : Monitoring SAIP Agents Logs ..."
$SCRIPT "https://esaip.ciphersa.net" "https://ksaip.ciphersa.net" "elastic" "I2j75oM28Q14loUJd3Lf3Ey8" "saip"

# Monitoring Golf Saudi Logs
echo "`date` : Monitoring Golf Saudi Agents Logs ..."
$SCRIPT "https://egolfsaudi.ciphersa.net" "https://kgolfsaudi.ciphersa.net" "elastic" "56791ADI14n6QqQ0eq7bcivZ" "golfsaudi"

echo "`date` : Monitoring Agents Logs finished."

#
# End
#




---------------------


cat monitor_agents_logs.sh
#!/bin/bash

ES_URL=$1
KIBANA_URL=$2
ES_USER=$3
ES_PASS=$4
CUSTOMER=$5
MONITOR_ES_URL="https://emonitor.ciphersa.net"
MONITOR_ES_USER="elastic"
MONITOR_ES_PASS="7qi4y8ej8tNvU3A76SyI702k"

delete_existing_alerts(){


curl -XPOST $ES_URL/.internal.alerts-security.alerts*/_delete_by_query  -H 'Content-Type: application/json' -H 'accept: application/json'  -u $ES_USER:$ES_PASS -d'
{
   "query": {
   "match": {
       "kibana.alert.rule.description": "Monitoring Agents Logs"
   }
   }
}'


}

delete_existing_alerts


delete_source_indice_content(){

curl -XPOST $ES_URL/fleet-agents-logs-state/_delete_by_query  -H 'Content-Type: application/json' -H 'accept: application/json'  -u $ES_USER:$ES_PASS -d'
{
  "query": {
    "match_all": {}
  }
}'

curl -XPOST $MONITOR_ES_URL/fleet-agents-logs-state/_delete_by_query  -H 'Content-Type: application/json' -H 'accept: application/json'  -u $MONITOR_ES_USER:$MONITOR_ES_PASS -d'
{
  "query": {
    "match": {
       "customer.name": "'"$CUSTOMER"'"
   }
  }
}'


}

delete_source_indice_content

echo "--------------------------------------------------Start Server Part-------------------------------------------------------"

get_server_policies_id(){

#curl $KIBANA_URL/api/fleet/agent_policies -H 'accept: application/json' -u $ES_USER:$ES_PASS | jq --arg substring "-server" '.items[] | select(.name | test($substring; "i")) | .id' | sed -e 's/"//g' > server_policies_$CUSTOMER
curl $KIBANA_URL/api/fleet/agent_policies -H 'accept: application/json' -u $ES_USER:$ES_PASS | jq '.items[] | select((.name | contains("server")) or (.name | contains("soc-logger"))) | .id' | sed -e 's/"//g' > server_policies_$CUSTOMER

}

get_server_policies_id

get_server_agents_from_fleet(){

ids=$(awk '{print $0}' server_policies_$CUSTOMER | jq -R -s -c 'split("\n") | map(select(length > 0))')


curl $KIBANA_URL/api/fleet/agents?perPage=900 -H 'accept: application/json' -u $ES_USER:$ES_PASS | jq --argjson ids "$ids" '.list[] | select(.policy_id as $id | $ids | index($id)) | .local_metadata.host.hostname' | sed -e 's/"//g' | sort -n | uniq > server_hostnames_$CUSTOMER

}

get_server_agents_from_fleet

echo "--------------------------------------------------End Server Part-------------------------------------------------------"

echo "--------------------------------------------------Start Workstation Part-------------------------------------------------------"

get_workstation_policies_id(){

curl $KIBANA_URL/api/fleet/agent_policies -H 'accept: application/json' -u $ES_USER:$ES_PASS | jq --arg substring "-workstation" '.items[] | select(.name | test($substring; "i")) | .id' | sed -e 's/"//g' > workstation_policies_$CUSTOMER

}

get_workstation_policies_id

get_workstation_agents_from_fleet(){

ids=$(awk '{print $0}' workstation_policies_$CUSTOMER | jq -R -s -c 'split("\n") | map(select(length > 0))')


curl $KIBANA_URL/api/fleet/agents?perPage=900 -H 'accept: application/json' -u $ES_USER:$ES_PASS | jq --argjson ids "$ids" '.list[] | select(.policy_id as $id | $ids | index($id)) | .local_metadata.host.hostname' | sed -e 's/"//g' | sort -n | uniq > workstation_hostnames_$CUSTOMER

}

get_workstation_agents_from_fleet

echo "--------------------------------------------------End Workstation Part-------------------------------------------------------"

index_document() {
  local hostname=$1
  local type=$2
  local state=$3

  curl -s -u "$ES_USER:$ES_PASS" -X POST "$ES_URL/fleet-agents-logs-state/_doc/" -H 'Content-Type: application/json' -d '{
    "host.name": "'"$hostname"'",
    "host.type": "'"$type"'",
    "logs.status": "'"$state"'"
  }'

  curl -s -u "$MONITOR_ES_USER:$MONITOR_ES_PASS" -X POST "$MONITOR_ES_URL/fleet-agents-logs-state/_doc/" -H 'Content-Type: application/json' -d '{
    "customer.name": "'"$CUSTOMER"'",
    "host.name": "'"$hostname"'",
    "host.type": "'"$type"'",
    "logs.status": "'"$state"'"
  }'
}

for server_hostname in $(< "server_hostnames_$CUSTOMER"); do
  echo -e "\nChecking server hostname: $server_hostname"
  lower_name=`echo $server_hostname | tr '[:upper:]' '[:lower:]'`
  upper_name=`echo $server_hostname | tr '[:lower:]' '[:upper:]'`

  response=$(curl -u "$ES_USER:$ES_PASS" "$ES_URL/logs-*/_search" -H 'Content-Type: application/json' -d '{
    "size": 1,
    "_source": ["host.hostname"],
    "query": {
      "bool": {
        "must": [
          {
            "terms": {
              "host.hostname": ["'"$server_hostname"'", "'"$lower_name"'", "'"$upper_name"'"]
            }
          },
          {
            "range": {
              "@timestamp": {
                "gte": "now-3d/d",
                "lt": "now/d"
              }
            }
          }
        ]
      }
    }
  }' 2>/dev/null)

  hits=$(jq -r '.hits.total.value' <<< "$response")
  if (( hits > 0 )); then
    echo "Server Hostname $server_hostname exists in logs* index with $hits logs."
    index_document "$server_hostname" "Server" "Active"
  else
    echo "Server Hostname $server_hostname does not exist in logs* index."
    index_document "$server_hostname" "Server" "Inactive"
  fi
done

for workstation_hostname in $(< "workstation_hostnames_$CUSTOMER"); do
  echo -e "\nChecking workstation hostname: $workstation_hostname"
  lower_name=`echo $workstation_hostname | tr '[:upper:]' '[:lower:]'`
  upper_name=`echo $workstation_hostname | tr '[:lower:]' '[:upper:]'`

  response=$(curl -u "$ES_USER:$ES_PASS" "$ES_URL/logs-*/_search" -H 'Content-Type: application/json' -d '{
    "size": 1,
    "_source": ["host.hostname"],
    "query": {
      "bool": {
        "must": [
          {
            "terms": {
              "host.hostname": ["'"$workstation_hostname"'", "'"$lower_name"'", "'"$upper_name"'"]
            }
          },
          {
            "range": {
              "@timestamp": {
                "gte": "now-3d/d",
                "lt": "now/d"
              }
            }
          }
        ]
      }
    }
  }' 2>/dev/null)

  hits=$(jq -r '.hits.total.value' <<< "$response")
  if (( hits > 0 )); then
    echo "Workstation Hostname $workstation_hostname exists in logs* index with $hits logs."
    index_document "$workstation_hostname" "Workstation" "Active"
  else
    echo "Workstation Hostname $workstation_hostname does not exist in logs* index."
    index_document "$workstation_hostname" "Workstation" "Inactive"
  fi
done


rm workstation_policies_$CUSTOMER
rm server_policies_$CUSTOMER


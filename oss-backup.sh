 cat /home/ecs-user/workspace/tools/oss-workspace-backup.sh
#!/bin/bash

src_dir="/home/ecs-user/workspace/"
bucket="soc-common-storage"
dst_dir="soc-mgmt-server"

ossutil cp -f --recursive  "$src_dir" "oss://$bucket/$dst_dir/"

if [ $? -eq 0 ]; then
  echo "Backup successfully pushed."
else
  echo "Error"
  exit 1
fi

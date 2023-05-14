git clone https://github.com/ravi568/$2 /app
cd /app

case $1 in
  mongo)
    curl -L https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem -o /app/rds-combined-ca-bundle.pem
    mongo --ssl --host {{ lookup('amazon.aws.aws_ssm','{{env}}.docdb.endpoint', region='us-east-1')}}:27017 --sslCAFile /app/rds-combined-ca-bundle.pem --username "{{ lookup('amazon.aws.aws_ssm', '{{env}}.docdb.user', region='us-east-1')}}" --password "{{ lookup('amazon.aws.aws_ssm', '{{env}}.docdb.pass', region='us-east-1')}}" </app/schema/{{component}}.js

    ;;
  mysql)
    ;;
  *)
    echo schema loading supported for only mongo and mysql
    exit 1
    ;;
esac


#    - name: Download Mongodb pem file
#      ansible.builtin.get_url:
#        url: https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
#        dest: /app/rds-combined-ca-bundle.pem
#
#    - name: Load Schema
#      #ansible.builtin.shell: mongo --host mongodb-dev.kalluriravidevops71.online </app/schema/{{component}}.js
#      ansible.builtin.shell: mongo --ssl --host {{ lookup('amazon.aws.aws_ssm','{{env}}.docdb.endpoint', region='us-east-1')}}:27017 --sslCAFile /app/rds-combined-ca-bundle.pem --username "{{ lookup('amazon.aws.aws_ssm', '{{env}}.docdb.user', region='us-east-1')}}" --password "{{ lookup('amazon.aws.aws_ssm', '{{env}}.docdb.pass', region='us-east-1')}}" </app/schema/{{component}}.js
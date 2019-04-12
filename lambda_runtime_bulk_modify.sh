#!/bin/bash
#This is used to upgrade or downgrade the AWS lambda runtime.
#to get lambda list
region="us-east-1"
check_runtime="nodejs8.10"
upgrade_runtime="nodejs8.10"
aws_profile="fams-sandbox"
file='lambda_function_list.txt'
aws lambda list-functions --profile fams-sandbox --region us-east-1 --query 'Functions[].[FunctionName,Runtime]' --output text | grep $check_runtime | awk '{print $1}' 2>&1 | tee $file
#upgrade or downgrade
for i in `cat $file`
do
function_name=`echo $i`
aws lambda update-function-configuration --region $region --profile $aws_profile --function-name $function_name --runtime $upgrade_runtime --output text
done

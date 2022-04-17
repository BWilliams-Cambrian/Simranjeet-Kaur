#!/bin/bash
Totalusers=0
Totalgroups=0
function username () {
    first=`echo $1`
    last=`echo $2`
    departmentname=`echo $3`
    firstchar=`echo "${first:0:1}"`
    firstchar=`echo "${firstchar,,}"`
    lastchars=`echo "${last:0:7}"`
    lastchars=`echo "${lastchars,,}"`
    departmentname=`echo "${departmentname,,}"`
    departmentname=`echo "${departmentname//$'\r'/}"`
    username=`echo "$firstchar$lastchars"`
}
while IFS="," read -r first last departmentname 
do 
    username $first $last $departmentname
    user_output=`echo "$(awk -F: '{ print $1}' /etc/passwd | grep $username)"`
    if [ -z "$user_output" ];  then
        echo "username doesnt exist = $username"
        echo "creating user $username"
        sudo adduser $username --disabled-password --gecos ""
        ((Totalusers++))
    else 
        echo "This user $username already exist!"
    fi
    echo "Creating different groups for department"
    group_output=`echo "$(sudo awk -F: '{ print $1}' /etc/group | grep ^$departmentname)"`
    if [ -z "$group_output" ]; then
        echo "not an existing group = $departmentname"
        echo "creating group $departmentname"
        sudo /usr/sbin/groupadd $departmentname
        ((Totalgroups++))
    else
        echo "Group $departmentname already exists!"
    fi
    echo "Assigning Group $departmentname to User $username."
    echo "$(sudo usermod -g $departmentname $username)"
done < <(tail -n +2 EmployeeNames.csv)
echo "$Totalusers is number of users created."
echo "$Totalgroups is number of groups created."



#!/bin/bash

mkdir -p EmployeeData/{HR,IT,Finance,Executive,Administrative,'Call Centre'}
cd EmployeeData


sudo chmod 764 -R IT Finance Administrative 'Call Centre'
sudo chmod 760 -R HR Executive
 


sudo chgrp it IT
sudo chgrp hr HR
sudo chgrp finance Finance
sudo chgrp executive Executive
sudo chgrp administrative Administrative
sudo chgrp callcentre 'Call Centre'


echo "7 folders created"

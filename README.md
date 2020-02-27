# proftpd-container-kubernetes
Proftpd image for kubernetes



This is an image docker for use proftpd inside kubernetes enviroment.

**Now is in fast build and config for testing porpouse**



**ConfigMap for kubernetes**

Inside folder ConfigMap we have put 3 configmap that is usefull inside kubernetes in our config
The first file hidden.conf extend config of proftpd.
For detail of the istruction you can read the Doc of proftpd

The second authuserfile is for configure user that can login on proftpd.

For generate this file we report an example command that you can use

`ftpasswd --des --passwd --name ftpguest --home /home/ftpguest --shell /bin/bash --uid 2001`

this command ask for a password and create a file named ftpd.passwd with hashed password with des algorithm 
output example:
`ftpguest:VdQm/1tmKGhlo:2001:2001::/home/ftpguest:/bin/bash`

Now you have to copy the content of ftpd.passwd inside the authuserfile configmap and add a new line for each user you want to define

The last file is group and this file configure the group (or multiple groups) of all user that you want to add to belong.

Define ConfigMap from file
with this command (command line interface) you can define a ConfigMap from file.

`kubectl create configmap hidden.conf --from-file=/path/of/file`
or you can use kubectl apply -f configmapname.yml




**Note:**

Default port on 8021 (Dockerfile set the port)
IPv6 is Disabled, if you want to enable it remove the sed command from Dockerfile.
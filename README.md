# proftpd-container-kubernates
Proftpd image for kubernates



This is an image docker for use proftpd inside kubernates enviroment.



**ConfigMap for kubernates**
Inside folder ConfigMap we have put 3 configmap that is usefull inside kubernates in our config
The first file hidden.conf extend config of proftpd.
For detail of the istruction you can read the Doc of proftpd

The second authuserfile is for configure user that can login on proftpd
For generate this file we report an example command that you can use
`ftpasswd --des --passwd --name ftpguest --home /home/ftpguest --shell /bin/false --uid 2001`
this command ask for a password and create a file named ftpd.passwd with hashed password with des algorithm 
output example:
`ftpguest:VdQm/1tmKGhlo:2001:2001::/home/ftpguest:/bin/false`

Now you have to copy the content of ftpd.passwd inside the authuserfile configmap and add a new line for each user you want to define




**Note:**
IPv6 is Disabled, if you want to enable it remove the sed command from Dockerfile.
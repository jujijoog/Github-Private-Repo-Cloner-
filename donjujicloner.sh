read -p '

Private Github Repo Cloner By Don Juji                                                                                 

Private Github Repo Cloner By Don Juji,  Press Enter To Continue'

clear

read -e -p 'Bro Plz, enter that email, Plz bro?: ' email

read -e -p 'Bro Plz, enter that userpass, Plz bro?: ' userpass

mkdir $email

cd $email 

echo 'Generating SSH'

ssh-keygen -t rsa -b 4096 -C "$email"

echo 'Uploading SSH To Account'

curl -u "$userpass" --data '{"title":"test-key","key":"'"$(cat ~/.ssh/id_rsa.pub)"'"}' https://api.github.com/user/keys

echo 'Downloading Repo List'

curl -u "$userpass" https://api.github.com/user/repos?private=true > repos.txt

echo 'Extracting Repo URLS'

grep -riah -E "clone_url" repos.txt | sed "s/    \"clone_url\": \"//" | sed "s/\",//" > reporun.sh
sed -i "s/https:\/\//git clone https:\/\/$userpass@/" reporun.sh

echo 'Done! Cloning Repos!'

bash reporun.sh

clear

echo 'Finished! DonJuji Loves You!'

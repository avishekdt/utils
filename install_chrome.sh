if google-chrome  --version | grep -q 'Google Chrome 80'; then
   echo "chrome exists"
else
   apt-get update -y  &&
   apt --fix-broken install -y  &&
   apt-get install -y curl wget nano  &&
   echo "Google Chrome doesn't exist"
   echo "installing chrome..."
   apt-get install -y dpkg
   rm /tmp/chrome.deb
   curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output /tmp/chrome.deb
   dpkg -i /tmp/chrome.deb &&
   apt-get install -f &&
   apt install   /tmp/chrome.deb
   apt --fix-broken install -y  &&
   echo "chrome version"  &&
   google-chrome --version
fi
if chromedriver --version | grep -q 'ChromeDriver 80'; then
   echo "chromedriver exists"
else
   echo "chromedriver doesn't exist"
   echo "install chromedriver"
   apt-get install -y  zip unzip &&
   a=$(uname -m) &&
   rm -rf /tmp/chromedriver/
   mkdir /tmp/chromedriver/ &&
   wget -O /tmp/chromedriver/LATEST_RELEASE http://chromedriver.storage.googleapis.com/LATEST_RELEASE
   if [ "$a" == "i686" ]
   then
   	echo "32 bit platfrom"
	b=32
   else
   	echo "64 bit platform"
	b=64
   fi
   # if  ["$a" == "i686"] ; then b=32; elif  ["$a" == "x86_64"] ; then b=64; fi &&
   latest=$(cat /tmp/chromedriver/LATEST_RELEASE) &&
   echo  "downloading from url:"  &&
   echo https://chromedriver.storage.googleapis.com/"$latest"/chromedriver_linux"$b".zip
   curl https://chromedriver.storage.googleapis.com/"$latest"/chromedriver_linux"$b".zip --output /tmp/chromedriver/chromedriver.zip  &&
   unzip /tmp/chromedriver/chromedriver.zip chromedriver -d /usr/local/bin/ &&
   echo "chromedriver version:"  &&
   chromedriver --version  &&
   echo 'success'
fi
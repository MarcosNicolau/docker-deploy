# Automated Docker deployments with bash file

This script is to be run on an instance set up. <br/>
Important, before running the script, make sure you have added the IPV4 to your dns. Otherwise, you won't get https <br/>
If the script fails at some stage, it won't stop, but it doesn't matter, just run it again and everything will be overwritten 
## How to run it

### Cloning the repo 
After cloning the repo
`$ cd docker-deploy` <br/>
Make it executable
`$ chmod +x docker-deploy.bash`<br/>
And finally run it
`$ bash docker-deploy.bash` <br/>
## Steps

1. Prompt for variables which are used during the building
2. Update OS
3. Install Docker
4. Nginx set up
5. Get cerbot certificate
6. Docker login, pull and run
7. Instructions if you want to add http/2

## Enabling HTTP/2

I highly recommend enabling http/2. I could not manage to automate that, so I provided some instructions.
I took them from this link: https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-with-http-2-support-on-ubuntu-18-04.
If you did not understand my explanation about http/2 you can check theirs.

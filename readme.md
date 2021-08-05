# Automated Docker deployments with bash file

This script is to be run on instance set up.

## Steps

1. Update OS
2. Prompt for variables which are used during the building
3. Nginx set up
4. Get cerbot certificate
5. Docker login, pull and run
6. Instruction if you want to add http/2

## Enabling HTTP/2

I highly recommend enabling http/2. I could not manage to automate that, so I provided some instructions.
I took them from this link: https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-with-http-2-support-on-ubuntu-18-04.
If you did not understand my explanation about http/2 you can check theirs.

Docker for http://wiki.ros.org/footstep_planner

# Install Docker

https://doc.ubuntu-fr.org/docker 

https://docs.docker.com/ engine/install/ubuntu/#install-using-the-repository

# Start 
cd to Dockerfile directory
```bash 
docker build . -t footstep_planner
docker run -d -p 2223:22  footstep_planner 
ssh-keygen -f "/home/cyprien/.ssh/known_hosts" -R "[localhost]:2223"
ssh -Y root@localhost -p 2223

cd /catkin_ws
roslaunch footstep_planner footstep_planner_complete.launch
```

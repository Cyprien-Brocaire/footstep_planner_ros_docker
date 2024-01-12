Docker for http://wiki.ros.org/footstep_planner

# Install Docker

https://doc.ubuntu-fr.org/docker 

https://docs.docker.com/ engine/install/ubuntu/#install-using-the-repository

# Start 
## First time
cd to Dockerfile directory
```bash 
docker build . -t footstep_planner
docker run -d -p 2223:22  footstep_planner 
cd ~ && ssh-keygen -f ".ssh/known_hosts" -R "[localhost]:2223"
ssh -Y root@localhost -p 2223
```
## Other times
```bash
docker start $(docker ps --filter=ancestor=footstep_planner --last=1 --format="{{title .ID}}")
ssh -Y root@localhost -p 2223
```


# Stop
```bash
docker stop $(docker ps --filter=ancestor=footstep_planner --last=1 --format="{{title .ID}}")
```

# Run footstep_planner
```bash
cd /catkin_ws
roslaunch footstep_planner footstep_planner_complete.launch
```

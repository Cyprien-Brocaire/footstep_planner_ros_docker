FROM ubuntu:16.04

# ROS INSTALL
RUN apt update && apt install curl -y 
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN bash -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt update && apt install ros-kinetic-desktop-full -y
RUN apt-cache search ros-kinetic
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bash_profile

## ROS ENVIRONMENT SETUP
RUN apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential -y
RUN rosdep init && rosdep update
RUN apt install ros-kinetic-sbpl -y
RUN apt install ros-kinetic-map-server -y
RUN apt install ros-kinetic-humanoid-nav-msgs -y
RUN apt install ros-kinetic-nav-msgs -y
RUN apt install ros-kinetic-octomap ros-kinetic-octomap-msgs ros-kinetic-octomap-ros ros-kinetic-octomap-server -y
RUN apt install ros-kinetic-dynamic-edt-3d -y
RUN mkdir -p /catkin_ws/src
RUN bash -c "cd /catkin_ws/src && source /opt/ros/kinetic/setup.bash && catkin_init_workspace" 
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bash_profile
RUN bash -c "cd /catkin_ws && wstool init src"
RUN bash -c "cd /catkin_ws && wstool set --target-workspace=src humanoid_msgs --git https://github.com/ahornung/humanoid_msgs -v devel -y"
RUN bash -c "cd /catkin_ws && wstool set --target-workspace=src humanoid_navigation --git https://github.com/ROBOTIS-GIT/humanoid_navigation.git -v kinetic-devel -y"
RUN bash -c "cd /catkin_ws && wstool update --target-workspace=src"
RUN bash -c "cd /catkin_ws && source /opt/ros/kinetic/setup.bash && catkin_make"

# SSH INSTALL
RUN apt update && apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:123' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config
RUN echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# IDE INSTALL
RUN apt install apt-transport-https ca-certificates -y
RUN wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
RUN echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
RUN apt update && apt install -y sublime-text -y 
RUN apt install nano

# INSTALL OTHER NECESSARY PACKAGES
RUN apt install git -y


RUN echo "echo 'WELCOME TO FOOTSTEP PLANNER DOCKER'" >> ~/.bash_profile
RUN echo "echo 'WELCOME TO FOOTSTEP PLANNER DOCKER'" >> ~/.bashrc


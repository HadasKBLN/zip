FROM jenkins/jenkins:latest

USER root
# RUN apt-get update && apt-get install -y python3-pip && apt-get install -y jq
# RUN curl -sSL https://get.docker.com/ | sh
COPY install.sh .
RUN chmod 777 install.sh && ./install.sh
RUN usermod -aG docker jenkins
ENV DOCKER_HOST unix:///var/run/docker.sock
RUN usermod -aG docker jenkins
RUN rm -rf /lib/systemd/system/docker.service
COPY docker.service /lib/systemd/system/docker.service
ENV NAME hadas 

# --- NETFREE CERT INTSALL ---
# ADD https://netfree.link/dl/unix-ca.sh /home/netfree-unix-ca.sh
# ENV NAME hadas 
# # COPY install-netfree-ca.sh /home/netfree-unix-ca.sh 
# RUN cat  /home/netfree-unix-ca.sh | sh
# ENV NODE_EXTRA_CA_CERTS=/etc/ca-bundle.crt
# ENV REQUESTS_CA_BUNDLE=/etc/ca-bundle.crt
# ENV SSL_CERT_FILE=/etc/ca-bundle.crt
# # --- END NETFREE CERT INTSALL ---


USER jenkins

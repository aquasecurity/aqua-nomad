# aqua-nomad
Aqua installation instruction on HashiCorp Nomad

#### Download and install Consul and Nomad
        cd $HOME
        mkdir bin && cd bin
        wget https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip
        wget https://releases.hashicorp.com/consul/1.0.3/consul_1.0.3_linux_amd64.zip
        unzip nomad_0.7.1_linux_amd64.zip && rm nomad_0.7.1_linux_amd64.zip
        unzip consul_1.0.3_linux_amd64.zip && rm consul_1.0.3_linux_amd64.zip

#### Start Consul (develpment mode)
        consul agent -dev

#### Start Nomad (develpment mode)
        nomad agent -dev -config=PATH-TO/nomad.hcl


#### Install Aqua all-in-one

edit the aqua-csp.nomad file and put your DockerHub cresentials

        auth {
            username = "your-dockerhub-user"
            password = "your-dockerhub-pass"
        }

To start the job:
        nomad run PATH-TO/aqua-csp.nomad

To confirm aqua is on running stat
        nomad status aqua-csp

#### Install Aqua Enforcer

Access to the aqua console and create Batch Install

Edit the aqua-agent.nomad file
put your DockerHub cresentials

        auth {
            username = "your-dockerhub-user"
            password = "your-dockerhub-pass"
        }

Replace GATEWAY_IP_ADDR with the ip of the network interface bind to aqua-csp
        "AQUA_SERVER" = "GATEWAY_IP_ADDR:3622"

To start the job:
        nomad run PATH-TO/aqua-agent.nomad

To confirm aqua is on running stat
        nomad status aqua-agent
        

# aqua-nomad
Aqua installation instructions on HashiCorp Nomad

#### Download and install Consul and Nomad
	cd $HOME
	mkdir bin && cd bin
	wget https://releases.hashicorp.com/nomad/0.7.1/nomad_0.7.1_linux_amd64.zip
	wget https://releases.hashicorp.com/consul/1.0.3/consul_1.0.3_linux_amd64.zip
	unzip nomad_0.7.1_linux_amd64.zip && rm nomad_0.7.1_linux_amd64.zip
	unzip consul_1.0.3_linux_amd64.zip && rm consul_1.0.3_linux_amd64.zip

#### Start Consul (development mode)
	consul agent -dev

#### Start Nomad (development mode)
	nomad agent -dev -config=PATH-TO/nomad.hcl


#### Install Aqua all-in-one

Edit the aqua-csp.nomad file and put your DockerHub credentials

	auth {
		username = "your-dockerhub-user"
		password = "your-dockerhub-pass"
	}

To start the job:
	nomad run PATH-TO/aqua-csp.nomad

To confirm Aqua CSP is running

```
nomad status aqua-csp
```

#### Install Aqua Enforcer

Access to the aqua console and create Batch Install

Edit the `aqua-agent.nomad` file
1. Put your DockerHub credentials

```
	auth {
		username = "your-dockerhub-user"
		password = "your-dockerhub-pass"
	}
```

2. Replace GATEWAY_IP_ADDR with the ip of the network interface bind to aqua-csp
	"AQUA_SERVER" = "GATEWAY_IP_ADDR:3622"

To start the job:

```
nomad run PATH-TO/aqua-agent.nomad
```

To confirm the Aqua enforcer is running:

```
nomad status aqua-agent
```


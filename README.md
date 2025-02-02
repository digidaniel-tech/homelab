# Welcome to my `Homelab`

> [!WARNING]
> This repo has fallen behind and have not updated it in a while but I have now
> decided that it will be my "source-of-truth", think of GitOps, so everything
> except secrets will be commited here and then mirrored towards my Homelab.
>
> So expect a lot of changes in the near future!

Welcome friend,

I am Daniel, I am a full fledged nerd who loves to works with
everything from servers, network to code and automation.

I am a strong advocate for GitOps and using automations as much as possible,
to be clear, not everything should be automated but everything that can remove
waste (waste as time that is spent on repetetive tasks) should be automated as 
long as it is secure.

This repository is my Homelab in code, this repo is an repetentation on what I
am running in my Homelab and how my Homelab is currently configured. This is 
both for my own documentation but also to help and inspire others that want to 
do the same.

> [!IMPORTANT]
> Things will change and I am always trying out new things, so I have another
> repo called homelab-archive where I move everything that I am no longer using
> but have been running, so if there is something that you have seen here but
> doesn't exists anymore then check in that repo, it should be there.

## Background

I setup my own Homelab in 2019 and have reinstalled it multiple times and every
time I had to figure out the same problems over and over again because I never
documented the work I had done, this change now!

> [!TIP]
> I recommend you to do the same right now, you don't have to make it public
> if you dont want to but for your own sake I would start documenting your
> work as now righ away to save yourself som headache down the road.

Because this is a Homelab and not an production environment I often reinstall
the server to test new operation systems, other configurations or just fixing
a problem I have caused that I was not able to solve.. (Yeah I also take the
quick way out sometime)

## My Homelab

My Homelab is running Proxmox VE, I have run Proxmox pretty much since I
decided to setup my Homelab and I love it!

> [!NOTE]
> I hope to be able to setup more servers with Proxmox so I can experiment with
> clustering and the HA support but that will be in the future when my budget
> allows it.

### What is Proxmox VE?
Proxmox Virtual Environment (Proxmox VE) is an open-source virtualization
platform that combines two powerful technologies: virtualization and
containerization.

It allows users to deploy and manage virtual machines (VMs)
and containers through a web-based interface. Proxmox VE supports various
virtualization technologies such as Kernel-based Virtual Machine (KVM) for full
virtualization and LXC (Linux Containers) for lightweight containerization.
This versatile platform provides features like live migration, high
availability, backup and restore, as well as a flexible storage system.

Whether you're a small business or an enterprise, Proxmox VE offers a
cost-effective and efficient solution for building and managing virtualized
infrastructure. Proxmox is also commonly used by many Homelab entusiast so
there is alot of videos and tutorials out there on how to use each feature
that Proxmox has to offer.

> [!NOTE]
> Why not VMware, Hyper-V or any of the other more known hypervisors?
> 
> Proxmox is open-source and I always prioritize OS projects as you will notice
> digging into this project and Proxmox has a great community behind it with
> people that are really helpful and knowledgeable.

## Hardware

### Network Infrastructure

I try to setup my network infrastructure as what an business would setup so
that I can learn the more advanced functionality that comes with professional
equitment, this is an ongoing process and I will keep updating it when my
budget allows.

#### Current situation

The current situation looks like the image below where I have an old mesh
network built on two Asus ZenWIFI XT8 Mesh nodes that is currently handling all
my devices mostly wireless.

The exception is in my server room where I have run a Cat6 cable from one of
the XT8 nodes and then distribute it to all my homelab equitment, this has
worked fine for a couple of years but now I have multiple plans on expanding
the homelab during 2025 so I want also to make sure my network infrastructure
will not be a bottleneck.

![Image of the current network infrastructure](https://github.com/digidaniel-dev/homelab/blob/update-readme/assets/network-2025.png?raw=true)

#### Current goal

Here we can see what the current goal is, I have more plans for the future but
this is step 1.

Here we can see that we have replaced the Asus ZenWIFI XT8 mesh nodes with an
Ubiquiti Dream Machine Pro, that one is currently purchase and on it's way to
my place and should be here in the couple of days.

Then it has been added three UniFi U6 Pro AP's that will handle all the 
wireless devices in my house and also in my server room, in the beginning I will
use the Asus ZenWIFI XT8 nodes as AP's until I bought the Unifi AP's.

Due to the move to the Dream Machine we are now having most of the equitment in
the server room I also need to run two additional ethernet cables between the
house and the server room, in this process I will replace the current one with
an Cat6a and also for the two new once, this will be done in such a maner that
I can easly replace the cables to Cat7 or 8 when the time is right.

![Image of the planed network infrastructure](https://github.com/digidaniel-dev/homelab/blob/update-readme/assets/network-2025-plans.png?raw=true)

### NAS

The NAS is an quite old gaming PC I have converted into an NAS, it runs on the
following hardware:

* Asus Z170-A motherboard
* Intel i7-6700K CPU
* Corsair Vengence 32GB 3200MHz RAM
* LSI 9207-8i IT
* Asus TUF Gaming RTX3070 GPU
* 2x Samsung Pro 128GB SSD
* Samsung EVO 500GB SSD
* 6x3TB WD Red in Raidz2
* TP-Link 1GbE NIC

This machine runs Proxmox as the host OS and then Truenas in a VM with HBA and
NIC as passthrough to get the most performance, also runs an separate VM for
Plex with GPU passthrough.

"But why Proxmox?" you might ask, the only reason for this is becouse I 
currently doesn't have an KVM, I am planning on buying one in the future but for
now I use Proxmox as an KVM. And it has worked great!

### Virtualization Server

The virtualization server is my newest investment and is where I run all my
container workload, it runs the following hardware:

* Asus Prime X570-P
* AMD Ryzen 7 5800X
* Corsair Vengence 64GB 3200MHz RAM
* Kingstone 1TB NVMe
* Samsung 970 Evo Plus 256GB SSD
* Asus Strix GTX980 

The reason for why the GTX980 is that the CPU doesn't have support for onboard
graphics, so I took an old GPU that was laying around to being able to have some
graphics in it.

The virtualization server is currently running all Tanos nodes, one control
plane and three workers, this is because I want to go full containerized with
my services and Tanos is a great K8s OS that can be fully automated to setup.

This server will be replaced in the future with three NUC's, why? this is to
both lower the amount of power the server takes and also having the possiblity
to run the nodes in HA, when currently only having one physical machine, HA is
not giving me much value in form of redundancy so that's why it will be 
replaced, or maybe not replaced, I might find another use for it.

## Services

### NAS

The NAS is running Truenas SCALE and Plex as I mentioned before, the plan is to
move Plex from this machine so that the NAS only servers as just a NAS and 
nothing else, but until I can afford to migrate it has to serve for multiple
purpuses.

### Virtualization Server

TBA...

## Future Plans

TBA...

## Contribute

Even if this is my own Homelab and I won't accept contribution but don't
heasitate to create a PR if there is something I could have done differently or
if there is something that looks really wrong, I am still learning and all help
is appreciated.

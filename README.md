# My `Homelab`

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
waste (waste as an wasted time) should be automated as long as it is secure.

This repository is my Homelab in code, this repo is an repetentation on what I am
running in my Homelab and how my Homelab is currently configured. This is both for
my own documentation but also to help and inspire others that want to do the
same.

> [!IMPORTANT]
> Things will change and I am always trying out new things, so I have another repo
> called homelab-archive where I move everything that I am no longer using but have
> been running, so if there is something that you have seen here but doesn't exists
> anymore then check in that repo, it should be there.

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

My Homelab is running Proxmox VE, I have run Proxmox pretty much since I decided to
setup my Homelab and I love it!

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

## The Project

### Folder structure

I have built the structure in a way so I can easily find what I am searching for
so first level is the project or application I am interested in, the second 
level is the tools I have been using to setup the project/application for
instance Terraform, Ansible or maybe Docker compose file.

In the last folders I have all the scripts that is used to setup each instance
that I am or had run so it will be easy to set them up again if needed.

### Terraform

I use Terraform to setup infrastucture in different forms like VM's in Proxmox,
containers in Docker, and so on.

Terraform (TF) is a really easy tool to use and something that I quickly fell
in love with, some of the TF scripts in this project might seem over-engineered
by this is because I wanted to learn more about each feature that TF has to
offer and I then tried to use them all as often as possible.

### Ansible

Ansible is also used, mostly to run different tasks in each VM to make it easy
and quick to get everything to going.

Ansible was something that gave me a bit of a bad taste when started using but
once getting in to it and gained knowledge about it I not think it is a really
good and easy tool to use and is something I will continue using in my future
projects.

### Docker

I love containerization and am trying to use it as much as possible and that is
why I am using Docker, it is also kind of a standard to day in IT so using it
will increase my experiance using each feature.

## Random Questions

> [!NOTE]
> I am trying to add questions that people might have while reading this repo
> here, but if you have any questions please feel free to reach out to me and
> I will try to answear dom as soon as I can.

### Why have you not done X, Y or Z?

I am not an expert in this area, when started this project my entire setup was
done manually by hand without any automation or tools, so it was actually when
I found out about terraform I decided to migrate my entire Homelab setup into
code so I could learn more about Terraform and other tools, and gain more 
knowledge from more of a real life case then from just following another
tutorial, and man I can say it has been an experiance.

### Some projects/applications looks out of date

Yes as times go I will try different applications and projects and might replace
stuff I have run before for something else that I liked, but as this is
documentation and history for me there will exists things that is outdated so
I can go back and check how I did something if I ever want to set it up again.

## Contribute

Even if this is my own Homelab and I won't accept contribution dont heasitate to
create a PR if there is something I could have done differently or if there is
something that looks really wrong, I am still learning and all help is
appreciated.

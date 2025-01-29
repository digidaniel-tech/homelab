# How to install Talos on a VM in Proxmox with Secure Boot

In this document I will guide you to how to setup an minimal Talos Cluster in Proxmox with Secure Boot and TPM for increased security.

> [!WARNING]
> During writing this guide the latest version of Talos is v1.9 so it is a good idea to make sure you change URL's to use the newest version.

## Prerequisites

To following a long with this guide there is some prerequisites, I will list them below.

### Proxmox

First of all I expect you to have an running Proxmox, I will not go over that in this guide.
If interested I can add a guide for that, let me know!

To work with Talos we need two tools, talosctl and kubectl.

### Kubernetes knowledge

In this guide I will not go over how K8s (Kubernetes) work and how to use it, so I expect you to have some knowledge of how to use it or at least knows what it is.

### Talosctl

Talosctl is the main tool used to communicate with the Talos nodes, it can be installed in difference ways depending on what OS you are running,
I link the official guide blow for you to set it up.

[How to install talosctl](https://www.talos.dev/v1.9/talos-guides/install/talosctl/)

### Kubectl

Then we also should install kubectl so we can communicate with K8s.
I link the official guide to how to install that here.

[How to install kubectl](https://kubernetes.io/docs/tasks/tools/)

## Fetch ISO and upload to Proxmox

### Download ISO

The easiest way to fetch the ISO is to go to [Talos Linux Image Factory](https://factory.talos.dev/) and follow the guide specific to
what you want the ISO to include, just remember to select to use SecureBoot because this guide is about how to install using that.

Then I tend to use Qemu agent so when you get to where you can select System Extensions scoll down until you see `siderolabs/qemu-guest-agent` and tick the checkbox to include that,
this is not required but might give some performance improvements and quality of life improvements.

Everything else you can leave untouched.

Lastly you will come to the page with the link to the ISO, copy this url for now.

### Upload to Proxmox

Now that you have the URL you can go to your storage where you store ISO's (local for default) and select ISO Images then "Download from URL" and paste in the URL you retrived previously.
Next click Download and it will get downloaded directly to Proxmox without having to first download it locally and then upload it to Proxmox separately.

Wait for the download to complete and then we are ready to move forward.

## Setup VM in Proxmox

In this guide we will install a minimum cluster of Talos, so we will only install one Control Plane and one Worker node, but the instructions works as well if you want to setup an HA cluster.

### Control Plane node

We begin with creating a new VM in Proxmox by clicking the "Create VM" button at the top right.
On the first view make sure you have the "Advanced" checkbox ticked if you are following along what I do, so you can see all the options.

#### General

First I enter the name "talos-cp-1" to describe that it is an Talos Control Plane we are setting up and 1 in the end is just incase we want to add more later on.

The "Start on boot" checkbox is good to set so that the VM is started on boot if the Proxmox service is restarting due to powerlost or similar.

I usually adds tags when adding VM's that works together to keep VM's organised, so for this VM I add the tag "K8s" to show that the VM is related to Kubernetes.

Everything else I left as it is.

#### OS

Here we select the ISO image we uploaded previously.

I leave Guest OS as default.

#### System

When configuring the system I select `q35` as the machine type this is not required but will give some benefits for modern OS's.

As BIOS I set OVMF (UEFI) and this is needed for secure boot, I also selects where the EFI disk should be stored, an EFI disk is needed for UEFI to work.

Untick the "Pre-Enroll keys" checkbox, Talos will set it's own keys and will not be able to load those if Proxmox pre-enroll keys.

> [!CAUTION]
> Do not forget to untick the "Pre-Enroll keys" checkbox, this gave me a huge headacke first time setting up Talos on Proxmox,
> this checkbox is mostly used for when installing a Windows VM and if it is left tick it will pre load the system with keys that will prevent the
> system to load correct keys from the Talos installation media.

As the SCSI Controller I set it as VirtIO SCSI (not single), this is not required by a good practice. If using the one named single you lose the possible to use Multiqueue I/O where it enables so that multiple threads can works simultaneously.

As mention before I often use the Qemu Agent so it will run better with Proxmox with shutdowns/restart calls, ballooning and showing the IP on the dashboard, so I tick in that box.

The last thing I do here is to tick the TPM checkbox to add an TPM module and selecting where to store it's disk. It should also use TPM v2.0.

#### Disks

Next it is time to setup the disk where Talos will be installed, the minimum disk size for Talos Control Plane is 10GB but the recommended size is 100GB so I will enter 100GB here.

I will also tick the box for IO Thread, it is not required but gives a bit more performance when reading and writing to disk.

> [!NOTE]
> You can read more about requirements here.
> 
> [System Requirements](https://www.talos.dev/v1.9/introduction/system-requirements/)

The rest I leaves as default.

#### CPU

Time to setup the CPU, the minimum requirement is 2 cores for the control-plane but the recommended count is 4 cores so use as many as you can, I set it to 4.

The rest here I leave as default.

#### Memory

When it comes to memory the recommended amount is 4GB (4096MB) but the minimum is 2GB (2048MB), so if you don't have a lot of memory then 2GB is alright.

I also leave "Ballooning Device" ticked so it can share memory with other VM's.

#### Network

The network view I leave as default, but if you want to use a dedicated NIC or change any other settings feel free to to that.

#### Confirm

And then we are done, go over the settings and make sure everything looks good, if you want you can tick in the checkbox so that the VM starts when creation is done but it is not required.

Now we can click the Finish button to create our VM.

### Worker node

To setup the worker node I following the same guide as above but change the name to "talos-worker-1" or something similar.

Also the worker node doesn't need the same amount of resources. To make it easier for you I list the minimum and recommended resources below.

#### Minimum

| Memory | CPU     | Disk  |
| ------ | ------- | ------|
| 1GB    | 1 Cores | 10 GB |

#### Recommended

| Memory | CPU     | Disk   |
| ------ | ------- | -------|
| 2GB    | 2 Cores | 100 GB |

> [!NOTE]
> You can read more about requirements here.
> 
> [System Requirements](https://www.talos.dev/v1.9/introduction/system-requirements/)

Once the worker node VM is created we can start to actually install the Talos cluster.

## Setup TPM configuration

Before we can start installing our nodes we need to create an configuration file for TPM to tell it how the TPM module shoule be setup.

Start by opening up your terminal and create a .yaml file called tpm-disk-encryption.yaml, this file will later be used to configure the disk that is used
by tpm. In the file enter the content below with you favorite editor.

```yaml
# tpm-disk-encryption.yaml

machine:
  systemDiskEncryption:
    ephemeral:
      provider: luks2
      keys:
        - slot: 0
          tpm: {}
    state:
      provider: luks2
      keys:
        - slot: 0
          tpm: {}
```

Here we can see that it used luks for encrypting the disk where the TPM will store it's data.

## Setup the Control Plane node

Time to setup our cluster, we start with the control plane node, if it is not already, start the VM and wait for it to get started and to it getting into maintainence state.

Once it is in maintainance state we can se our IP in the top right corner, note that down or even easier, add it as an environment variable like this.

`export CONTROL_PLANE_IP=1.2.3.4`

Replace 1.2.3.4 with the your IP.

Now that we have our IP we enter the following in our terminal, don't worry I will explan what everything is:

```shell
talosctl gen config talos-proxmox-cluster https://$CONTROL_PLANE_IP:6443 \
    --output-dir _out \
    --install-image factory.talos.dev/installer-secureboot/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba:v1.9.2 \
    --install-disk=/dev/sda \
    --config-patch @tpm-disk-encryption.yaml
```

So what is happening here?

`talosctl get config`
This is the command that will load the configuration for us from our control plane node.

`talos-proxmox-cluster`
This is the name of the cluster, we can change this to something else if we want.

`https://$CONTROL_PLANE_IP:6443`
This is the url that talosctl will use to communicate with our node, note the $CONTROL_PLANE_IP this is the environment variable we added previously, so if you never added that then you need to replace this with the correct IP.

`--output-dir _out`
Here we specify where the configuration files will be saved to, in this case in a directory called _out.

`--install-image`
This specify where to download the installation image, here it is important to make sure it is the secureboot installer, the installer will else install Talos but due to secure boot Talos won't boot after an restart.

`--install-disk`
As default Talos is installed to /dev/sda, so I added this configuration for you if you need to install it to another disk.

`--config-path @tpm-disk-encryption.yaml`
This is to setup the encryption for the TPM module, this is the file we created previously so make sure you are in the correct directory.

After running this you will have an directory called `_out` that contains all configuration files that will be used to setup your cluster.

Now that we have the configuration files we can setup our Talos Control Plane to our VM, this is done by running this command:

```shell
talosctl apply-config --insecure --nodes $CONTROL_PLANE_IP --file _out/controlplane.yaml
```

Let's break down the command to explain what it does:

`talosctl apply-config`
This is the command that we use to apply the configuration we generated previously and install Tanos to our control plane node.

`--insecure`
Because Talos are using https to connect to our nodes we need to specify that we are allowing insecure connection due to us not setup SSL.

`--nodes`
Here we specify what nodes we want to apply this configuration to, here we could add multiple nodes if we wanted to setup an HA cluster but that is out of scope for this guide.

`--file`
This specifies what configuration file to use when running the command here we can see that we are using an configuration file from the directory `_out` that we generated previously and it is also using the configuration for setting up control planes.

Now that we have run this command we can see in the console on Proxmox for the control plane VM that the state say's "Installing" once this is done it will get restarted.

Once the VM has restarted and we are back in the console we can see that the state says `Booting`, if we keep wait nothing will change and that is okay because there are still some things that needs to be done and we get to that soon, so let's leave the control plane for now.

## Setup the worker node

Now it is time to setup the worker node and this is even simpler, all we have to do once the VM has started and we can confirm the state on the console says "Maintainance" is to
just as previously we store the IP for our worker in an environment variable to make our work easier.

`export WORKER_NODE=1.2.3.4`

Then we runt the command below to configure our worker node.

```shell
talosctl apply-config --insecure --nodes $WORKER_NODE --file _out/worker.yaml
```

This is the same command we used previously when applying the configuration to our control plane but with 2 difference let's go over down here.

`--nodes`
Instead of $CONTROL_PLANE_IP we now use the $WORKER_NODE_IP environment variable to make sure we are applying the config to our worker node instead.

`--file`
Here we are now using the worker.yaml instead of the controlplane.yaml that we used before, this is to make sure we apply the worker configuration to our worker and not the control plane configuration.

After running this command we once again can see that the state say's "Installing" and when that is done the VM will be restarted.

When the VM has been restarted and we are back at the console, we have to wait a while until the stage says "Running".

Now we can confirm that the worker is running, but both the control plane and the worker is saying that it is not ready? Let's fix that now!

## Last step

So now when the nodes are configured it is time for us to setup some last configuration.

First we run the following command to setup the endpoint and node configuration for the control plane:

```shell
export TALOSCONFIG="_out/talosconfig"
talosctl config endpoint $CONTROL_PLANE_IP
talosctl config node $CONTROL_PLANE_IP
```

Once that is done we run:
```shell
talosctl bootstrap
```

Now we can see that something is happening on our control plane console, and after waiting some more (might take a minute or two depending on how much resources the VM has) we can se that the ready state change to true and the control plane
then is ready, and after about 1 minute we also can see that the worker node is ready, great!

## First use

Now that the nodes is configured and running, how should we then use it?
We start by fetching the configuration for kubectl by running the command below:

```shell
talosctl kubeconfig .
```

Now we have a file called kubeconfig and this can either be move to the default directory that is `$HOME/.kube` for Linux or we can use it directly in a kubectl command like this.

```shell
kubectl --kubeconfig kubeconfig get nodes
```

And by running that command we now can see our running nodes and Talos is ready to be used to run different services.

Good job!


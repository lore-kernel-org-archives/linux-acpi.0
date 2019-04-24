From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 34/63] Documentation: PCI: convert
 endpoint/pci-endpoint-cfs.txt to reST
Date: Wed, 24 Apr 2019 13:26:34 -0300
Message-ID: <20190424132634.5e1d486e@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-35-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-35-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:29:03 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/PCI/endpoint/index.rst          |  1 +
>  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} | 99 +++++++++++--------
>  2 files changed, 57 insertions(+), 43 deletions(-)
>  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 0db4f2fcd7f0..3951de9f923c 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -8,3 +8,4 @@ PCI Endpoint Framework
>     :maxdepth: 2
>  
>     pci-endpoint
> +   pci-endpoint-cfs
> diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> similarity index 64%
> rename from Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> rename to Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> index d740f29960a4..b6d39cdec56e 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> +++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
> @@ -1,41 +1,51 @@
> -                   CONFIGURING PCI ENDPOINT USING CONFIGFS
> -                    Kishon Vijay Abraham I <kishon@ti.com>
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================================
> +Configuring PCI Endpoint Using CONFIGFS
> +=======================================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  The PCI Endpoint Core exposes configfs entry (pci_ep) to configure the
>  PCI endpoint function and to bind the endpoint function
>  with the endpoint controller. (For introducing other mechanisms to
>  configure the PCI Endpoint Function refer to [1]).
>  
> -*) Mounting configfs
> +Mounting configfs
> +=================
>  
>  The PCI Endpoint Core layer creates pci_ep directory in the mounted configfs
> -directory. configfs can be mounted using the following command.
> +directory. configfs can be mounted using the following command::
>  
>  	mount -t configfs none /sys/kernel/config
>  
> -*) Directory Structure
> +Directory Structure
> +===================
>  
>  The pci_ep configfs has two directories at its root: controllers and
>  functions. Every EPC device present in the system will have an entry in
>  the *controllers* directory and and every EPF driver present in the system
>  will have an entry in the *functions* directory.
> +::
>  
> -/sys/kernel/config/pci_ep/
> -	.. controllers/
> -	.. functions/
> +	/sys/kernel/config/pci_ep/
> +		.. controllers/
> +		.. functions/
>  
> -*) Creating EPF Device
> +Creating EPF Device
> +===================
>  
>  Every registered EPF driver will be listed in controllers directory. The
>  entries corresponding to EPF driver will be created by the EPF core.
> +::
>  
> -/sys/kernel/config/pci_ep/functions/
> -	.. <EPF Driver1>/
> -		... <EPF Device 11>/
> -		... <EPF Device 21>/
> -	.. <EPF Driver2>/
> -		... <EPF Device 12>/
> -		... <EPF Device 22>/
> +	/sys/kernel/config/pci_ep/functions/
> +		.. <EPF Driver1>/
> +			... <EPF Device 11>/
> +			... <EPF Device 21>/
> +		.. <EPF Driver2>/
> +			... <EPF Device 12>/
> +			... <EPF Device 22>/
>  
>  In order to create a <EPF device> of the type probed by <EPF Driver>, the
>  user has to create a directory inside <EPF DriverN>.
> @@ -44,34 +54,37 @@ Every <EPF device> directory consists of the following entries that can be
>  used to configure the standard configuration header of the endpoint function.
>  (These entries are created by the framework when any new <EPF Device> is
>  created)
> -
> -	.. <EPF Driver1>/
> -		... <EPF Device 11>/
> -			... vendorid
> -			... deviceid
> -			... revid
> -			... progif_code
> -			... subclass_code
> -			... baseclass_code
> -			... cache_line_size
> -			... subsys_vendor_id
> -			... subsys_id
> -			... interrupt_pin
> -
> -*) EPC Device
> +::
> +
> +		.. <EPF Driver1>/
> +			... <EPF Device 11>/
> +				... vendorid
> +				... deviceid
> +				... revid
> +				... progif_code
> +				... subclass_code
> +				... baseclass_code
> +				... cache_line_size
> +				... subsys_vendor_id
> +				... subsys_id
> +				... interrupt_pin
> +
> +EPC Device
> +==========
>  
>  Every registered EPC device will be listed in controllers directory. The
>  entries corresponding to EPC device will be created by the EPC core.
> -
> -/sys/kernel/config/pci_ep/controllers/
> -	.. <EPC Device1>/
> -		... <Symlink EPF Device11>/
> -		... <Symlink EPF Device12>/
> -		... start
> -	.. <EPC Device2>/
> -		... <Symlink EPF Device21>/
> -		... <Symlink EPF Device22>/
> -		... start
> +::
> +
> +	/sys/kernel/config/pci_ep/controllers/
> +		.. <EPC Device1>/
> +			... <Symlink EPF Device11>/
> +			... <Symlink EPF Device12>/
> +			... start
> +		.. <EPC Device2>/
> +			... <Symlink EPF Device21>/
> +			... <Symlink EPF Device22>/
> +			... start
>  
>  The <EPC Device> directory will have a list of symbolic links to
>  <EPF Device>. These symbolic links should be created by the user to
> @@ -81,7 +94,7 @@ The <EPC Device> directory will also have a *start* field. Once
>  "1" is written to this field, the endpoint device will be ready to
>  establish the link with the host. This is usually done after
>  all the EPF devices are created and linked with the EPC device.
> -
> +::
>  
>  			 | controllers/
>  				| <Directory: EPC name>/
> @@ -102,4 +115,4 @@ all the EPF devices are created and linked with the EPC device.
>  						| interrupt_pin
>  						| function
>  
> -[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
> +[1] :doc:`pci-endpoint`

Thanks,
Mauro

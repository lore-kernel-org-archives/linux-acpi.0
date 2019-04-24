From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 36/63] Documentation: PCI: convert
 endpoint/pci-test-howto.txt to reST
Date: Wed, 24 Apr 2019 14:00:35 -0300
Message-ID: <20190424140035.198d34dc@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-37-changbin.du@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423162932.21428-37-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 00:29:05 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/PCI/endpoint/index.rst          |  1 +
>  ...{pci-test-howto.txt => pci-test-howto.rst} | 81 +++++++++++++------
>  2 files changed, 56 insertions(+), 26 deletions(-)
>  rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index b680a3fc4fec..d114ea74b444 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -10,3 +10,4 @@ PCI Endpoint Framework
>     pci-endpoint
>     pci-endpoint-cfs
>     pci-test-function
> +   pci-test-howto
> diff --git a/Documentation/PCI/endpoint/pci-test-howto.txt b/Documentation/PCI/endpoint/pci-test-howto.rst
> similarity index 78%
> rename from Documentation/PCI/endpoint/pci-test-howto.txt
> rename to Documentation/PCI/endpoint/pci-test-howto.rst
> index 040479f437a5..909f770a07d6 100644
> --- a/Documentation/PCI/endpoint/pci-test-howto.txt
> +++ b/Documentation/PCI/endpoint/pci-test-howto.rst
> @@ -1,38 +1,51 @@
> -			    PCI TEST USERGUIDE
> -		    Kishon Vijay Abraham I <kishon@ti.com>
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================
> +PCI Test User Guide
> +===================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>  
>  This document is a guide to help users use pci-epf-test function driver
>  and pci_endpoint_test host driver for testing PCI. The list of steps to
>  be followed in the host side and EP side is given below.
>  
> -1. Endpoint Device
> +Endpoint Device
> +===============
>  
> -1.1 Endpoint Controller Devices
> +Endpoint Controller Devices
> +---------------------------
>  
> -To find the list of endpoint controller devices in the system:
> +To find the list of endpoint controller devices in the system::
>  
>  	# ls /sys/class/pci_epc/
>  	  51000000.pcie_ep
>  
> -If PCI_ENDPOINT_CONFIGFS is enabled
> +If PCI_ENDPOINT_CONFIGFS is enabled::
> +
>  	# ls /sys/kernel/config/pci_ep/controllers
>  	  51000000.pcie_ep
>  
> -1.2 Endpoint Function Drivers
>  
> -To find the list of endpoint function drivers in the system:
> +Endpoint Function Drivers
> +-------------------------
> +
> +To find the list of endpoint function drivers in the system::
>  
>  	# ls /sys/bus/pci-epf/drivers
>  	  pci_epf_test
>  
> -If PCI_ENDPOINT_CONFIGFS is enabled
> +If PCI_ENDPOINT_CONFIGFS is enabled::
> +
>  	# ls /sys/kernel/config/pci_ep/functions
>  	  pci_epf_test
>  
> -1.3 Creating pci-epf-test Device
> +
> +Creating pci-epf-test Device
> +----------------------------
>  
>  PCI endpoint function device can be created using the configfs. To create
> -pci-epf-test device, the following commands can be used
> +pci-epf-test device, the following commands can be used::
>  
>  	# mount -t configfs none /sys/kernel/config
>  	# cd /sys/kernel/config/pci_ep/
> @@ -42,7 +55,7 @@ The "mkdir func1" above creates the pci-epf-test function device that will
>  be probed by pci_epf_test driver.
>  
>  The PCI endpoint framework populates the directory with the following
> -configurable fields.
> +configurable fields::
>  
>  	# ls functions/pci_epf_test/func1
>  	  baseclass_code	interrupt_pin	progif_code	subsys_id
> @@ -51,67 +64,83 @@ configurable fields.
>  
>  The PCI endpoint function driver populates these entries with default values
>  when the device is bound to the driver. The pci-epf-test driver populates
> -vendorid with 0xffff and interrupt_pin with 0x0001
> +vendorid with 0xffff and interrupt_pin with 0x0001::
>  
>  	# cat functions/pci_epf_test/func1/vendorid
>  	  0xffff
>  	# cat functions/pci_epf_test/func1/interrupt_pin
>  	  0x0001
>  
> -1.4 Configuring pci-epf-test Device
> +
> +Configuring pci-epf-test Device
> +-------------------------------
>  
>  The user can configure the pci-epf-test device using configfs entry. In order
>  to change the vendorid and the number of MSI interrupts used by the function
> -device, the following commands can be used.
> +device, the following commands can be used::
>  
>  	# echo 0x104c > functions/pci_epf_test/func1/vendorid
>  	# echo 0xb500 > functions/pci_epf_test/func1/deviceid
>  	# echo 16 > functions/pci_epf_test/func1/msi_interrupts
>  	# echo 8 > functions/pci_epf_test/func1/msix_interrupts
>  
> -1.5 Binding pci-epf-test Device to EP Controller
> +
> +Binding pci-epf-test Device to EP Controller
> +--------------------------------------------
>  
>  In order for the endpoint function device to be useful, it has to be bound to
>  a PCI endpoint controller driver. Use the configfs to bind the function
> -device to one of the controller driver present in the system.
> +device to one of the controller driver present in the system::
>  
>  	# ln -s functions/pci_epf_test/func1 controllers/51000000.pcie_ep/
>  
>  Once the above step is completed, the PCI endpoint is ready to establish a link
>  with the host.
>  
> -1.6 Start the Link
> +
> +Start the Link
> +--------------
>  
>  In order for the endpoint device to establish a link with the host, the _start_
> -field should be populated with '1'.
> +field should be populated with '1'::
>  
>  	# echo 1 > controllers/51000000.pcie_ep/start
>  
> -2. RootComplex Device
>  
> -2.1 lspci Output
> +RootComplex Device
> +==================
> +
> +lspci Output
> +------------
>  
> -Note that the devices listed here correspond to the value populated in 1.4 above
> +Note that the devices listed here correspond to the value populated in 1.4
> +above::
>  
>  	00:00.0 PCI bridge: Texas Instruments Device 8888 (rev 01)
>  	01:00.0 Unassigned class [ff00]: Texas Instruments Device b500
>  
> -2.2 Using Endpoint Test function Device
> +
> +Using Endpoint Test function Device
> +-----------------------------------
>  
>  pcitest.sh added in tools/pci/ can be used to run all the default PCI endpoint
> -tests. To compile this tool the following commands should be used:
> +tests. To compile this tool the following commands should be used::
>  
>  	# cd <kernel-dir>
>  	# make -C tools/pci
>  
> -or if you desire to compile and install in your system:
> +or if you desire to compile and install in your system::
>  
>  	# cd <kernel-dir>
>  	# make -C tools/pci install
>  
>  The tool and script will be located in <rootfs>/usr/bin/
>  
> -2.2.1 pcitest.sh Output
> +
> +pcitest.sh Output
> +~~~~~~~~~~~~~~~~~
> +::
> +
>  	# pcitest.sh
>  	BAR tests
>  



Thanks,
Mauro

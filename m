From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 07/11] ACPI: add CONFIG_ACPI_PCI
Date: Thu, 6 Nov 2008 13:41:55 -0600
Message-ID: <200811061241.56255.bjorn.helgaas@hp.com>
References: <20081105231710.26131.3110.stgit@bob.kio> <20081105231808.26131.31742.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:47146 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYKFTl7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 14:41:59 -0500
In-Reply-To: <20081105231808.26131.31742.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

On Wednesday 05 November 2008 04:18:08 pm Bjorn Helgaas wrote:
> Add CONFIG_ACPI_PCI.  This makes it possible to omit the PCI-related
> ACPI drivers if we build with CONFIG_ACPI=y and CONFIG_PCI=n.

Len convinced me on IRC that even though there's no real logical
reason to have ACPI depend on PCI or PM, there's also no real
benefit to removing the dependency.  Removing the dependencies
would increase the number of possible configurations, which
increases the maintenance effort.

So I withdraw patches 7-10 of this set.

I'm still interested in any comments on the rest.

Bjorn

> ---
>  drivers/acpi/Kconfig  |    3 +++
>  drivers/acpi/Makefile |    2 +-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 768bb07..7962bfc 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -330,6 +330,9 @@ config ACPI_DEBUG_FUNC_TRACE
>  	  ACPI Debug Statements slow down ACPI processing. Function trace
>  	  is about half of the penalty and is rarely useful.
>  
> +config ACPI_PCI
> +	def_bool y if PCI
> +
>  config ACPI_PCI_SLOT
>  	tristate "PCI slot detection driver"
>  	default n
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index fc62231..d0ee4c5 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -46,7 +46,7 @@ obj-$(CONFIG_ACPI_BUTTON)	+= button.o
>  obj-$(CONFIG_ACPI_FAN)		+= fan.o
>  obj-$(CONFIG_ACPI_DOCK)		+= dock.o
>  obj-$(CONFIG_ACPI_VIDEO)	+= video.o
> -obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
> +obj-$(CONFIG_ACPI_PCI)		+= pci_root.o pci_link.o pci_irq.o pci_bind.o
>  obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
>  obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
>  obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
> 
> 



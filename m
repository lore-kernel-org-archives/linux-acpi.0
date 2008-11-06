From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 05/11] ACPI: remove CONFIG_ACPI_POWER
Date: Thu, 06 Nov 2008 15:42:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811061542420.3106@localhost.localdomain>
References: <20081105231710.26131.3110.stgit@bob.kio>
 <20081105231757.26131.61631.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:59926 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbYKFVOL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 16:14:11 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9X009ODIVCR3W4@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 14:42:52 -0600 (CST)
In-reply-to: <20081105231757.26131.61631.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

applied.

thanks,
-len

On Wed, 5 Nov 2008, Bjorn Helgaas wrote:

> Remove CONFIG_ACPI_POWER.  It was always set the same as CONFIG_ACPI,
> and it had no menu label, so there was no way to set it to anything
> other than "y".
> 
> The interfaces under CONFIG_ACPI_POWER (acpi_device_sleep_wake(),
> acpi_power_transition(), etc) are called unconditionally from the
> ACPI core, so we already depend on it always being present.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/Kconfig        |    4 ----
>  drivers/acpi/Makefile       |    2 +-
>  include/acpi/acpi_drivers.h |    2 --
>  3 files changed, 1 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1c954a7..20f4574 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -347,10 +347,6 @@ config ACPI_PCI_SLOT
>  	  help you correlate PCI bus addresses with the physical geography
>  	  of your slots. If you are unsure, say N.
>  
> -config ACPI_POWER
> -	bool
> -	default y
> -
>  config ACPI_SYSTEM
>  	bool
>  	default y
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d91c027..8017f63 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -51,7 +51,7 @@ obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
>  obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
>  obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
>  obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
> -obj-$(CONFIG_ACPI_POWER)	+= power.o
> +obj-y				+= power.o
>  obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
>  obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
>  obj-$(CONFIG_ACPI_NUMA)		+= numa.o
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index cf04c60..818215f 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -86,7 +86,6 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_device *device, int domain,
>                                    Power Resource
>     -------------------------------------------------------------------------- */
>  
> -#ifdef CONFIG_ACPI_POWER
>  int acpi_device_sleep_wake(struct acpi_device *dev,
>                             int enable, int sleep_state, int dev_state);
>  int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
> @@ -94,7 +93,6 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
>  int acpi_power_get_inferred_state(struct acpi_device *device);
>  int acpi_power_transition(struct acpi_device *device, int state);
>  extern int acpi_power_nocheck;
> -#endif
>  
>  /* --------------------------------------------------------------------------
>                                    Embedded Controller
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

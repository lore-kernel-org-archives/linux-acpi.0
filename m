From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] ACPI: pci: make new pci.h header local to driver
Date: Sat, 21 Feb 2009 23:28:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902212322310.5009@localhost.localdomain>
References: <20090219195009.20619.20334.stgit@bob.kio>
 <20090219195143.20619.18258.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:52113 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbZBVF2f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Feb 2009 00:28:35 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFG00CHY9RKVJ3N@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 21 Feb 2009 22:28:32 -0600 (CST)
In-reply-to: <20090219195143.20619.18258.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

I like this patch, but not wild about the name "pci.h"

there are already about 20 pci.h files in the tree.
sure, they are context specific, but still i don't like it.

(and I don't like having 11 acpi.h files in the tree either...)

how about acpi_pci.h?

yeah, i know it would be redundant, as it lives in drivers/acpi/ 
but as basically everything it the file starts with "acpi_pci..."
maybe a little redundancy can be seen as consistent?

thanks,
--
Len Brown, Intel Open Source Technology Center

On Thu, 19 Feb 2009, Bjorn Helgaas wrote:

> The PCI-related declarations in acpi_drivers.h are used
> only by the PCI root and related drivers.  This patch moves
> those declarations to a new drivers/acpi/pci.h file.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/pci.h          |   18 ++++++++++++++++++
>  drivers/acpi/pci_bind.c     |    2 ++
>  drivers/acpi/pci_irq.c      |    2 ++
>  drivers/acpi/pci_root.c     |    2 ++
>  include/acpi/acpi_drivers.h |   13 -------------
>  5 files changed, 24 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/acpi/pci.h
> 
> diff --git a/drivers/acpi/pci.h b/drivers/acpi/pci.h
> new file mode 100644
> index 0000000..b3512cf
> --- /dev/null
> +++ b/drivers/acpi/pci.h
> @@ -0,0 +1,18 @@
> +/* ACPI PCI Interrupt Link (pci_link.c) */
> +
> +int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
> +			       int *polarity, char **name);
> +int acpi_pci_link_free_irq(acpi_handle handle);
> +
> +/* ACPI PCI Interrupt Routing (pci_irq.c) */
> +
> +int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus);
> +void acpi_pci_irq_del_prt(int segment, int bus);
> +
> +/* ACPI PCI Device Binding (pci_bind.c) */
> +
> +struct pci_bus;
> +
> +int acpi_pci_bind(struct acpi_device *device);
> +int acpi_pci_bind_root(struct acpi_device *device, struct acpi_pci_id *id,
> +		       struct pci_bus *bus);
> diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
> index 95650f8..5504c9d 100644
> --- a/drivers/acpi/pci_bind.c
> +++ b/drivers/acpi/pci_bind.c
> @@ -35,6 +35,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> +#include "pci.h"
> +
>  #define _COMPONENT		ACPI_PCI_COMPONENT
>  ACPI_MODULE_NAME("pci_bind");
>  
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index be6b909..c20c848 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -40,6 +40,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> +#include "pci.h"
> +
>  #define _COMPONENT		ACPI_PCI_COMPONENT
>  ACPI_MODULE_NAME("pci_irq");
>  
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 5b38a02..61e8979 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -36,6 +36,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> +#include "pci.h"
> +
>  #define _COMPONENT		ACPI_PCI_COMPONENT
>  ACPI_MODULE_NAME("pci_root");
>  #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 5fc1bb0..9ea2684 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -75,23 +75,10 @@
>  /* ACPI PCI Interrupt Link (pci_link.c) */
>  
>  int acpi_irq_penalty_init(void);
> -int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
> -			       int *polarity, char **name);
> -int acpi_pci_link_free_irq(acpi_handle handle);
> -
> -/* ACPI PCI Interrupt Routing (pci_irq.c) */
> -
> -int acpi_pci_irq_add_prt(acpi_handle handle, int segment, int bus);
> -void acpi_pci_irq_del_prt(int segment, int bus);
>  
>  /* ACPI PCI Device Binding (pci_bind.c) */
>  
> -struct pci_bus;
> -
>  acpi_status acpi_get_pci_id(acpi_handle handle, struct acpi_pci_id *id);
> -int acpi_pci_bind(struct acpi_device *device);
> -int acpi_pci_bind_root(struct acpi_device *device, struct acpi_pci_id *id,
> -		       struct pci_bus *bus);
>  
>  /* Arch-defined function to add a bus to the system */
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH -mm] acpi: use list.h API for sub_driver list
Date: Sun, 29 Oct 2006 13:42:33 +0000
Message-ID: <20061029134233.GA22902@infradead.org>
References: <20061028185313.GK9973@localhost> <20061028190254.GA7070@infradead.org> <20061029134003.GC10295@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:15806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965221AbWJ2Nmg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Oct 2006 08:42:36 -0500
Content-Disposition: inline
In-Reply-To: <20061029134003.GC10295@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sun, Oct 29, 2006 at 10:40:03PM +0900, Akinobu Mita wrote:
> On Sat, Oct 28, 2006 at 08:02:54PM +0100, Christoph Hellwig wrote:
> > Any chance to just switch the driver to use the list.h APIs instead
> > of opencoding lists?
> 
> Subject: [PATCH -mm] acpi: use list.h API for sub_driver list
> 
> Use the list.h APIs instead of opencoding lists.

Maybe it's just me but I don't see a place where we actually ever
iterate this list.  Len, do you plan to introduce users of the list anytime
soon?  In that case the patch below looks good to me, else we should just
rip it out completely.

> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> Index: work-fault-inject/drivers/acpi/pci_root.c
> ===================================================================
> --- work-fault-inject.orig/drivers/acpi/pci_root.c
> +++ work-fault-inject/drivers/acpi/pci_root.c
> @@ -65,17 +65,14 @@ struct acpi_pci_root {
>  
>  static LIST_HEAD(acpi_pci_roots);
>  
> -static struct acpi_pci_driver *sub_driver;
> +static LIST_HEAD(sub_driver);
>  
>  int acpi_pci_register_driver(struct acpi_pci_driver *driver)
>  {
>  	int n = 0;
>  	struct list_head *entry;
>  
> -	struct acpi_pci_driver **pptr = &sub_driver;
> -	while (*pptr)
> -		pptr = &(*pptr)->next;
> -	*pptr = driver;
> +	list_add_tail(&driver->list, &sub_driver);
>  
>  	if (!driver->add)
>  		return 0;
> @@ -96,14 +93,7 @@ void acpi_pci_unregister_driver(struct a
>  {
>  	struct list_head *entry;
>  
> -	struct acpi_pci_driver **pptr = &sub_driver;
> -	while (*pptr) {
> -		if (*pptr == driver)
> -			break;
> -		pptr = &(*pptr)->next;
> -	}
> -	BUG_ON(!*pptr);
> -	*pptr = (*pptr)->next;
> +	list_del(&driver->list);
>  
>  	if (!driver->remove)
>  		return;
> Index: work-fault-inject/include/linux/acpi.h
> ===================================================================
> --- work-fault-inject.orig/include/linux/acpi.h
> +++ work-fault-inject/include/linux/acpi.h
> @@ -480,7 +480,7 @@ void acpi_penalize_isa_irq(int irq, int 
>  void acpi_pci_irq_disable (struct pci_dev *dev);
>  
>  struct acpi_pci_driver {
> -	struct acpi_pci_driver *next;
> +	struct list_head list;
>  	int (*add)(acpi_handle handle);
>  	void (*remove)(acpi_handle handle);
>  };
---end quoted text---

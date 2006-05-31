From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/2] - Altix: Add initial ACPI support
Date: Wed, 31 May 2006 16:34:08 -0700
Message-ID: <20060531233408.GA21244@suse.de>
References: <20060531212320.32044.49013.sendpatchset@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:28302 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965252AbWEaXh3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 May 2006 19:37:29 -0400
Content-Disposition: inline
In-Reply-To: <20060531212320.32044.49013.sendpatchset@attica.americas.sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net

On Wed, May 31, 2006 at 04:23:20PM -0500, John Keller wrote:
> Index: acpi-support/arch/ia64/pci/pci.c
> ===================================================================
> --- acpi-support.orig/arch/ia64/pci/pci.c	2006-05-31 12:37:50.539921986 -0500
> +++ acpi-support/arch/ia64/pci/pci.c	2006-05-31 14:10:50.889146925 -0500
> @@ -470,10 +470,11 @@ pcibios_fixup_resources(struct pci_dev *
>  	}
>  }
>  
> -static void __devinit pcibios_fixup_device_resources(struct pci_dev *dev)
> +void __devinit pcibios_fixup_device_resources(struct pci_dev *dev)
>  {
>  	pcibios_fixup_resources(dev, 0, PCI_BRIDGE_RESOURCES);
>  }
> +EXPORT_SYMBOL(pcibios_fixup_device_resources);

EXPORT_SYMBOL_GPL() perhaps?

> --- acpi-support.orig/include/linux/pci.h	2006-05-31 12:37:50.647911309 -0500
> +++ acpi-support/include/linux/pci.h	2006-05-31 14:10:50.989137400 -0500
> @@ -397,6 +397,7 @@ extern struct bus_type pci_bus_type;
>  extern struct list_head pci_root_buses;	/* list of all known PCI buses */
>  extern struct list_head pci_devices;	/* list of all devices */
>  
> +void __devinit pcibios_fixup_device_resources(struct pci_dev *);

Don't put __devinit on a function prototype.  It does nothing.

thanks,

greg k-h

From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux/ACPI 2.4 release status
Date: 15 Dec 2003 17:50:18 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1071528618.2444.11.camel@dhcppc4>
References: <1071209752.2542.688.camel@dhcppc4>
	 <200312151146.42531.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200312151146.42531.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Bjorn.

Is it possible that some ia32 or x86_64 platforms might depend on this
code and miss it because they lack the _CRS walk that ia64 has in
pcibios_scan_root()?


thanks,
-Len

On Mon, 2003-12-15 at 13:46, Bjorn Helgaas wrote:
> On Thursday 11 December 2003 11:15 pm, Len Brown wrote:
> > Yes, this is a good time to remind me about, or update and re-send
> > patches that we were not able to handle in time for 2.4.23.
> 
> Here's one:
> 
> This patch against the current 2.4 tree removes a bunch of
> ill-advised code I added to get _TRA information from PCI
> root bridges.
> 
> This was the wrong approach because for one thing, it only
> handled one MEM window and one IO window, and root bridges
> may have several of each.
> 
> This patch can be applied for both 2.4 and 2.5.  ia64 was the
> only user of this code, and we no longer need it.  The current
> approach is to walk the _CRS in pcibios_scan_root() using
> acpi_walk_resources(). 
> 
> diff -u -ur 2.4/drivers/acpi/pci_root.c 2.4-patched/drivers/acpi/pci_root.c
> --- 2.4/drivers/acpi/pci_root.c	2003-12-15 11:41:51.000000000 -0700
> +++ 2.4-patched/drivers/acpi/pci_root.c	2003-12-15 11:41:19.000000000 -0700
> @@ -61,8 +61,6 @@
>  	acpi_handle		handle;
>  	struct acpi_pci_id	id;
>  	struct pci_bus		*bus;
> -	u64			mem_tra;
> -	u64			io_tra;
>  };
>  
>  static LIST_HEAD(acpi_pci_roots);
> @@ -114,97 +112,6 @@
>  	}
>  }
>  
> -void
> -acpi_pci_get_translations (
> -	struct acpi_pci_id	*id,
> -	u64			*mem_tra,
> -	u64			*io_tra)
> -{
> -	struct list_head	*node = NULL;
> -	struct acpi_pci_root	*entry;
> -
> -	/* TBD: Locking */
> -	list_for_each(node, &acpi_pci_roots) {
> -		entry = list_entry(node, struct acpi_pci_root, node);
> -		if ((id->segment == entry->id.segment)
> -			&& (id->bus == entry->id.bus)) {
> -			*mem_tra = entry->mem_tra;
> -			*io_tra = entry->io_tra;
> -			return;
> -		}
> -	}
> -
> -	*mem_tra = 0;
> -	*io_tra = 0;
> -}
> -
> -
> -static u64
> -acpi_pci_root_bus_tra (
> -       struct acpi_resource	*resource,
> -       int			type)
> -{
> -	struct acpi_resource_address16 *address16;
> -	struct acpi_resource_address32 *address32;
> -	struct acpi_resource_address64 *address64;
> -
> -	while (1) {
> -		switch (resource->id) {
> -		case ACPI_RSTYPE_END_TAG:
> -			return 0;
> -
> -		case ACPI_RSTYPE_ADDRESS16:
> -			address16 = (struct acpi_resource_address16 *) &resource->data;
> -			if (type == address16->resource_type) {
> -				return address16->address_translation_offset;
> -			}
> -			break;
> -
> -		case ACPI_RSTYPE_ADDRESS32:
> -			address32 = (struct acpi_resource_address32 *) &resource->data;
> -			if (type == address32->resource_type) {
> -				return address32->address_translation_offset;
> -			}
> -			break;
> -
> -		case ACPI_RSTYPE_ADDRESS64:
> -			address64 = (struct acpi_resource_address64 *) &resource->data;
> -			if (type == address64->resource_type) {
> -				return address64->address_translation_offset;
> -			}
> -			break;
> -		}
> -		resource = ACPI_PTR_ADD (struct acpi_resource,
> -				resource, resource->length);
> -	}
> -
> -	return 0;
> -}
> -
> -
> -static int
> -acpi_pci_evaluate_crs (
> -	struct acpi_pci_root	*root)
> -{
> -	acpi_status		status;
> -	struct acpi_buffer	buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> -
> -	ACPI_FUNCTION_TRACE("acpi_pci_evaluate_crs");
> -
> -	status = acpi_get_current_resources (root->handle, &buffer);
> -	if (ACPI_FAILURE(status))
> -		return_VALUE(-ENODEV);
> -
> -	root->io_tra = acpi_pci_root_bus_tra ((struct acpi_resource *)
> -			buffer.pointer, ACPI_IO_RANGE);
> -	root->mem_tra = acpi_pci_root_bus_tra ((struct acpi_resource *)
> -			buffer.pointer, ACPI_MEMORY_RANGE);
> -
> -	acpi_os_free(buffer.pointer);
> -	return_VALUE(0);
> -}
> -
> -
>  static int
>  acpi_pci_root_add (
>  	struct acpi_device	*device)
> @@ -289,10 +196,8 @@
>  	root->id.function = device->pnp.bus_address & 0xFFFF;
>  
>  	/*
> -	 * Evaluate _CRS to get root bridge resources
>  	 * TBD: Need PCI interface for enumeration/configuration of roots.
>  	 */
> - 	acpi_pci_evaluate_crs(root);
>  
>   	/* TBD: Locking */
>   	list_add_tail(&root->node, &acpi_pci_roots);
> diff -u -ur 2.4/include/acpi/acpi_drivers.h 2.4-patched/include/acpi/acpi_drivers.h
> --- 2.4/include/acpi/acpi_drivers.h	2003-12-15 11:41:53.000000000 -0700
> +++ 2.4-patched/include/acpi/acpi_drivers.h	2003-12-15 11:41:19.000000000 -0700
> @@ -162,7 +162,6 @@
>  
>  int acpi_pci_root_init (void);
>  void acpi_pci_root_exit (void);
> -void acpi_pci_get_translations (struct acpi_pci_id* id, u64* mem_tra, u64* io_tra);
>  
>  /* ACPI PCI Interrupt Link (pci_link.c) */
>  
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

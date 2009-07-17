From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Fri, 17 Jul 2009 17:02:28 +0200
Message-ID: <200907171702.29353.trenn@suse.de>
References: <1246415391.24831.30.camel@minggr.sh.intel.com> <200907131736.42225.trenn@suse.de> <1247538536.3850.25.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:48319 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbZGQPCB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Jul 2009 11:02:01 -0400
In-Reply-To: <1247538536.3850.25.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>, "fboiteux@calistel.com" <fboiteux@calistel.com>

On Tuesday 14 July 2009 04:28:56 am Lin Ming wrote:
> On Mon, 2009-07-13 at 23:36 +0800, Thomas Renninger wrote:
> > Hi Lin and all others...
> >
> > this is about:
> > http://bugzilla.kernel.org/show_bug.cgi?id=13620
> >
> > On Thursday 02 July 2009 08:27:25 Lin Ming wrote:
> > > On Thu, 2009-07-02 at 10:03 +0800, Len Brown wrote:
> > > > I can't apply a patch that adds a known memory leak,
> > > > even if it removes a conflict between drivers.
> > > >
> > > > The reason is that there is a workaround for the driver conflict,
> > > > but no workaround for the memory leak.
> > >
> > > Here is a prototype simple patch, please review to see if it is the
> > > right way to go.
> >
> > This should provide the same functionality as we had before 2.6.30,
> > but goes the approach Bob suggested:
> > If a driver wants to check for ACPI OpRegion conflicts, walk the
> > namespace and check for conflicts against "active/defined" OpRegions.
> > It would be great if someone could comment on the:
> > handle -> struct acpi_object_region mapping
> > at the beginning of the walk_namespace callback function:
> > acpi_check_resource_conflict_wn(..)
> > This should be the most critical part.
> >
> > On a conflict you should see rather the same output (from my little
> > test module):
> > ACPI: I/O resource sis5595 [0x80-0x85] conflicts with ACPI region DB80
> > [0x80-0x81]
> >
> > This is more intrusive than Lin's approach (remove entries from the
> > OpRegion osl.c list when destroyed).
> > Not sure what is better (this should go into stable later...).
> > Let me know whether this is acceptable and I can write a more
> > detailed changelog. I can also rebase the patch then (this one is
> > against a 2.6.29 kernel).
> >
> > Thanks,
> >
> >    Thomas
> >
> > -------
> > ACPI: Bring back resource conflict checking for hwmon drivers vs ACPI
> > opregions
> >
> >
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> >
> > ---
> >  drivers/acpi/acpica/aclocal.h  |    2
> >  drivers/acpi/acpica/acnamesp.h |    2
> >  drivers/acpi/acpica/acobject.h |    2
> >  drivers/acpi/osl.c             |  170
> > ++++++++++++++++++----------------------- 4 files changed, 84
> > insertions(+), 92 deletions(-)
> >
> > Index: linux-2.6.29/drivers/acpi/acpica/aclocal.h
> > ===================================================================
> > --- linux-2.6.29.orig/drivers/acpi/acpica/aclocal.h
> > +++ linux-2.6.29/drivers/acpi/acpica/aclocal.h
> > @@ -44,6 +44,8 @@
> >  #ifndef __ACLOCAL_H__
> >  #define __ACLOCAL_H__
> >
> > +#include "acconfig.h"
> > +
> >  /* acpisrc:struct_defs -- for acpisrc conversion */
> >
> >  #define ACPI_SERIALIZED                 0xFF
> > Index: linux-2.6.29/drivers/acpi/acpica/acnamesp.h
> > ===================================================================
> > --- linux-2.6.29.orig/drivers/acpi/acpica/acnamesp.h
> > +++ linux-2.6.29/drivers/acpi/acpica/acnamesp.h
> > @@ -44,6 +44,8 @@
> >  #ifndef __ACNAMESP_H__
> >  #define __ACNAMESP_H__
> >
> > +#include "acstruct.h"
> > +
> >  /* To search the entire name space, pass this as search_base */
> >
> >  #define ACPI_NS_ALL                 ((acpi_handle)0)
> > Index: linux-2.6.29/drivers/acpi/acpica/acobject.h
> > ===================================================================
> > --- linux-2.6.29.orig/drivers/acpi/acpica/acobject.h
> > +++ linux-2.6.29/drivers/acpi/acpica/acobject.h
> > @@ -45,6 +45,8 @@
> >  #ifndef _ACOBJECT_H
> >  #define _ACOBJECT_H
> >
> > +#include "aclocal.h"
> > +
> >  /* acpisrc:struct_defs -- for acpisrc conversion */
> >
> >  /*
> > Index: linux-2.6.29/drivers/acpi/osl.c
> > ===================================================================
> > --- linux-2.6.29.orig/drivers/acpi/osl.c
> > +++ linux-2.6.29/drivers/acpi/osl.c
> > @@ -51,6 +51,10 @@
> >  #include <acpi/acpi_bus.h>
> >  #include <acpi/processor.h>
> >
> > +#include "acpica/acobject.h"
> > +#include "acpica/acnamesp.h"
> > +#include "acpica/acutils.h"
>
> Hi, Thomas,
>
> Those are acpica private header files that should not be used out of
> acpica.
>
> See commit e2f7a7772880458edff1b1cc5a988947229fac26
> "ACPICA: hide private headers"
>
> > +
> >  #define _COMPONENT		ACPI_OS_SERVICES
> >  ACPI_MODULE_NAME("osl");
> >  #define PREFIX		"ACPI: "
> > @@ -80,18 +84,6 @@ static void *acpi_irq_context;
> >  static struct workqueue_struct *kacpid_wq;
> >  static struct workqueue_struct *kacpi_notify_wq;
> >
> > -struct acpi_res_list {
> > -	resource_size_t start;
> > -	resource_size_t end;
> > -	acpi_adr_space_type resource_type; /* IO port, System memory, ...*/
> > -	char name[5];   /* only can have a length of 4 chars, make use of this
> > -			   one instead of res->name, no need to kalloc then */
> > -	struct list_head resource_list;
> > -};
> > -
> > -static LIST_HEAD(resource_list_head);
> > -static DEFINE_SPINLOCK(acpi_res_lock);
> > -
> >  #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
> >  static char osi_additional_string[OSI_STRING_LENGTH_MAX];
> >
> > @@ -1096,57 +1088,87 @@ static int __init acpi_enforce_resources
> >
> >  __setup("acpi_enforce_resources=", acpi_enforce_resources_setup);
> >
> > -/* Check for resource conflicts between ACPI OperationRegions and native
> > - * drivers */
> > -int acpi_check_resource_conflict(struct resource *res)
> > +static acpi_status
> > +acpi_check_resource_conflict_wn(acpi_handle handle, u32 level, void
> > *context, +			     void **retval)
> >  {
> > -	struct acpi_res_list *res_list_elem;
> > -	int ioport;
> > -	int clash = 0;
> >
> > -	if (acpi_enforce_resources == ENFORCE_RESOURCES_NO)
> > -		return 0;
> > -	if (!(res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_MEM))
> > -		return 0;
> > +	struct acpi_namespace_node *node;
>
> Same as above, acpi_namespace_node is an ACPICA internal used only
> structure.
>
> > -	ioport = res->flags & IORESOURCE_IO;
> > +	struct resource *res = context;
> > +	struct acpi_object_region *region_desc;
> > +	unsigned long long reg_start;
> > +	unsigned long long reg_end;
> >
> > -	spin_lock(&acpi_res_lock);
> > -	list_for_each_entry(res_list_elem, &resource_list_head,
> > -			    resource_list) {
> > -		if (ioport && (res_list_elem->resource_type
> > -			       != ACPI_ADR_SPACE_SYSTEM_IO))
> > -			continue;
> > -		if (!ioport && (res_list_elem->resource_type
> > -				!= ACPI_ADR_SPACE_SYSTEM_MEMORY))
> > -			continue;
> > +	/* Convert and validate the device handle */
> > +	node = acpi_ns_map_handle_to_node(handle);
>
> Same as above, acpi_ns_map_handle_to_node is ACPICA internal used only
> function.
>
> Try acpi_get_object_info(...) to get node type.
Ok, I see.
I thought it's ok to use it in drivers/acpi/*.
While I could get the type from acpi_get_object_info(...), I have no idea how
I could obtain the region info (address/length) without internal functions.
Hints appreciated.

I also still think your approach (delete list entries on OpRegion 
invalidation) is the better one. At least for:
  - fixing the memleak in older kernels
  - handle the reported regression(s) in .30 and .31.
Len?

Thanks,

    Thomas
>
> > +	if (!node || node->type != ACPI_TYPE_REGION)
> > +		return AE_OK;
> >
> > -		if (res->end < res_list_elem->start
> > -		    || res_list_elem->end < res->start)
> > -			continue;
> > -		clash = 1;
> > -		break;
> > -	}
> > -	spin_unlock(&acpi_res_lock);
> > +	/* Check for an existing internal object */
> > +	region_desc = (struct acpi_object_region *)
> > +		acpi_ns_get_attached_object(node);
>
> Same as above, acpi_ns_get_attached_object is ACPICA internal used only.
>
> Thanks,
> Lin Ming
>
> > +	if (!region_desc || region_desc->type != ACPI_TYPE_REGION)
> > +		return AE_OK;
> >
> > -	if (clash) {
> > -		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
> > -			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
> > -			       " conflicts with ACPI region %s"
> > -			       " [0x%llx-0x%llx]\n",
> > -			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
> > -			       ? KERN_WARNING : KERN_ERR,
> > -			       ioport ? "I/O" : "Memory", res->name,
> > -			       (long long) res->start, (long long) res->end,
> > -			       res_list_elem->name,
> > -			       (long long) res_list_elem->start,
> > -			       (long long) res_list_elem->end);
> > -			printk(KERN_INFO "ACPI: Device needs an ACPI driver\n");
> > -		}
> > -		if (acpi_enforce_resources == ENFORCE_RESOURCES_STRICT)
> > -			return -EBUSY;
> > +	if (region_desc->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY
> > +	    && region_desc->space_id != ACPI_ADR_SPACE_SYSTEM_IO)
> > +		return AE_OK;
> > +
> > +	/* Only check IO vs IO and Mem vs Mem regions/resources */
> > +	if ((region_desc->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY &&
> > +	     !(res->flags & IORESOURCE_MEM)) ||
> > +	    (region_desc->space_id == ACPI_ADR_SPACE_SYSTEM_IO &&
> > +	     !(res->flags & IORESOURCE_IO)))
> > +		return AE_OK;
> > +
> > +	reg_start = region_desc->address;
> > +	reg_end   = region_desc->address + region_desc->length;
> > +
> > +	ACPI_DEBUG_PRINT((ACPI_DB_OPREGION, "Checking %s Region: ACPI:"
> > +			  " 0x%llX - 0x%llX\n",
> > +			  region_desc->space_id == ACPI_ADR_SPACE_SYSTEM_IO ?
> > +			  "IO" : "Memory", reg_start, reg_end));
> > +
> > +	if (res->end < reg_start || reg_end < res->start)
> > +		return AE_OK;
> > +
> > +	/* Conflict! */
> > +	if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
> > +		printk("%sACPI: %s resource %s [0x%llx-0x%llx] conflicts with "
> > +		       "ACPI region %s [0x%llx-0x%llx]\n",
> > +		       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
> > +		       ? KERN_WARNING : KERN_ERR,
> > +		       region_desc->space_id == ACPI_ADR_SPACE_SYSTEM_IO
> > +		       ? "I/O" : "Memory", res->name,
> > +		       (long long) res->start, (long long) res->end,
> > +		       acpi_ut_get_node_name(node),
> > +		       reg_start,
> > +		       reg_end);
> > +		printk(KERN_INFO "ACPI: Device needs an ACPI driver\n");
> >  	}
> > -	return 0;
> > +	if (acpi_enforce_resources == ENFORCE_RESOURCES_STRICT)
> > +		return AE_ERROR;
> > +
> > +	return AE_OK;
> > +}
> > +
> > +/* Check for resource conflicts between ACPI OperationRegions and native
> > + * drivers
> > + * Returns zero if there is no conflict
> > + */
> > +int acpi_check_resource_conflict(struct resource *res)
> > +{
> > +	acpi_status status;
> > +
> > +	status = acpi_walk_namespace(ACPI_TYPE_REGION, ACPI_ROOT_OBJECT,
> > +				     ACPI_UINT32_MAX,
> > +				     acpi_check_resource_conflict_wn,
> > +				     res, NULL);
> > +	if (status == AE_ERROR)
> > +		return 1;
> > +	else
> > +		return 0;
> >  }
> >  EXPORT_SYMBOL(acpi_check_resource_conflict);
> >
> > @@ -1340,42 +1362,6 @@ acpi_os_validate_address (
> >      acpi_size               length,
> >      char *name)
> >  {
> > -	struct acpi_res_list *res;
> > -	if (acpi_enforce_resources == ENFORCE_RESOURCES_NO)
> > -		return AE_OK;
> > -
> > -	switch (space_id) {
> > -	case ACPI_ADR_SPACE_SYSTEM_IO:
> > -	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
> > -		/* Only interference checks against SystemIO and SytemMemory
> > -		   are needed */
> > -		res = kzalloc(sizeof(struct acpi_res_list), GFP_KERNEL);
> > -		if (!res)
> > -			return AE_OK;
> > -		/* ACPI names are fixed to 4 bytes, still better use strlcpy */
> > -		strlcpy(res->name, name, 5);
> > -		res->start = address;
> > -		res->end = address + length - 1;
> > -		res->resource_type = space_id;
> > -		spin_lock(&acpi_res_lock);
> > -		list_add(&res->resource_list, &resource_list_head);
> > -		spin_unlock(&acpi_res_lock);
> > -		pr_debug("Added %s resource: start: 0x%llx, end: 0x%llx, "
> > -			 "name: %s\n", (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> > -			 ? "SystemIO" : "System Memory",
> > -			 (unsigned long long)res->start,
> > -			 (unsigned long long)res->end,
> > -			 res->name);
> > -		break;
> > -	case ACPI_ADR_SPACE_PCI_CONFIG:
> > -	case ACPI_ADR_SPACE_EC:
> > -	case ACPI_ADR_SPACE_SMBUS:
> > -	case ACPI_ADR_SPACE_CMOS:
> > -	case ACPI_ADR_SPACE_PCI_BAR_TARGET:
> > -	case ACPI_ADR_SPACE_DATA_TABLE:
> > -	case ACPI_ADR_SPACE_FIXED_HARDWARE:
> > -		break;
> > -	}
> >  	return AE_OK;
> >  }



From: Andrew Patterson <andrew.patterson@hp.com>
Subject: Re: [PATCH 2/8] ACPI, PCI: call _OSC support during root bridge
	discovery
Date: Wed, 29 Oct 2008 14:28:50 -0600
Message-ID: <1225312131.6794.120.camel@bluto.andrew>
References: <20081029054815.2263.40833.stgit@bob.kio>
	 <20081029054826.2263.48713.stgit@bob.kio>
	 <200810290830.05200.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:20402 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbYJ2U2w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 16:28:52 -0400
In-Reply-To: <200810290830.05200.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx

On Wed, 2008-10-29 at 08:30 -0600, Bjorn Helgaas wrote:
> On Tuesday 28 October 2008 11:48:26 pm Andrew Patterson wrote:
> > ACPI, PCI: call _OSC support during root bridge discovery
> > 
> > Added pci_acpi_isc_support() which is called when a PCI bridge is
> 
> s/_isc_/_osc_/

Fixed.

> 
> > added, so individual PCI root bridge drivers do not have to call _OSC
> > support for every root bridge in their probe functions.
> > ---
> > 
> >  drivers/acpi/pci_root.c  |    6 ++++++
> >  drivers/pci/pci-acpi.c   |   24 +++++++++++++++++++-----
> >  include/linux/pci-acpi.h |    1 +
> >  3 files changed, 26 insertions(+), 5 deletions(-)
> > 
> > 
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index 1b8f67d..47df4a8 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/pm.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-acpi.h>
> >  #include <linux/acpi.h>
> >  #include <acpi/acpi_bus.h>
> >  #include <acpi/acpi_drivers.h>
> > @@ -210,6 +211,11 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
> >  
> >  	device->ops.bind = acpi_pci_bind;
> >  
> > +	pci_acpi_osc_support(device->handle,
> > +			     OSC_EXT_PCI_CONFIG_SUPPORT |
> > +			     OSC_PCI_SEGMENT_GROUPS_SUPPORT |
> > +			     0);
> > +
> >  	/* 
> >  	 * Segment
> >  	 * -------
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index dfe7c8e..f457387 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -139,28 +139,42 @@ static acpi_status __acpi_query_osc(u32 flags, struct acpi_osc_data *osc_data,
> >  	return status;
> >  }
> >  
> > -static acpi_status acpi_query_osc(acpi_handle handle,
> > -				  u32 level, void *context, void **retval)
> > +/*
> > + * pci_acpi_osc_support: Invoke _OSC indicating support for the given feature
> > + * @flags: Bitmask of flags to support
> > + *
> > + * See the ACPI spec for the definition of the flags
> > + */
> > +int pci_acpi_osc_support(acpi_handle handle, u32 flags)
> >  {
> > +	u32 dummy;
> >  	acpi_status status;
> > -	struct acpi_osc_data *osc_data;
> > -	u32 flags = (unsigned long)context, dummy;
> >  	acpi_handle tmp;
> > +	struct acpi_osc_data *osc_data;
> > +	int rc = 0;
> >  
> >  	status = acpi_get_handle(handle, "_OSC", &tmp);
> >  	if (ACPI_FAILURE(status))
> > -		return AE_OK;
> > +		return -ENOTTY;
> >  
> >  	mutex_lock(&pci_acpi_lock);
> >  	osc_data = acpi_get_osc_data(handle);
> >  	if (!osc_data) {
> >  		printk(KERN_ERR "acpi osc data array is full\n");
> 
> I know you didn't change this printk, but since you're here,
> can you clean this up?  I propose removing this printk altogether,
> then checking the return from pci_acpi_osc_support() and using
> dev_warn (with the flags and return value) if it fails.
> 

One problem we would have with this change is that there are a lot of
platforms that don't implement _OSC, so we would get a lot of spew when
calling pci_acpi_osc_support on those systems (returning -ENOTTY).
Matthew is talking about moving this allocation into the acpi_pci_root
struct, so this issue should become moot at that point.

> > +		rc = -ENOMEM;
> >  		goto out;
> >  	}
> >  

Andrew



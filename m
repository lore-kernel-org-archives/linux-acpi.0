From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/6] ACPI: allow drivers to request both device and system notify events
Date: Wed, 27 May 2009 18:02:26 -0600
Message-ID: <200905271802.26902.bjorn.helgaas@hp.com>
References: <20090430153419.12628.91088.stgit@bob.kio> <20090430153537.12628.5751.stgit@bob.kio> <alpine.LFD.2.00.0905271840110.25587@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:22785 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965AbZE1ACe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2009 20:02:34 -0400
In-Reply-To: <alpine.LFD.2.00.0905271840110.25587@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>, Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Matthew Garrett <mjg@redhat.com>

On Wednesday 27 May 2009 04:41:15 pm Len Brown wrote:
> On Thu, 30 Apr 2009, Bjorn Helgaas wrote:
> 
> > System notify events (0x00-0x7f) are common across all device types
> > and should be handled in Linux/ACPI, not in drivers.  However, some
> > BIOSes use system notify events in device-specific ways that require
> > the driver to be involved.
> > 
> > This patch adds a ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag.  When a
> > driver sets this flag and supplies a .notify method, Linux/ACPI calls
> > the .notify method for ALL notify events on the device, not just the
> > device-specific (0x80-0xff) events.
> 
> What bad things would happen if we did this by default
> rather than requiring a driver to ask for it?

If the Linux/ACPI code were doing the right thing, I don't think
drivers would have to know about the system events.

I think some of the drivers that use ACPI_ALL_NOTIFY probably do
it to deal with BIOSes that use system events when they should be
using device events.  And some are probably using it unnecessarily.

If we sent all events to drivers by default, I guess we'd have
to tweak a few driver .notify methods to ignore the system ones.
Maybe that's the right thing.

Bjorn

> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > ---
> >  drivers/acpi/bus.c      |    6 +++++-
> >  include/acpi/acpi_bus.h |    3 +++
> >  2 files changed, 8 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index e8f7b64..fd6a930 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -549,6 +549,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
> >  {
> >  	int result = 0;
> >  	struct acpi_device *device = NULL;
> > +	struct acpi_driver *driver;
> >  
> >  	blocking_notifier_call_chain(&acpi_bus_notify_list,
> >  		type, (void *)handle);
> > @@ -629,7 +630,10 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
> >  		break;
> >  	}
> >  
> > -	return;
> > +	driver = device->driver;
> > +	if (driver && driver->ops.notify &&
> > +	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
> > +		driver->ops.notify(device, type);
> >  }
> >  
> >  /* --------------------------------------------------------------------------
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index c34b110..84e35d5 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -114,10 +114,13 @@ struct acpi_device_ops {
> >  	acpi_op_notify notify;
> >  };
> >  
> > +#define ACPI_DRIVER_ALL_NOTIFY_EVENTS	0x1	/* system AND device events */
> > +
> >  struct acpi_driver {
> >  	char name[80];
> >  	char class[80];
> >  	const struct acpi_device_id *ids; /* Supported Hardware IDs */
> > +	unsigned int flags;
> >  	struct acpi_device_ops ops;
> >  	struct device_driver drv;
> >  	struct module *owner;
> > 
> 



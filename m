From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH_v7 2/2] ACPI/IPMI: Add the IPMI opregion driver to enable ACPI to access BMC controller
Date: Thu, 15 Jul 2010 10:27:29 -0600
Message-ID: <201007151027.30025.bjorn.helgaas@hp.com>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com> <201007141124.57495.bjorn.helgaas@hp.com> <1279157466.3660.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:32668 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933677Ab0GOQ1d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jul 2010 12:27:33 -0400
In-Reply-To: <1279157466.3660.52.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>

On Wednesday, July 14, 2010 07:31:06 pm ykzhao wrote:
> On Thu, 2010-07-15 at 01:24 +0800, Bjorn Helgaas wrote:
> Will you please look at this thread
> http://marc.info/?l=linux-acpi&m=127608894610765&w=4?
> 
> Before this patch, I followed your comment and put the ACPI IPMI
> opregion code into the IPMI_SI module. 
> 
> But in fact the IPMI opregion code has nothing to do with the ipmi
> system interface. It is enough to use the IPMI API interface. In such
> case maybe it is a better choice to put the IPMI opregion code into the
> separate file. (In fact Corey suggests that the IPMI opregion code be
> put into the separate file). 

The ACPI IPMI opregion code deals with an ACPI device, and the
obvious place where you have that device is the driver "add"
function, i.e., ipmi_pnp_probe().  That's the point where the
PNP core will help you out by matching device IDs and handling
hotplug for you.

You can kludge around and do it elsewhere, but it's going to be
more work.

> > But I don't think this is the right design.  I think it's fine to
> > put all this code in a separate file and have a separate config
> > option for it.
> > 
> > However, I don't think acpi_ipmi and ipmi_si should be different
> > modules, because they both want to be connected to the same ACPI
> > device.  Making acpi_ipmi a separate module means you have to
> > mess around with PNP core things that drivers shouldn't be using.
> > For example, you have match_device(), pnp_ipmi_match(), and
> > acpi_add_ipmi_devices() below.  These all reimplement things
> > the PNP core already does.
> 
> If we decide to put the IPMI opregion code into the separate file, the
> next is how to *correctly* create the IPMI user interface between ACPI
> subsystem and the corresponding BMC controller.The user interface is the
> communication channel used to send/receive IPMI message to/from the BMC
> controller. 
> In such case we will use the IPMI smi watcher to create/destroy the IPMI
> user interface between ACPI and the corresponding BMC controller. But it
> is noted that we should assure whether the corresponding IPMI BMC
> controller is registered by using ACPI detection mechanism when creating
> the relationship between ACPI and IPMI BMC controller. This is realized
> by comparing the "device handle". And before comparing the "device
> handle", maybe we will have to get the corresponding device lists with
> the device id "IPI0001".
> 
> Do you have other idea about how to *correctly* create the user
> interface between ACPI and IPMI BMC controller?

I don't have time right now to design something new for this.

You should handle hotplug of IPI0001 devices, but you call
acpi_add_ipmi_devices() only once, at module-load time.  That
makes me think the sequence "load ipmi_si, load acpi_ipmi,
hot-add IPI0001" will not work.  I think ipmi_si will see the
new device, but I don't think acpi_ipmi will.

We should not export pnp_bus_type.  Maybe you can avoid this by
maintaining some sort of list in ipmi_si, although then you're back
to having to deal with hotplug yourself.  You'd have to have
coordinate ipmi_pnp_probe() and ipmi_pnp_remove() events between
ipmi_si and acpi_ipmi.

> > > +static void ipmi_bmc_gone(int iface)
> > > +{
> > > +	struct acpi_ipmi_device *ipmi_device, *temp;
> > > +
> > > +	if (list_empty(&driver_data.ipmi_devices))
> > > +		return;
> > 
> > You don't need to test for list_empty before using
> > list_for_each_entry_safe()
> 
> IMO it is needed as it does the operation of list deletion.

I don't think so:

 * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry

Bjorn

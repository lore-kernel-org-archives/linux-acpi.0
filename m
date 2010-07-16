From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH_v7 2/2] ACPI/IPMI: Add the IPMI opregion driver to
	enable ACPI to access BMC controller
Date: Fri, 16 Jul 2010 10:34:35 +0800
Message-ID: <1279247675.3660.104.camel@localhost.localdomain>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com>
	 <201007141124.57495.bjorn.helgaas@hp.com>
	 <1279157466.3660.52.camel@localhost.localdomain>
	 <201007151027.30025.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:49013 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935323Ab0GPCiP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Jul 2010 22:38:15 -0400
In-Reply-To: <201007151027.30025.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "minyard@acm.org" <minyard@acm.org>

On Fri, 2010-07-16 at 00:27 +0800, Bjorn Helgaas wrote:
> On Wednesday, July 14, 2010 07:31:06 pm ykzhao wrote:
> > On Thu, 2010-07-15 at 01:24 +0800, Bjorn Helgaas wrote:
> > Will you please look at this thread
> > http://marc.info/?l=linux-acpi&m=127608894610765&w=4?
> > 
> > Before this patch, I followed your comment and put the ACPI IPMI
> > opregion code into the IPMI_SI module. 
> > 
> > But in fact the IPMI opregion code has nothing to do with the ipmi
> > system interface. It is enough to use the IPMI API interface. In such
> > case maybe it is a better choice to put the IPMI opregion code into the
> > separate file. (In fact Corey suggests that the IPMI opregion code be
> > put into the separate file). 
> 
> The ACPI IPMI opregion code deals with an ACPI device, and the
> obvious place where you have that device is the driver "add"
> function, i.e., ipmi_pnp_probe().  That's the point where the
> PNP core will help you out by matching device IDs and handling
> hotplug for you.

The "IPI0001" device defined in ACPI table serves the following two
purposes:
 	1. IPMI detection and registration: This is defined in IPMI spec. Now
it is discovered in the drivers/char/ipmi/ipmi_si_intf
        2. IPMI opregion support: This is defined in ACPI4.0 spec.This
is to enable that the ACPI AML code can communicate with the BMC
controller. 

Yes. If we put the opregion code with the detection code together, it
will be simple. And it is unnecessary to get the corresponding device
list again. But as the IPMI opregion code only uses the API interface of
IPMI subsystem, it will be better to put it into the separate file. In
fact this is also Corey's idea. 

> 
> You can kludge around and do it elsewhere, but it's going to be
> more work.
> 
> > > But I don't think this is the right design.  I think it's fine to
> > > put all this code in a separate file and have a separate config
> > > option for it.
> > > 
> > > However, I don't think acpi_ipmi and ipmi_si should be different
> > > modules, because they both want to be connected to the same ACPI
> > > device.  Making acpi_ipmi a separate module means you have to
> > > mess around with PNP core things that drivers shouldn't be using.
> > > For example, you have match_device(), pnp_ipmi_match(), and
> > > acpi_add_ipmi_devices() below.  These all reimplement things
> > > the PNP core already does.
> > 
> > If we decide to put the IPMI opregion code into the separate file, the
> > next is how to *correctly* create the IPMI user interface between ACPI
> > subsystem and the corresponding BMC controller.The user interface is the
> > communication channel used to send/receive IPMI message to/from the BMC
> > controller. 
> > In such case we will use the IPMI smi watcher to create/destroy the IPMI
> > user interface between ACPI and the corresponding BMC controller. But it
> > is noted that we should assure whether the corresponding IPMI BMC
> > controller is registered by using ACPI detection mechanism when creating
> > the relationship between ACPI and IPMI BMC controller. This is realized
> > by comparing the "device handle". And before comparing the "device
> > handle", maybe we will have to get the corresponding device lists with
> > the device id "IPI0001".
> > 
> > Do you have other idea about how to *correctly* create the user
> > interface between ACPI and IPMI BMC controller?
> 
> I don't have time right now to design something new for this.

Yes. The hotplug scenario should be considered. This will be handled
under two places:
   a. the IPMI pnp detection: 
   b. install opregion handle for the hotplug IPI0001 device

But in fact the acpi_pnp device is enumerated only once at the boot
time. In such case it is impossible to get the corresponding pnp device
when one "IPI0001" device is hotplug. Of course the "ipmi_si" can't see
the hotplugged "IPI0001" device.  If we really want to handle the
hotplug scenario, IMO we should change the detection mechanism from pnp
to ACPI again. Otherwise it is difficult to handle the hotplug scenario.

It is an idea to maintain the device list of "impi_si". But if we look
at the source code of "ipmi_si_intf", the corresponding device list is
defined as *static*. 

Another matter is that the "info->dev" in ipmi_pnp_probe is changed from
acpi_dev to pnp_dev. Now in order to *correctly* create the user
interface between ACPI and BMC controller, it is realized by comparing
the "device handle". And the prerequisite is that we should get the
corresponding pnp device list of "IPI0001". 
If we don't export the symbol of "pnp_bus_type", do you have any idea to
get the corresponding device list of "IPI0001"? 

Of course I can firstly get the ACPI device list of "IPI0001" and then
get the corresponding "pnp_dev" for every ACPI device of "IPI0001". But
it is more complex. 

> 
> You should handle hotplug of IPI0001 devices, but you call
> acpi_add_ipmi_devices() only once, at module-load time.  That
> makes me think the sequence "load ipmi_si, load acpi_ipmi,
> hot-add IPI0001" will not work.  I think ipmi_si will see the
> new device, but I don't think acpi_ipmi will.
> 
> We should not export pnp_bus_type.  Maybe you can avoid this by
> maintaining some sort of list in ipmi_si, although then you're back
> to having to deal with hotplug yourself.  You'd have to have
> coordinate ipmi_pnp_probe() and ipmi_pnp_remove() events between
> ipmi_si and acpi_ipmi.
> 
> > > > +static void ipmi_bmc_gone(int iface)
> > > > +{
> > > > +	struct acpi_ipmi_device *ipmi_device, *temp;
> > > > +
> > > > +	if (list_empty(&driver_data.ipmi_devices))
> > > > +		return;
> > > 
> > > You don't need to test for list_empty before using
> > > list_for_each_entry_safe()
> > 
> > IMO it is needed as it does the operation of list deletion.
> 
> I don't think so:
> 
>  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry

There exist a lot of examples about the removal of list_entry by using
list_for_each_entry_safe. For example:
   >drivers/char/ipmi/ipmi_msghandler.c

> 
> Bjorn


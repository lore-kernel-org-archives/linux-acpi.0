From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 4/11]makeing dock driver supports bay and battery
	hotplug
Date: Mon, 22 Sep 2008 09:24:54 +0800
Message-ID: <1222046694.7241.3.camel@sli10-desk.sh.intel.com>
References: <1219889038.29375.29.camel@sli10-desk.sh.intel.com>
	 <200809181910.03573.trenn@suse.de>  <200809182116.58202.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:22861 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbYIVBY5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Sep 2008 21:24:57 -0400
In-Reply-To: <200809182116.58202.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

On Thu, 2008-09-18 at 13:16 -0600, Thomas Renninger wrote:
> On Thursday 18 September 2008 19:10:02 Thomas Renninger wrote:
> > Sorry for the late reply...
> >
> > On Thursday 28 August 2008 04:03:58 Shaohua Li wrote:
> > > Making dock driver supports bay and battery hotplug. They are all
> > > regarded as dock, and unified handled.
> > >
> > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > ---
> >
> > ...
> >
> > > +
> > > +static int is_battery(acpi_handle handle)
> > > +{
> > > +   struct acpi_device_info *info;
> > > +   struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> > > +   int ret = 1;
> > > +
> > > +   if (!ACPI_SUCCESS(acpi_get_object_info(handle, &buffer)))
> > > +           return 0;
> > > +   info = buffer.pointer;
> > > +   if (!(info->valid & ACPI_VALID_HID))
> > > +           ret = 0;
> > > +   else
> > > +           ret = !strcmp("PNP0C0A", info->hardware_id.value);
> > > +
> > > +   kfree(buffer.pointer);
> >
> > Better get the device and then use:
> > const struct acpi_device_id battery_device_ids[] = {
> >         {"PNP0C0A", 0},
> >         {"", 0},
> > };
> > acpi_match_device_ids(struct acpi_device *device, battery_device_ids);
> > No need to allocate memory. This also matches batteries where the ID might
> > be hidden in the CID list.
> > ...
> Above is still valid.
No, this doesn't work. there isn't a acpi_device because battery is
absent when this is called, but I could add CID support.

> Below are simply questions to better understand what the patches are for.
> Thanks to Holger, I get a bit clearer picture now.
> While these patches are needed to get things going for now, would it be
> possible for the future to add a directory "dependent_devices" into a dock's
> sysfs entry and fill it with links to devices for which userspace has to care
> for?
Yes, we need this. Holger mentioned he want to add this after the patch
is merged. This isn't urgent currently.

> > Something general:
> > I do not like the idea of this approach.
> > Battery and ATA device do get an eject notification?
> > Why can't they handle things themselves?
> > What is the gain to make battery and ata "dock" capable devices?
> > What if a PCI(e) device or whatever other device is also connected to the
> > docking station. Do we want to add all devices attached to a dock station
> > statically?
> >
> > Would it make sense to add (if notifications are sent to these even this
> > should not be needed):
> >   .eject
> >   .dock
> > functions. The dock driver can then go down the tree and call all
> > children's eject functions.
> >
> > I wonder how this can be solved in a more generic way.
> >
> > Also this patchset mixes up sever fixes and dock design changes patches.
> > It would be great if the fixes can just go into test, not sure about the
> > design change...
> Some of the patches looked like it would be worth for .27, but it's too late
> now anyway and the problem I hoped it could fix (kacpid utilizes 100% of CPU
> after suspend, due to _STA -> notify loop) is not solved by these according
> to Holger.
Yes, this patch set just fixed some bugs. Is there a bugzilla for this
issue I can look at?

Thanks,
Shaohua


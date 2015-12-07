From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] ACPI / scan: Fix acpi_bus_id_list bookkeeping
Date: Mon, 07 Dec 2015 02:39:17 +0100
Message-ID: <2186235.0HReUg0eSH@vostro.rjw.lan>
References: <cover.1448480385.git.lukas@wunner.de> <565EB24F.8070005@huawei.com> <20151206210919.GA29070@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62750 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753026AbbLGBJV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Dec 2015 20:09:21 -0500
In-Reply-To: <20151206210919.GA29070@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, devel@acpica.org, Robert Moore <robert.moore@intel.com>, Mark Brown <broonie@kernel.org>, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>, Hanjun Guo <guohanjun@huawei.com>

On Sunday, December 06, 2015 10:09:19 PM Lukas Wunner wrote:
> Hi Rafael,

Hi,
 
> a gentle ping, not sure if you just haven't had time to look at this
> thread or if it's fallen between the cracks.

Neither of these.

I'm actually going to apply your patches.

> (Further comments from me below.)
>
> On Wed, Dec 02, 2015 at 04:56:47PM +0800, Hanjun Guo wrote:
> > On 2015/12/1 21:08, Lukas Wunner wrote:
> > > Hi,
> > >
> > > On Mon, Nov 30, 2015 at 04:14:32PM +0800, Hanjun Guo wrote:
> > >> On 2015/11/30 14:27, Hanjun Guo wrote:
> > >>> On 2015/11/26 4:19, Lukas Wunner wrote:
> > >>>> acpi_device_add() allocates and adds an element to acpi_bus_id_list
> > >>>> (or increments the instance count if the device's HID is already
> > >>>> present in the list), but the element is never deleted from the list
> > >>>> nor freed. Fix it.
> > >>> Hmm, I didn't get it here. Seems the device's ID already freed in device core:
> > >>>
> > >>>  In acpi_add_single_object(), acpi_device_release() registered as a callback,
> > >>> ...
> > >>>   result = acpi_device_add(device, acpi_device_release);
> > >>> ...
> > >>>
> > >>> And in acpi_device_release(), it will call acpi_free_pnp_ids() to free the
> > >>> IDs, did I miss some something?
> > >> Sorry, I misread the code, I thought it was the pnn ids connect to the ACPI device,
> > >> actually you are referring to HIDs connecting to acpi_bus_id_list, sorry for the noise.
> > > Yes, I should have been more clear about this in the first place:
> > >
> > > When the bus is scanned and acpi_device_add() is called for each device,
> > > not only do we initialize a struct acpi_device and attach it to the
> > > device tree, but we also add an element to acpi_bus_id_list.
> > >
> > > Hence there are two ways to detect the presence of a HID: By traversing
> > > the device tree or by iterating over the list. I chose the latter because
> > > it is obviously cheaper and requires less code.
> > >
> > > However elements only ever get added to the list, never deleted. I'm not
> > > sure if hotpluggable ACPI devices exist but if they do, this is a bug
> > > which is fixed by this patch.
> > 
> > ACPI devices can be hotpluggable :) , but it will have no memory leak I think, it
> > only increase the instance number for ACPI devices removed and hot-added later,
> > I don't know if it make sense to do that, for example, if you remove device A and
> > B with same HID (such as ACPI0007) with your patch added:
> > 
> > remove processor 0, the sysfs for device A /sys/bus/acpi/devices/ACPI0007:00 will be
> > removed;
> > 
> > remove processer 1, the sysfs for device B /sys/bus/acpi/devices/ACPI0007:01 will be
> > removed;
> > 
> > But if we add it in reverse with your patch:
> > 
> > Add dprocesser 1, the sysfs /sys/bus/acpi/devices/ACPI0007:00 will be created,
> > 
> > add processor 0...
> > 
> > I'm not sure it will confuse user space or not.
> > 
> > Rafael, what's your opinion here?
> 
> Yes, with this patch the instance number is no longer strictly increasing
> and if devices are unplugged and replaced, instance numbers are recycled
> for the newly plugged devices. I have no idea if this can break things.

Maybe.  I guess it may confuse user space on some systems if it cached
the old device names somehow, but since the instance numbers change right
now anyway, that is unlikely.

> If this patch is not acceptable, the semantics of patch [v2 2/2] change
> in that acpi_dev_present() doesn't return the presence of a HID at the
> time of invocation, but rather whether such a device has ever been present
> since boot. It wouldn't be a problem because acpi_dev_present() is
> meant for presence detection of devices which are built into the system
> (same goes for the PCI counterpart pci_dev_present(), see the kerneldoc
> in drivers/pci/search.c). I'd have to adjust the kerneldoc though to
> reflect the changed semantics.
> 
> The other option would be to traverse the acpi_device tree instead of
> iterating over acpi_bus_id_list, then it would be possible to retain
> the semantics of detecting presence at the moment of invocation.
> 
> Please let me know which of these options makes the most sense to you
> so that I can adjust the patches.

The simplest one that works for all of the users in question should be fine.

Thanks,
Rafael


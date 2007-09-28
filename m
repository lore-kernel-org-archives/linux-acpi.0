From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Bug: linux/acpi may execute notify handler that
	has	been	removed
Date: Fri, 28 Sep 2007 11:37:06 +0800
Message-ID: <1190950626.4129.26.camel@acpi-hp.sh.intel.com>
References: <1190863833.26892.63.camel@acpi-hp.sh.intel.com>
	 <1190868847.22470.0.camel@sli10-conroe.sh.intel.com>
	 <46FB4CAD.7050201@suse.de>
	 <1190873430.22927.1.camel@sli10-conroe.sh.intel.com>
	 <46FB4EBC.8030107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23743 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104AbXI1Dbf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2007 23:31:35 -0400
In-Reply-To: <46FB4EBC.8030107@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

On Thu, 2007-09-27 at 14:33 +0800, Alexey Starikovskiy wrote:
> Shaohua Li wrote:
> > On Thu, 2007-09-27 at 10:24 +0400, Alexey Starikovskiy wrote:
> >> Shaohua Li wrote:
> >>> On Thu, 2007-09-27 at 11:30 +0800, Zhang Rui wrote:
> >>>> Hi, all,
> >>>>
> >>>> I found a bug that linux/acpi may execute notify handler that
> >>>> has been removed.
> >>>>
> >>>> When a system notify(0~0x7f) is received, linux/acpi will
> >>>> first invoke the generic system notify handler (acpi_bus_notify)
> >>>> and then invoke the per-device notify handler if present.
> >>>>
> >>>> In my case, I add some code in acpi_bus_notify for battery
> >>>> hotplug support, so that the generic system notify handler will
> >>>> remove the battery device, including the per-device notify
> handler
> >>>> acpi_battery_notify() when receiving notification
> >>>> ACPI_NOTIFY_EJECT_REQUEST.
> >>>> But linux/acpi invokes the per-device notify handler soon and
> >>>> this breaks the system.
> >>>>
> >>>> Further more, device hot-removal is not the only case to
> encounter
> >>>> this bug. For example, linux/acpi receives a notification and
> adds it
> >>>> in the workqueue, and then the driver(notify handler) is removed
> >>>> before kacpid_notify invoke it...
> >>> For the non-hotplug case, adding a flush work queue just after
> notify
> >>> handler is removed should be ok.
> >> I think, the real problem with ACPI hotplug is that we know which
> devices might appear --
> >> they are all enumerated in DSDT, but we don't add them until they
> appear.
> >> If we do .add for all devices in DSDT, and then just .start/.stop
> them as they appear/disappear,
> >> we will have to do much less work, and avoid a problem described
> above...
> > If a device is not present, you can't access any method of it.
> What is because you didn't call .add() yet, or already
> called .remove(), yes?
> >
Hi, Alexey, sorry that I'm not quite clear about what you mean above.
IMO, many methods are evaluated to set all kinds of flags during the
acpi_scan_init(), which may be invalid if the device isn't
physically present.

> > The real problem here is ACPICA will call some drivers routines
> > (notification handler), but doesn't get a reference count of the
> driver
> > module.
> We just should be able to load drivers for declared, but physically
> absent devices.
> >
For the hot-plug case, we can move all the code to the per-device notify
handler, which is called in the last minute.
Then in the generic notify handler, we need to send a uevent to load
the driver dynamically when a new device is inserted.
Or we can add the hot_add code in generic notify handler and move the
hot_removal code to the per-device notify handler, this is much easier
while it's a kind of ugly.

Thanks,
Rui

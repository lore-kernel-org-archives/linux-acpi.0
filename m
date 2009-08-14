From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 14 Aug 2009 19:18:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0908141854110.15176@sister.anvils>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org>
 <Pine.LNX.4.64.0908131724370.8831@sister.anvils> <1250213336.2987.3.camel@minggr.sh.intel.com>
 <200908141044.51799.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mk-filter-1-a-1.mail.uk.tiscali.com ([212.74.100.52]:32932 "EHLO
	mk-filter-1-a-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752796AbZHNSTO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Aug 2009 14:19:14 -0400
In-Reply-To: <200908141044.51799.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Fri, 14 Aug 2009, Bjorn Helgaas wrote:
> On Thursday 13 August 2009 07:28:56 pm Lin Ming wrote:
> > On Fri, 2009-08-14 at 00:46 +0800, Hugh Dickins wrote:
> > > My original patch, when I hit the bug, was just to
> > > acpi_device_install_notify_handler(): I have never seen a
> > > problem anywhere else, and your patch would deal with that.
> > > 
> > > But Lin Ming believes there might be issues elsewhere (I have no idea),
> > > posting a more general patch; then my patch here was a retort to that.
> > > 
> > > What I'm saying is: so far as I know, your patch is more appropriate
> > > than mine; but probably Lin Ming knows better, and mine needed too.
> > 
> > As below, there are many calls of acpi_device_hid without any check of
> > NULL hid.
> > So yes, we need a general patch, as yours.
> 
> I'm a little concerned because there's a deeper issue here, and I
> want to make sure we have a clean solution and not a temporary band-aid.

Yes, without appreciating any of the details, I believe you're right
to have that concern.

And, maybe irrelevant, but I'd noticed a line in acpi_device_register:
    if(!strcmp(acpi_device_bus_id->bus_id,
	device->flags.hardware_id? device->pnp.hardware_id : "device"))
which made me wonder if the band-aid should say "device" rather than "".

> 
> In general, ACPI drivers bind to an acpi_device based on the HID.
> There are a few exceptions where drivers walk the namespace themselves
> and look for things other than the HID, but IMHO, this is a problem
> because those drivers won't work for devices added or removed after
> the driver loads.
> 
> I think we'd be better off if we made a rule that "every acpi_device
> has a non-empty HID."  That way, we could get drivers out of the
> business of walking the namespace, which would fix some hotplug issues.
> We already synthesize a number of Linux-specific HIDs (LNXPOWER,
> LNXCPU, LNXVIDEO, etc), and I think the Linux/ACPI core should
> probably do this whenever we build an acpi_device for an object
> with no _HID method.

I don't know my way around here, I cannot comment.

> 
> I don't quite understand how this oops happens, though.  It seems that
> we crashed in this path:
> 
>   acpi_device_probe
>     acpi_bus_driver_init
>       driver->ops.add  (calls acpi_video_bus_add)
>     acpi_device_install_notify_handler
>       hid = acpi_device_hid(device)
>       strcmp(hid, ACPI_BUTTON_HID_POWERF))
>         *** OOPS, hid == NULL ***
> 
> But the acpi_video_bus driver claims devices using ACPI_VIDEO_HID
> ("LNXVIDEO"), and acpi_device_set_id() already does synthesize
> that HID, so acpi_device_hid() should have been valid.  So why
> did we oops?

The backtrace I jotted down, from Intel 915 graphics, looked like this
(acpi_device_install_notify_handler is inlined into acpi_device_probe):

strcmp
acpi_device_probe
really_probe
driver_probe_device
__driver_attach
bus_for_each_dev
driver_attach
bus_add_driver
driver_register
acpi_bus_register
acpi_video_register
intel_opregion_init
i915_driver_load
drm_get_dev
drm_init
i915_init
do_one_initcall
do_basic_setup
kernel_init
kernel_thread_helper

Valdis reported a similar but shorter hand-copied backtrace from
nVidia Corporation G72M [Quadro NVS 110M/GeForce Go 7300] (rev a1):

strcmp+0x4/0x1f
acpi_device+probe+0xac/0x13e
driver_probe_device+0xc9/0x14e
__driver_attach+0x58/0x7c
? __driver_attach+0x58/0x7c
? __driver_attach+0x58/0x7c
bus_for_each_dev+0x54/0x89
driver_attach+0x19/0x1b
bus_add_driver+0xv4/0x1fe
driver_register+0xb7/0x128
? acpi_video_init+0x0/0x17
acpi_bus_register_driver+0x3e/0x42
acpi_video_register+0x42/0x6e
acpi_video_init+0x15/0x17
do_one_initcall+0x56/0x130

Hugh

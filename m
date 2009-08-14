From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 14 Aug 2009 10:44:50 -0600
Message-ID: <200908141044.51799.bjorn.helgaas@hp.com>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org> <Pine.LNX.4.64.0908131724370.8831@sister.anvils> <1250213336.2987.3.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:6416 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709AbZHNQow (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 12:44:52 -0400
In-Reply-To: <1250213336.2987.3.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Hugh Dickins <hugh.dickins@tiscali.co.uk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Thursday 13 August 2009 07:28:56 pm Lin Ming wrote:
> On Fri, 2009-08-14 at 00:46 +0800, Hugh Dickins wrote:
> > My original patch, when I hit the bug, was just to
> > acpi_device_install_notify_handler(): I have never seen a
> > problem anywhere else, and your patch would deal with that.
> > 
> > But Lin Ming believes there might be issues elsewhere (I have no idea),
> > posting a more general patch; then my patch here was a retort to that.
> > 
> > What I'm saying is: so far as I know, your patch is more appropriate
> > than mine; but probably Lin Ming knows better, and mine needed too.
> 
> As below, there are many calls of acpi_device_hid without any check of
> NULL hid.
> So yes, we need a general patch, as yours.

I'm a little concerned because there's a deeper issue here, and I
want to make sure we have a clean solution and not a temporary band-aid.

In general, ACPI drivers bind to an acpi_device based on the HID.
There are a few exceptions where drivers walk the namespace themselves
and look for things other than the HID, but IMHO, this is a problem
because those drivers won't work for devices added or removed after
the driver loads.

I think we'd be better off if we made a rule that "every acpi_device
has a non-empty HID."  That way, we could get drivers out of the
business of walking the namespace, which would fix some hotplug issues.
We already synthesize a number of Linux-specific HIDs (LNXPOWER,
LNXCPU, LNXVIDEO, etc), and I think the Linux/ACPI core should
probably do this whenever we build an acpi_device for an object
with no _HID method.

I don't quite understand how this oops happens, though.  It seems that
we crashed in this path:

  acpi_device_probe
    acpi_bus_driver_init
      driver->ops.add  (calls acpi_video_bus_add)
    acpi_device_install_notify_handler
      hid = acpi_device_hid(device)
      strcmp(hid, ACPI_BUTTON_HID_POWERF))
        *** OOPS, hid == NULL ***

But the acpi_video_bus driver claims devices using ACPI_VIDEO_HID
("LNXVIDEO"), and acpi_device_set_id() already does synthesize
that HID, so acpi_device_hid() should have been valid.  So why
did we oops?

Bjorn

> 0 drivers/acpi/button.c                 acpi_button_add                     308 hid = acpi_device_hid(device);
> 1 drivers/acpi/processor_core.c         acpi_processor_get_info             599 if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
> 2 drivers/acpi/scan.c                   acpi_device_install_notify_handler  378 hid = acpi_device_hid(device);
> 3 drivers/acpi/scan.c                   acpi_device_remove_notify_handler   402 if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWERF))
> 4 drivers/acpi/scan.c                   acpi_device_remove_notify_handler   405 else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEPF))
> 5 drivers/acpi/video.c                  acpi_video_bus_add                 2248 "%s/video/input0", acpi_device_hid(video->device));
> 6 drivers/gpu/drm/i915/intel_lvds.c     check_lid_device                    822 if (!strncmp(acpi_device_hid(acpi_dev), "PNP0C0D", 7))
> 7 drivers/platform/x86/fujitsu-laptop.c acpi_fujitsu_add                    681 "%s/video/input0", acpi_device_hid(device));
> 8 drivers/platform/x86/fujitsu-laptop.c acpi_fujitsu_hotkey_add             852 "%s/video/input0", acpi_device_hid(device));
> 9 drivers/pnp/pnpacpi/core.c            pnpacpi_add_device                  162 if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
> a drivers/pnp/pnpacpi/core.c            pnpacpi_add_device                  166 dev = pnp_alloc_dev(&pnpacpi_protocol, num, acpi_device_hid(device));


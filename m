From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Sat, 15 Aug 2009 16:14:22 +0200
Message-ID: <200908151614.22326.bzolnier@gmail.com>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org> <31067.1250279620@turing-police.cc.vt.edu> <200908141410.53840.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:64900 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZHOOPQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Aug 2009 10:15:16 -0400
Received: by fxm11 with SMTP id 11so1603048fxm.39
        for <linux-acpi@vger.kernel.org>; Sat, 15 Aug 2009 07:15:16 -0700 (PDT)
In-Reply-To: <200908141410.53840.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Valdis.Kletnieks@vt.edu, Lin Ming <ming.m.lin@intel.com>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday 14 August 2009 22:10:53 Bjorn Helgaas wrote:
> On Friday 14 August 2009 01:53:40 pm Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 14 Aug 2009 10:44:50 MDT, Bjorn Helgaas said:
> > 
> > > I don't quite understand how this oops happens, though.  It seems that
> > > we crashed in this path:
> > > 
> > >   acpi_device_probe
> > >     acpi_bus_driver_init
> > >       driver->ops.add  (calls acpi_video_bus_add)
> > >     acpi_device_install_notify_handler
> > >       hid = acpi_device_hid(device)
> > >       strcmp(hid, ACPI_BUTTON_HID_POWERF))
> > >         *** OOPS, hid == NULL ***
> > > 
> > > But the acpi_video_bus driver claims devices using ACPI_VIDEO_HID
> > > ("LNXVIDEO"), and acpi_device_set_id() already does synthesize
> > > that HID, so acpi_device_hid() should have been valid.  So why
> > > did we oops?
> > 
> > When I tripped over it, acpi_device_set_id() *wasn't* synthesizing an HID,
> > it was explicitly setting a NULL pointer.
> 
> What I don't understand is why the acpi_video_bus driver could get
> bound to the device if the device didn't have a HID.

This was also puzzling me while I hit the original issue so I did some more
research at that time and it turned out that binding is not controlled by
HID but by ->ops.add method of ACPI driver.

In the case of ACPI video driver it goes like that (for 2.6.31-rc6):

acpi_device_probe()
  acpi_bus_driver_init()
    driver->ops.add() [ acpi_video_bus_add() ]
      acpi_video_bus_check()

and in acpi_video_bus_check() we have:

...
	/* Since there is no HID, CID and so on for VGA driver, we have
	 * to check well known required nodes.
	 */

	/* Does this device support video switching? */
	if (video->cap._DOS) {
		video->flags.multihead = 1;
		status = 0;
	}

	/* Does this device support retrieving a video ROM? */
	if (video->cap._ROM) {
		video->flags.rom = 1;
		status = 0;
	}

	/* Does this device support configuring which video device to POST? */
	if (video->cap._GPD && video->cap._SPD && video->cap._VPO) {
		video->flags.post = 1;
		status = 0;
	}

	return status;
...

IOW HID is not required at all for ACPI device drivers at the moment which
becomes a problem after "ACPICA: Major update for acpi_get_object_info
external interface" commit since acpi_device_hid() will no longer return
a pointer to an empty static buffer but a NULL instead..

I think that ideally we should always have a valid HID for ACPI devices
(synthesized in case of ACPI video and similar devices) in the long-term
but could we get Hugh's patch applied for now, please?

While your patch also looks valid and most likely fixes ACPI video oops
Hugh's patch is still needed for fully fixing the problem at the moment
(i.e. ACPI button driver seems to need it).

This problem has been in ACPI tree (and thus in -next) for way too long
already (three weeks with the known fix) and the current situation is not
moving things forward (we have just people rediscovering the issue the
hard way)..

Thanks,
Bart

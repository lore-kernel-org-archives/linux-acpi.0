From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 14 Aug 2009 14:10:53 -0600
Message-ID: <200908141410.53840.bjorn.helgaas@hp.com>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org> <200908141044.51799.bjorn.helgaas@hp.com> <31067.1250279620@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:25886 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbZHNUKx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 16:10:53 -0400
In-Reply-To: <31067.1250279620@turing-police.cc.vt.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Lin Ming <ming.m.lin@intel.com>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Friday 14 August 2009 01:53:40 pm Valdis.Kletnieks@vt.edu wrote:
> On Fri, 14 Aug 2009 10:44:50 MDT, Bjorn Helgaas said:
> 
> > I don't quite understand how this oops happens, though.  It seems that
> > we crashed in this path:
> > 
> >   acpi_device_probe
> >     acpi_bus_driver_init
> >       driver->ops.add  (calls acpi_video_bus_add)
> >     acpi_device_install_notify_handler
> >       hid = acpi_device_hid(device)
> >       strcmp(hid, ACPI_BUTTON_HID_POWERF))
> >         *** OOPS, hid == NULL ***
> > 
> > But the acpi_video_bus driver claims devices using ACPI_VIDEO_HID
> > ("LNXVIDEO"), and acpi_device_set_id() already does synthesize
> > that HID, so acpi_device_hid() should have been valid.  So why
> > did we oops?
> 
> When I tripped over it, acpi_device_set_id() *wasn't* synthesizing an HID,
> it was explicitly setting a NULL pointer.

What I don't understand is why the acpi_video_bus driver could get
bound to the device if the device didn't have a HID.

Bjorn


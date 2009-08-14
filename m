From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [patch 9/9] acpi: fix NULL bug for HID/UID string
Date: Fri, 14 Aug 2009 09:28:56 +0800
Message-ID: <1250213336.2987.3.camel@minggr.sh.intel.com>
References: <200908062257.n76MvuCr024266@imap1.linux-foundation.org>
	 <Pine.LNX.4.64.0908070012490.11170@sister.anvils>
	 <200908130955.03393.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.64.0908131724370.8831@sister.anvils>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40257 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbZHNBc1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Aug 2009 21:32:27 -0400
In-Reply-To: <Pine.LNX.4.64.0908131724370.8831@sister.anvils>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hugh Dickins <hugh.dickins@tiscali.co.uk>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Fri, 2009-08-14 at 00:46 +0800, Hugh Dickins wrote:
> On Thu, 13 Aug 2009, Bjorn Helgaas wrote:
> > On Thursday 06 August 2009 05:18:12 pm Hugh Dickins wrote:
> > > It's up to Len to choose, but I thought we preferred...
> > > 
> > > From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> > > 
> > > acpi_device->pnp.hardware_id and unique_id are now allocated pointers,
> > > replacing the previous arrays.  acpi_device_install_notify_handler()
> > > oopsed on the NULL hid when probing the video device, 
> > 
> > I'm sorry I wasn't aware of the acpi_device_install_notify_handler()
> > issue until just now, since I added the code that oopses (46ec8598fd).
> 
> Sorry for not Cc'ing you: but you can hardly be blamed for
> not foreseeing future changes which might affect your code.
> 
> > 
> > I recently posted patches that removed the dependency on the HID
> > in this path:
> > 
> >   http://marc.info/?l=linux-acpi&m=124907623701270&w=2
> > 
> > I thought Len said they had been applied to acpi-test, but I don't
> > see them there.
> > 
> > But I don't object to Hugh's patch, since it might be useful for other
> > paths.
> 
> My original patch, when I hit the bug, was just to
> acpi_device_install_notify_handler(): I have never seen a
> problem anywhere else, and your patch would deal with that.
> 
> But Lin Ming believes there might be issues elsewhere (I have no idea),
> posting a more general patch; then my patch here was a retort to that.
> 
> What I'm saying is: so far as I know, your patch is more appropriate
> than mine; but probably Lin Ming knows better, and mine needed too.

As below, there are many calls of acpi_device_hid without any check of
NULL hid.
So yes, we need a general patch, as yours.

0 drivers/acpi/button.c                 acpi_button_add                     308 hid = acpi_device_hid(device);
1 drivers/acpi/processor_core.c         acpi_processor_get_info             599 if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
2 drivers/acpi/scan.c                   acpi_device_install_notify_handler  378 hid = acpi_device_hid(device);
3 drivers/acpi/scan.c                   acpi_device_remove_notify_handler   402 if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWERF))
4 drivers/acpi/scan.c                   acpi_device_remove_notify_handler   405 else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEPF))
5 drivers/acpi/video.c                  acpi_video_bus_add                 2248 "%s/video/input0", acpi_device_hid(video->device));
6 drivers/gpu/drm/i915/intel_lvds.c     check_lid_device                    822 if (!strncmp(acpi_device_hid(acpi_dev), "PNP0C0D", 7))
7 drivers/platform/x86/fujitsu-laptop.c acpi_fujitsu_add                    681 "%s/video/input0", acpi_device_hid(device));
8 drivers/platform/x86/fujitsu-laptop.c acpi_fujitsu_hotkey_add             852 "%s/video/input0", acpi_device_hid(device));
9 drivers/pnp/pnpacpi/core.c            pnpacpi_add_device                  162 if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
a drivers/pnp/pnpacpi/core.c            pnpacpi_add_device                  166 dev = pnp_alloc_dev(&pnpacpi_protocol, num, acpi_device_hid(device));

Lin Ming

> 
> Hugh


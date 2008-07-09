From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Wed, 9 Jul 2008 15:57:58 +0100
Message-ID: <20080709145758.GA22147@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <20080703162152.GC29110@srcf.ucam.org> <200807091649.52605.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44811 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYGIO6G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jul 2008 10:58:06 -0400
Content-Disposition: inline
In-Reply-To: <200807091649.52605.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>

On Wed, Jul 09, 2008 at 04:49:49PM +0200, Thomas Renninger wrote:
> On Thursday 03 July 2008 18:21:52 Matthew Garrett wrote:
> > On Thu, Jul 03, 2008 at 06:08:59PM +0200, Thomas Renninger wrote:
> > > +	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "DRDY", &h_dummy))) {
> > > +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found IGD device\n"));
> > > +		video_caps |= ACPI_VIDEO_IGD;
> > > +	}
> >
> > In principle, it's possible for a vendor to implement opregion but not
> > actually use it until the tche flags are set. If anyone's done that then
> > you've just broken backlight control on their system.
> 
> Who should set that flags?
> The dri driver is going to set that if he can serve IGD parts, right?

No. The opregion spec requires you to use video.ko. 

> Currently this patch makes the vendor specific e.g. thinkpad_acpi to serve 
> backlight brightness switching if a IGD device is found. Because currently 
> there is no IGD support in the kernel.

Yes, but that's *wrong*. There are many machines that support opregion 
but do not require its use - they'll behave using the old ACPI mechanism 
until you switch them to the new mode. Except right now if you switch 
them to the new mode then they'll stop working, because the DRI code 
isn't merged yet.

> You should export a function intel_opregion_init()? so that built in kernel 
> parts can check for IGD backlight support, instead of the lines above (part 
> of my patch). If this succeeds, my patch will tell vendor specfic drivers to 
> keep fingers off backlight switching.

No. Please read the opregion spec. The way it works is as follows:

1) Firmware exports an ACPI video class
2) OS checks whether the hardware supports the opregion ACPI video 
handling (this is done by looking at tables in a region of memory 
pointed at by a PCI configuration register)
3) OS sets opregion flags
4) OS calls the ACPI backlight set function
5) Firmware writes desired brightness to an opregion mailbox and 
triggers an interrupt
6) OS sets the brightness

For this to work, the ACPI video driver needs to work as it currently 
does. It is not correct for it to disable itself on IGD systems.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

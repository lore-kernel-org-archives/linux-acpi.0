From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH -mm] ACPI video: only one ACPI bus video device is
 allowed for one VGA controller
Date: Thu, 16 Jul 2009 08:49:49 -0300
Message-ID: <20090716114949.GB11928@khazad-dum.debian.net>
References: <1247649488.26272.106.camel@rzhang-dt>
 <20090715143103.GB22098@khazad-dum.debian.net>
 <4A5E5148.808@marcansoft.com>
 <1247711879.26272.186.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39050 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755060AbZGPLtx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jul 2009 07:49:53 -0400
Content-Disposition: inline
In-Reply-To: <1247711879.26272.186.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Hector Martin <hector@marcansoft.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 16 Jul 2009, Zhang Rui wrote:
> > > Laptops often have more than one video bus device, and you _have_ to choose
> > > the one that is _active_ (which might not be the first one you find).  This
> > > is done on laptops that can have either discrete or in-chipset graphics, for
> > > example.  I have seen it in several thinkpad models.
> > 
> > The video subsystem already picks only graphics devices that actually
> > exist in the PCI bus. The issue here is that there are two ACPI
> > "subdevices" under one address reference to a PCI device (which exists),
> > and both have backlight functionality.
> 
> right.
> For example,
> here is a laptop with both an integrated graphics (\_SB.PCI0.GFX0) and
> an external graphics (\_SB.PCI0.NVDI)
> we can find which one is active, NVDI or GFX0, and ignore the inactive
> one.

Well, those will likely change at runtime if we do our job properly to
support dual-GPU laptops that can change which one is active at runtime...
but hotplug support should be able to deal with it, but I don't know if the
ACPI video device does runtime hotplug/unplug and runtime bind/unbind
properly.  Does it?

However, some laptops (like my T43) do have two video devices, one of which
will never be enabled (because it is there for a separate mainboard which
has a different GPU).  This is correctly handled currently.

> But the bug that I want to fix in this patch is that,
> there are two ACPI video bus devices
> \_SB.PCI0.GFX0.VID1
> ???\_SB.PCI0.GFX0.VID2
> both are active because PCI device GFX0 exists, and ACPI tries to bind
> all these two devices to ACPI video driver.
> it's meaningless to have two ACPI video bus device for one VGA
> controller, right?

Unless your ACPI tables control each CRTC of the device separately... most
GPUs have at least two CRTCs nowadats, and that might mean two backlight
controllers as well, btw.  But this doesn't look like what happens on the
platform with the bug by the descriptions in this thread, and I know of no
device that would try to do something as crazy as what I described (if it is
allowed at all by the ACPI spec, which I didn't check)...

> and it messes up the backlight controller because notifications are sent
> to both VID1 and VID2 when brightness hotkey is pressed.

If you had *two* backlight controllers, that should just mean you are to
step them up/down together, nothing else...  However, if they handle the
same brightness hardware, yes, it _will_ cause problems (double stepping,
for example).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

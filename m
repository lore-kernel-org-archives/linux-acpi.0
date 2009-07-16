From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH -mm] ACPI video: only one ACPI bus video device is
	allowed for one VGA controller
Date: Thu, 16 Jul 2009 10:37:59 +0800
Message-ID: <1247711879.26272.186.camel@rzhang-dt>
References: <1247649488.26272.106.camel@rzhang-dt>
	 <20090715143103.GB22098@khazad-dum.debian.net>
	 <4A5E5148.808@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6777 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757074AbZGPChK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 22:37:10 -0400
In-Reply-To: <4A5E5148.808@marcansoft.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2009-07-16 at 05:59 +0800, Hector Martin wrote:
> Henrique de Moraes Holschuh wrote:
> > On Wed, 15 Jul 2009, Zhang Rui wrote:
> >> Only one ACPI video bus device for a VGA controller.
> >>
> >> Some buggy BIOS exports multiple ACPI video bus devices for the sa=
me
> >> VGA controller, and multiple backlight control methods as well.
> >> This messes up the ACPI video backlight control.
> >> http://bugzilla.kernel.org/show_bug.cgi?id=3D13577
> >>
> >> With this patch applied, only the first ACPI video bus device
> >> under a PCI device node is bind to ACPI video driver.
> >>
> >> The questions is that, we never notice this kind of devices before=
,
> >> thus I'm not sure this won't break any laptops.
> >=20
> > Laptops often have more than one video bus device, and you _have_ t=
o choose
> > the one that is _active_ (which might not be the first one you find=
).  This
> > is done on laptops that can have either discrete or in-chipset grap=
hics, for
> > example.  I have seen it in several thinkpad models.
>=20
> The video subsystem already picks only graphics devices that actually
> exist in the PCI bus. The issue here is that there are two ACPI
> "subdevices" under one address reference to a PCI device (which exist=
s),
> and both have backlight functionality.

right.
=46or example,
here is a laptop with both an integrated graphics (\_SB.PCI0.GFX0) and
an external graphics (\_SB.PCI0.NVDI)
we can find which one is active, NVDI or GFX0, and ignore the inactive
one.

But the bug that I want to fix in this patch is that,
there are two ACPI video bus devices
\_SB.PCI0.GFX0.VID1
=EF=BB=BF\_SB.PCI0.GFX0.VID2
both are active because PCI device GFX0 exists, and ACPI tries to bind
all these two devices to ACPI video driver.
it's meaningless to have two ACPI video bus device for one VGA
controller, right?
and it messes up the backlight controller because notifications are sen=
t
to both VID1 and VID2 when brightness hotkey is pressed.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

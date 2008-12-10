From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] PNPACPI: Enable Power Support
Date: Wed, 10 Dec 2008 21:26:02 -0200
Message-ID: <20081210232602.GC7589@khazad-dum.debian.net>
References: <493D8A1F.2090907@gmx.net> <20081210095315.GA20627@khazad-dum.debian.net> <200812101123.00055.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51987 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754614AbYLJX0G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2008 18:26:06 -0500
Content-Disposition: inline
In-Reply-To: <200812101123.00055.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <abelay@mit.edu>, rjw@sisk.pl

On Wed, 10 Dec 2008, Oliver Neukum wrote:
> Am Mittwoch, 10. Dezember 2008 10:53:15 schrieb Henrique de Moraes Ho=
lschuh:
> > Although I do wonder WTF we don't do that on our USB UHCI/EHCI kern=
el
> > drivers, that ACPI needs to step in to fix it. =A0If it is not a wa=
ke
>=20
> EHCI/UHCI have no way to power down host controllers.
> It needs external means, namely ACPI.

I see.  So we can't just set the pci devices to D0 to cut power to the =
USB
ports and USB controller while in STR?  Must be the EC stuff I just not=
iced
in the ACPI AML, then.

> > device, why are we leaving it powered up? =A0It is bad enough we do=
n't
> > have any sort of proper USB power control, but to leave the entire =
USB
> > subsystem powered up without reason?!
>=20
> We don't. If you unplug all devices, USB will power down as much as i=
s
> compatible with detecting new devices.

Thanks for the update.

> > Vista not only powers down the USB HCIs and ports on STR, it also
> > powers down ports when you "safely remove the USB device", and seem=
s
> > to leave the port powered down until you insert a device (or remove
> > the device already in there, whatever).
>=20
> If you cut power to a port, you cannot detect a hotplugging. You can
> suspend it, which Linux does do.

Hmm, probably it is just suspend, then (outside of STR.  On STR, it *is=
*
somehow powering down the ports when no wake devices are there, but tha=
t
might be done using extra stuff, and not just the PCI functions of the =
Intel
ICH6 EHCI/UHCI controllers).

I guess our userspace is not doing the suspend on "safely remove" then?
Because at least here, it is not behaving as Windows does when I tell K=
DE to
"safely eject" (which probably ends up being a HAL request of some sort=
).

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

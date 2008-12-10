From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] PNPACPI: Enable Power Support
Date: Wed, 10 Dec 2008 11:22:59 +0100
Message-ID: <200812101123.00055.oliver@neukum.org>
References: <493D8A1F.2090907@gmx.net> <20081210095315.GA20627@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:44033 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720AbYLJKVV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Dec 2008 05:21:21 -0500
In-Reply-To: <20081210095315.GA20627@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <abelay@mit.edu>, rjw@sisk.pl

Am Mittwoch, 10. Dezember 2008 10:53:15 schrieb Henrique de Moraes Hols=
chuh:
> Although I do wonder WTF we don't do that on our USB UHCI/EHCI kernel
> drivers, that ACPI needs to step in to fix it. =A0If it is not a wake

EHCI/UHCI have no way to power down host controllers.
It needs external means, namely ACPI.

> device, why are we leaving it powered up? =A0It is bad enough we don'=
t
> have any sort of proper USB power control, but to leave the entire US=
B
> subsystem powered up without reason?!

We don't. If you unplug all devices, USB will power down as much as is
compatible with detecting new devices.

> Vista not only powers down the USB HCIs and ports on STR, it also
> powers down ports when you "safely remove the USB device", and seems
> to leave the port powered down until you insert a device (or remove
> the device already in there, whatever).

If you cut power to a port, you cannot detect a hotplugging. You can
suspend it, which Linux does do.

	Regards
		Oliver



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

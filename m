From: Stefan Seyfried <seife@suse.de>
Subject: Re: acpiphp makes noise on every lid close/open
Date: Mon, 6 Nov 2006 20:13:51 +0100
Message-ID: <20061106191351.GA1642@suse.de>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061106132903.GA25257@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:61121 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752470AbWKFTOK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2006 14:14:10 -0500
Content-Disposition: inline
In-Reply-To: <20061106132903.GA25257@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Mon, Nov 06, 2006 at 11:29:03AM -0200, Henrique de Moraes Holschuh w=
rote:
> > > > There is a bug here in that acpiphp shouldn't even be used on t=
he X60 -
> > > > it has no hotpluggable slots.
>=20
> What about the internal mini PCI express slots (where the Intel 3945A=
BG
> device and EVDO wwwan cards are plugged)?

These are not in the media bay. I'd also guess that they are not
hotpluggable.
=20
> Also, ThinkWiki lists this machine as one that has a CardBus slot.  A=
 photo

The cardbus slot is also not in the media bay and AFAIK not handled by
acpiphp.

--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

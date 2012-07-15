From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PCI ACPI/IRQ-routing broken on H77 chipset + Ivy Bridge (kernel 3.5-rc7 and earlier)
Date: Sun, 15 Jul 2012 22:25:48 +0200
Message-ID: <201207152225.49154.rjw@sisk.pl>
References: <5002BC55.3050107@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:41500 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab2GOUUO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2012 16:20:14 -0400
In-Reply-To: <5002BC55.3050107@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Malte =?iso-8859-2?q?Schr=F6der?= <maltesch@gmx.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org

CC-ing linux-pci and Bjorn.

On Sunday, July 15, 2012, Malte Schr=F6der wrote:
> Hello,
> this is yet another try to get someone to look at this ;)
>=20
> I can't get PCI-devices to work on my DH77KC mainboard. I tested this
> using an AVM B1 ISDN card, a Fritz!PCI card and an old 3Com 905c NIC.
> I attached some dumps in case it helps. The CPU is a Core i7 3770.
>=20
> PCI hardware is detected by the kernel, but it gives IRQ errors. Usin=
g
> irqpoll allows the PCI card to somewhat work, but it is unreliable.
>=20
> There are some reports in Intel's support forums that also report
> PCI-problems with this mainboard, but Intel doesn't seem to be
> interested. So I hope this is something that is fixable on the kernel=
 side.
>=20
> If there is more information needed, please let me know.
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

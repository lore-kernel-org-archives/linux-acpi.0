From: =?ISO-8859-1?Q?Malte_Schr=F6der?= <maltesch@gmx.de>
Subject: Re: PCI problems with Intel H77 chipset, kernel 3.4 and 3.5-rc3 (was
 AVM B1 PCI on DH77KC (H77 chipset) problem, requires pci=noirq)
Date: Sun, 17 Jun 2012 14:59:22 +0200
Message-ID: <4FDDD4AA.4000903@gmx.de>
References: <4FD7A90F.7070900@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FD7A90F.7070900@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I did further tests, none successful.

On 12.06.2012 22:39, Malte Schr=F6der wrote:

> Hello,
> I am trying to get an old and trusty active ISDN-card to work on a sh=
iny
> new Intel DH77KC mainboard in conjunction with an i7 Ivy Bridge
> processor. (it's supposed to bridge VoIP to ISDN, amongst other stuff=
).

Since my original report I moved the new system into a test-box.

>=20
> When booting "normally", the card is recognized by the kernel. But th=
en
> the firmware upload fails. I can get this to work when using irqfixup=
 or
> irqpoll.

I now tried to get a 3Com NIC (3c905c) to work on the PCI-bus. That
doesn't work either. I get those "nobody cared" IRQ-messages.
I also updated the BIOS.
There seems to be something wrong WRT ACPI irq routing.

What further data should I provide to get this solved?

--=20
Gru=DF
Malte Schr=F6der
---------------------------------------------------------------------
MalteSch@gmx.de

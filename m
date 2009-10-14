From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCH v2 0/9] PCI, PNP: print resources consistently
Date: Tue, 13 Oct 2009 23:47:33 -0700
Message-ID: <86802c440910132347x1913d2a1taf35f385af50e17c@mail.gmail.com>
References: <20091013192040.22336.84876.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:46508 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbZJNGyi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2009 02:54:38 -0400
In-Reply-To: <20091013192040.22336.84876.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Joe Perches <joe@perches.com>, Len Brown <lenb@kernel.org>

On Tue, Oct 13, 2009 at 12:21 PM, Bjorn Helgaas <bjorn.helgaas@hp.com> =
wrote:
> These enhance %pR so we can print resource types and flags more easil=
y.
> This doesn't really add anything (other than a couple new messages
> about host bridge apertures), but hopefully it will make things more
> consistent and a bit easier to debug. =A0Sample change (with "pci=3Du=
se_crs"):
>
> =A0 =A0-pci 0000:00:03.0: reg 10 32bit mmio: [0xf6000000-0xf6ffffff]
> =A0 =A0-pci 0000:00:03.0: reg 14 io port: [0x2400-0x24ff]
> =A0 =A0-pci 0000:00:03.0: reg 18 32bit mmio: [0xf5ff0000-0xf5ff0fff]
> =A0 =A0-pci 0000:00:03.0: reg 30 32bit mmio pref: [0x000000-0x01ffff]
> =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x0000-0x0cff]
> =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x0000-0x2cfe]
> =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x03b0-0x03bb]
> =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x03c0-0x03df]
> =A0 =A0+pci_root PNP0A03:00: host bridge window [mem 0xf5d00000-0xf6f=
fffff]
> =A0 =A0+pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x000=
bffff]
> =A0 =A0+pci 0000:00:03.0: reg 10: [mem 0xf6000000-0xf6ffffff]
> =A0 =A0+pci 0000:00:03.0: reg 14: [io =A00x2400-0x24ff]
> =A0 =A0+pci 0000:00:03.0: reg 18: [mem 0xf5ff0000-0xf5ff0fff]
> =A0 =A0+pci 0000:00:03.0: reg 30: [mem 0x00000000-0x0001ffff pref]

can you keep "io port" and "mmio" ?
so we can use
grep "io port" dmesg.txt or grep "mmio" dmesg.txt

also put "io" and "mmio" "pref' in the [  ], looks strange.
[0xf5ff0000-0xf5ff0fff] is correct range expression.

YH
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

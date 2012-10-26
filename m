From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Info about ACPI/PCI vs ISA
Date: Thu, 25 Oct 2012 22:44:29 -0600
Message-ID: <508A152D.7090301@gmail.com>
References: <5062BA8B.7090503@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37471 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab2JZEoc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Oct 2012 00:44:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3267626iea.19
        for <linux-acpi@vger.kernel.org>; Thu, 25 Oct 2012 21:44:32 -0700 (PDT)
In-Reply-To: <5062BA8B.7090503@peak-system.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-acpi@vger.kernel.org, support@peak-system.com

On 09/26/2012 02:19 AM, Stephane Grosjean wrote:
> Good morning,
>
> I first sent the below e-mail on September, 24th... Perhaps it fell
> somewhere, perhaps the answer fell in some junk e-mail folders too, o=
r
> perhaps you didn't find time to answer (sorry for the noise if this i=
s
> the case).
>
> So I decided to retry once...
>
> I'm working on an issue with one of our PCI adapters.
> This PCI adapter is a standard and well proven board, for many years:
>
> $ lspci -v
> ...
> 04:08.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
> controller (rev 02)
>      Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
>      Flags: medium devsel, IRQ 11
>      Memory at f0410000 (32-bit, non-prefetchable) [size=3D64K]
>      Memory at f0400000 (32-bit, non-prefetchable) [size=3D64K]
>      Kernel driver in use: pcan

What does lspci -vv show for the device? It gives a bit more detail.

>
> The running system is:
>
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.1.9-1.4-desktop (geeko@buildhost) (gcc
> version 4.6.2 (SUSE Linux) ) #1 SMP PREEMPT Fri Jan 27 08:55:10 UTC 2=
012
> (efb5ff4)
> ...
> [    0.000000] Kernel command line:
> root=3D/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_00000000000000000=
015-part2
> resume=3D/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_000000000000000=
00015-part1
> splash=3Dsilent quiet vga=3D0x31b
> ...
> [    0.471267] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11=
 12
> 14 15)
> [    0.471323] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 =
12
> 14 15) *7
> [    0.471378] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 =
12
> 14 15) *7
> [    0.471434] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11=
 12
> 14 15)
> [    0.471487] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 =
12
> 14 15) *0, disabled.
> [    0.471541] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 =
12
> 14 15) *0, disabled.
> [    0.471594] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11=
 12
> 14 15)
> [    0.471647] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11=
 12
> 14 15)
>
> We don't succeed to send and receive data to/from this card and we
> suspect an IRQ related issue. For example, loading our (good old) "pc=
an"
> driver leads to the below logs:
>
> ...
> [    6.186877] pci 0000:00:1e.0: can't derive routing for PCI INT A
> [    6.186878] pcan 0000:04:08.0: PCI INT A: no GSI - using ISA IRQ 1=
1
> ...
>
> My questions are:
>
> - why does the system not succeed to "derive" routing for INTA? And w=
hy
> us? ;-)

At first glance it would appear that there's some kind of ACPI/PCI IRQ=20
routing problem on that system. Does the card work in another machine?=20
Or does a different card work in the same slot on this machine?

> - since the system looks like it switched in old "ISA" mode, should t=
he
> driver run differently (IRQ not shared, for example) or is this
> transparently handled by the Kernel?

I imagine what's happening is that based on some information the kernel=
=20
has decided to try using IRQ 11, but if there's no IRQ routing known=20
then the kernel may not know how to actually enable the PCI interrupt=20
link to actually allow the interrupts to be received.

>
> (implied question: how to fix this problem?)
>
> Many thanks for your time and your help,
>
> St=E9phane Grosjean
>
> --
> PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
> Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt
> HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391
> Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
> ----
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

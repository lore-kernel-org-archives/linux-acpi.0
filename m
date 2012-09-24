From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Info about ACPI/PCI vs ISA
Date: Mon, 24 Sep 2012 14:13:35 +0200
Message-ID: <50604E6F.2000104@peak-system.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:54395 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab2IXMZ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 08:25:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Good morning,

I'm working on a problem from one of our customers, which has an issue=20
with one of our PCI adapters.
This PCI adapter is a standard and well proven board:

$ lspci -v
=2E..
04:08.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus=20
controller (rev 02)
     Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
     Flags: medium devsel, IRQ 11
     Memory at f0410000 (32-bit, non-prefetchable) [size=3D64K]
     Memory at f0400000 (32-bit, non-prefetchable) [size=3D64K]
     Kernel driver in use: pcan

The running system is:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.1.9-1.4-desktop (geeko@buildhost) (gcc=20
version 4.6.2 (SUSE Linux) ) #1 SMP PREEMPT Fri Jan 27 08:55:10 UTC 201=
2=20
(efb5ff4)
=2E..
[    0.000000] Kernel command line:=20
root=3D/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_0000000000000000001=
5-part2=20
resume=3D/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_00000000000000000=
015-part1=20
splash=3Dsilent quiet vga=3D0x31b
=2E..
[    0.471267] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 1=
2=20
14 15)
[    0.471323] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12=
=20
14 15) *7
[    0.471378] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12=
=20
14 15) *7
[    0.471434] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 1=
2=20
14 15)
[    0.471487] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12=
=20
14 15) *0, disabled.
[    0.471541] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12=
=20
14 15) *0, disabled.
[    0.471594] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 1=
2=20
14 15)
[    0.471647] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11 1=
2=20
14 15)

The customer does not succeed to send and receive data to/from this car=
d=20
and we suspect an IRQ related issue. For example, loading our (good old=
)=20
"pcan" driver leads to the below logs:

=2E..
[    6.186877] pci 0000:00:1e.0: can't derive routing for PCI INT A
[    6.186878] pcan 0000:04:08.0: PCI INT A: no GSI - using ISA IRQ 11
=2E..

My questions are:

- why does the customer system not succeed to "derive" routing for INTA=
?=20
And why us? ;-)
- since the system looks like it switched in old "ISA" mode, should the=
=20
driver run differently (IRQ not shared, for example) or is this=20
transparently handled by the Kernel?

(implied question: how to fix this problem by the customer?)

Many thanks for your time and your help,

St=E9phane Grosjean

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
----
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

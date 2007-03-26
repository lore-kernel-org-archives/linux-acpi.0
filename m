From: Chris <chrism@cjsoftuk.dyndns.org>
Subject: Cannot control fan object.
Date: Mon, 26 Mar 2007 07:04:20 +0100
Message-ID: <46076264.5070603@cjsoftuk.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.wanadoo.co.uk ([193.252.22.156]:31894 "EHLO
	smtp3.freeserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933599AbXCZGEW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Mar 2007 02:04:22 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf3201.me.freeserve.com (SMTP Server) with ESMTP id 31F7E2400085
	for <linux-acpi@vger.kernel.org>; Mon, 26 Mar 2007 08:04:20 +0200 (CEST)
Received: from SERVER (user-5af0271c.wfd97.dsl.pol.co.uk [90.240.39.28])
	by mwinf3201.me.freeserve.com (SMTP Server) with ESMTP id DE1702400084
	for <linux-acpi@vger.kernel.org>; Mon, 26 Mar 2007 08:04:19 +0200 (CEST)
Received: from [10.10.10.2] (unknown [10.10.10.2])
	by SERVER (Postfix) with ESMTP id 01E4A5AE7
	for <linux-acpi@vger.kernel.org>; Mon, 26 Mar 2007 07:04:18 +0100 (BST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,
	Small issue with my server.  It has a case fan connected to PSU via a 4
pin molex connector, and then Sense and Gnd connected to the 3 pin
connection on the motherboard in the right places.

Here are the results of commands I have tried on it:

$ cat /proc/acpi/fan/FAN/state
status:		on

$ echo 3 > /proc/acpi/fan/FAN/state
- -bash: echo: write error: No such device

$ echo D3 > /proc/acpi/fan/FAN/state
- -bash: echo: write error: No such device

/var/log/messages shows:
Mar 25 06:26:10 SERVER kernel: [    0.000000]  BIOS-e820:
000000002fff0000 - 000000002fff3000 (ACPI NVS)
Mar 25 06:26:10 SERVER kernel: [    0.000000]  BIOS-e820:
000000002fff3000 - 0000000030000000 (ACPI data)
Mar 25 06:26:10 SERVER kernel: [    0.000000] Nvidia board detected.
Ignoring ACPI timer override.
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x4008
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x00]
lapic_id[0x00] enabled)
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: LAPIC_NMI
(acpi_id[0x00] high edge lint[0x1])
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: IOAPIC (id[0x02]
address[0xfec00000] gsi_base[0])
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0
bus_irq 0 global_irq 2 dfl dfl)
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: BIOS IRQ0 pin2
override ignored.
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0
bus_irq 9 global_irq 9 high level)
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0
bus_irq 14 global_irq 14 high edge)
Mar 25 06:26:10 SERVER kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0
bus_irq 15 global_irq 15 high edge)
Mar 25 06:26:10 SERVER kernel: [    0.000000] Using ACPI (MADT) for SMP
configuration information
Mar 25 06:26:10 SERVER kernel: [   46.784558] ACPI: Core revision 20060707
Mar 25 06:26:10 SERVER kernel: [   46.790026] ACPI: Looking for DSDT ...
not found!
Mar 25 06:26:10 SERVER kernel: [   46.939036] ACPI: bus type pci registered
Mar 25 06:26:10 SERVER kernel: [   46.948885] ACPI: Interpreter enabled
Mar 25 06:26:10 SERVER kernel: [   46.948891] ACPI: Using IOAPIC for
interrupt routing
Mar 25 06:26:10 SERVER kernel: [   46.949609] ACPI: PCI Root Bridge
[PCI0] (0000:00)
Mar 25 06:26:10 SERVER kernel: [   47.032999] ACPI: Power Resource
[ISAV] (on)
Mar 25 06:26:10 SERVER kernel: [   47.034704] ACPI: PCI Interrupt Link
[LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.035088] ACPI: PCI Interrupt Link
[LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.035469] ACPI: PCI Interrupt Link
[LNK3] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.035848] ACPI: PCI Interrupt Link
[LNK4] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.036235] ACPI: PCI Interrupt Link
[LNK5] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.036612] ACPI: PCI Interrupt Link
[LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.036990] ACPI: PCI Interrupt Link
[LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.037367] ACPI: PCI Interrupt Link
[LMAC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.037747] ACPI: PCI Interrupt Link
[LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.038125] ACPI: PCI Interrupt Link
[LACI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.038504] ACPI: PCI Interrupt Link
[LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.038899] ACPI: PCI Interrupt Link
[LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.039276] ACPI: PCI Interrupt Link
[LUB2] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.039657] ACPI: PCI Interrupt Link
[LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.040037] ACPI: PCI Interrupt Link
[L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.040414] ACPI: PCI Interrupt Link
[LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.040803] ACPI: PCI Interrupt Link
[LSID] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.041192] ACPI: PCI Interrupt Link
[LFID] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Mar 25 06:26:10 SERVER kernel: [   47.041632] ACPI: PCI Interrupt Link
[APC1] (IRQs 16) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.042044] ACPI: PCI Interrupt Link
[APC2] (IRQs 17) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.042451] ACPI: PCI Interrupt Link
[APC3] (IRQs 18) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.042923] ACPI: PCI Interrupt Link
[APC4] (IRQs 19) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.043247] ACPI: PCI Interrupt Link
[APC5] (IRQs *16), disabled.
Mar 25 06:26:10 SERVER kernel: [   47.043675] ACPI: PCI Interrupt Link
[APCF] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.044100] ACPI: PCI Interrupt Link
[APCG] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.044531] ACPI: PCI Interrupt Link
[APCH] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.044955] ACPI: PCI Interrupt Link
[APCI] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.045381] ACPI: PCI Interrupt Link
[APCJ] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.045805] ACPI: PCI Interrupt Link
[APCK] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.046229] ACPI: PCI Interrupt Link
[APCS] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.046705] ACPI: PCI Interrupt Link
[APCL] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.047142] ACPI: PCI Interrupt Link
[APCM] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.047573] ACPI: PCI Interrupt Link
[AP3C] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.048001] ACPI: PCI Interrupt Link
[APCZ] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.048457] ACPI: PCI Interrupt Link
[APSI] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.048915] ACPI: PCI Interrupt Link
[APSJ] (IRQs 20 21 22 23) *0, disabled.
Mar 25 06:26:10 SERVER kernel: [   47.052726] pnp: PnP ACPI init
Mar 25 06:26:10 SERVER kernel: [   47.059294] pnp: PnP ACPI: found 12
devices
Mar 25 06:26:10 SERVER kernel: [   47.059366] PCI: Using ACPI for IRQ
routing
Mar 25 06:26:10 SERVER kernel: [   47.146873] ACPI: (supports S0 S1 S4 S5)
Mar 25 06:26:10 SERVER kernel: [   47.403406] ACPI: Fan [FAN] (on)
Mar 25 06:26:10 SERVER kernel: [   47.408935] ACPI: Thermal Zone [THRM]
(40 C)
Mar 25 06:26:10 SERVER kernel: [   49.757905] ACPI: PCI Interrupt Link
[APSJ] enabled at IRQ 23
Mar 25 06:26:10 SERVER kernel: [   49.757919] ACPI: PCI Interrupt
0000:00:0a.0[A] -> Link [APSJ] -> GSI 23 (level, high) -> IRQ 177
Mar 25 06:26:10 SERVER kernel: [   50.843128] ACPI: PCI Interrupt Link
[APC4] enabled at IRQ 19
Mar 25 06:26:10 SERVER kernel: [   50.843141] ACPI: PCI Interrupt
0000:02:07.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 185
Mar 25 06:26:10 SERVER kernel: [   53.475346] ACPI: PCI Interrupt Link
[APCF] enabled at IRQ 22
Mar 25 06:26:10 SERVER kernel: [   53.475362] ACPI: PCI Interrupt
0000:00:02.0[A] -> Link [APCF] -> GSI 22 (level, high) -> IRQ 193
Mar 25 06:26:10 SERVER kernel: [   53.658200] ACPI: PCI Interrupt Link
[APCG] enabled at IRQ 21
Mar 25 06:26:10 SERVER kernel: [   53.658214] ACPI: PCI Interrupt
0000:00:02.1[B] -> Link [APCG] -> GSI 21 (level, high) -> IRQ 201
Mar 25 06:26:10 SERVER kernel: [   53.842907] ACPI: PCI Interrupt Link
[APCL] enabled at IRQ 20
Mar 25 06:26:10 SERVER kernel: [   53.842923] ACPI: PCI Interrupt
0000:00:02.2[C] -> Link [APCL] -> GSI 20 (level, high) -> IRQ 209
Mar 25 06:26:10 SERVER kernel: [   53.950586] ACPI: PCI Interrupt Link
[APCH] enabled at IRQ 23
Mar 25 06:26:10 SERVER kernel: [   53.950593] ACPI: PCI Interrupt
0000:00:05.0[A] -> Link [APCH] -> GSI 23 (level, high) -> IRQ 177
Mar 25 06:26:10 SERVER kernel: [   62.433912] ACPI: PCI Interrupt Link
[APC3] enabled at IRQ 18
Mar 25 06:26:10 SERVER kernel: [   62.433925] ACPI: PCI Interrupt
0000:02:06.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 217
Mar 25 06:26:10 SERVER kernel: [   63.190386] ACPI: PCI Interrupt Link
[APCJ] enabled at IRQ 22
Mar 25 06:26:10 SERVER kernel: [   63.190392] ACPI: PCI Interrupt
0000:00:06.0[A] -> Link [APCJ] -> GSI 22 (level, high) -> IRQ 193
Mar 25 06:26:10 SERVER kernel: [   98.072991] ACPI: Power Button (FF) [PWRF]
Mar 25 06:26:10 SERVER kernel: [   98.073005] ACPI: Power Button (CM) [PWRB]


Any ideas why I have no control over the fan?

Chris
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGB2JkqLdeHpjNN3MRAkEnAJ0TgDxEnbBemvxWGW8H0BfV/hUPXACZAY2a
6F3l+hiWjSfHCHesUfYm3j8=
=xw2K
-----END PGP SIGNATURE-----


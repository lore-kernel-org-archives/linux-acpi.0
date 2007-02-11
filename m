From: "Roger James" <roger@beardandsandals.co.uk>
Subject: Enabling the IO-APIC on an Abit KT7A motherboard
Date: Sun, 11 Feb 2007 17:11:30 -0000
Message-ID: <000a01c74dff$ad09ac40$fd0ba8c0@lancaster.beardandsandals.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fbr01.cseeplus.net ([64.41.126.109]:40024 "EHLO
	fbr01.cseeplus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXBKRd0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Feb 2007 12:33:26 -0500
Received: from smtpauth00.csee.siteprotect.com (smtpauth00.csee.siteprotect.com [64.41.126.131])
	by fbr01.cseeplus.net (Postfix) with ESMTP id 0974E4BBD1
	for <linux-acpi@vger.kernel.org>; Sun, 11 Feb 2007 11:15:04 -0600 (CST)
Received: from pastry (unknown [81.168.109.249])
	by smtpauth00.csee.siteprotect.com (Postfix) with ESMTP id 78E6832C017
	for <linux-acpi@vger.kernel.org>; Sun, 11 Feb 2007 11:10:35 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have been trying to get the IO-APIC on an Abit KT7A motherboard recognised
by the kernel (2.6.19.2). This is of course a single processor system. The
kernel has the CONFIG_X86_UP_APIC, CONFIG_X86_UP_IOAPIC,
CONFIG_X86_LOCAL_APIC, and CONFIG_X86_IOAPIC options set.

The reason I am trying this is in order to debug a system lock-up using the
nmi-watchdog facility. It looks like the lock up is caused by a hlt
instruction as the lapic based nmi-watchdog does not catch it.

I have put some debug in the various bits of code that are related to the
initialisation of the io-apic and its seems it is not being detected because
the bios does not supply an APIC table so..

acpi_table_parse(ACPI_APIC, acpi_parse_madt);

returns 0 and the IOAPIC is never found.

The only other route I can see where an IO-APIC might be enabled is via
get_smp_config but I don't think this get called on a single processor
system such as the KT7A.

Does anyone know how to force the io-apic to be found? Has anyone done this
before.

Here is a dump of the acpi tables returned by the BIOS.


DSDT @ 0x1fff3100
  0000: 44 53 44 54 be 24 00 00 01 25 56 54 38 33 37 31  DSDT.$...%VT8371
  0010: 41 57 52 44 41 43 50 49 00 10 00 00 4d 53 46 54  AWRDACPI....MSFT
  0020: 0c 00 00 01 10 19 5c 5f 50 52 5f 5b 83 11 5c 2e  ......\_PR_[..\.
  0030: 5f 50 52 5f 43 50 55 30 01 10 40 00 00 06 08 5c  _PR_CPU0..@....\
  0040: 5f 53 30 5f 12 06 04 00 00 00 00 08 5c 5f 53 31  _S0_........\_S1
  0050: 5f 12 0a 04 0a 04 0a 04 0a 04 0a 04 08 5c 5f 53  _............\_S
  0060: 34 5f 12 0a 04 0a 02 0a 02 0a 02 0a 02 08 5c 5f  4_............\_
  0070: 53 35 5f 12 0a 04 0a 02 0a 02 0a 02 0a 02 5b 80  S5_...........[.
  0080: 5c 44 45 42 47 01 0a 80 0a 01 5b 81 0c 5c 44 45  \DEBG.....[..\DE


......  loads of DSDT removed


  2410: 47 01 60 00 60 00 01 01 47 01 64 00 64 00 01 01  G.`.`...G.d.d...
  2420: 22 02 00 79 00 14 0e 5f 50 52 57 00 a4 12 06 02  "..y..._PRW.....
  2430: 0a 05 0a 05 14 2d 5c 2f 04 5f 53 42 5f 50 43 49  .....-\/._SB_PCI
  2440: 30 55 41 52 31 5f 50 52 57 00 a0 0d 4f 53 46 4c  0UAR1_PRW...OSFL
  2450: a4 12 06 02 0a 08 0a 04 a1 09 a4 12 06 02 0a 08  ................
  2460: 0a 08 14 2d 5c 2f 04 5f 53 42 5f 50 43 49 30 55  ...-\/._SB_PCI0U
  2470: 41 52 32 5f 50 52 57 00 a0 0d 4f 53 46 4c a4 12  AR2_PRW...OSFL..
  2480: 06 02 0a 08 0a 04 a1 09 a4 12 06 02 0a 08 0a 08  ................
  2490: 14 2d 5c 2f 04 5f 53 42 5f 50 43 49 30 45 43 50  .-\/._SB_PCI0ECP
  24a0: 31 5f 50 52 57 00 a0 0d 4f 53 46 4c a4 12 06 02  1_PRW...OSFL....
  24b0: 0a 08 0a 04 a1 09 a4 12 06 02 0a 08 0a 08        ..............

FACS @ 0x1fff0000
  0000: 46 41 43 53 40 00 00 00 00 00 00 00 00 00 00 00  FACS@...........
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

FACP @ 0x1fff3040
  0000: 46 41 43 50 84 00 00 00 02 bc 56 54 38 33 37 31  FACP......VT8371
  0010: 41 57 52 44 41 43 50 49 32 2e 30 30 41 57 52 44  AWRDACPI2.00AWRD
  0020: 00 00 00 00 00 00 ff 1f 00 31 ff 1f 00 00 09 00  .........1......
  0030: 2f 40 00 00 a1 a0 00 00 00 40 00 00 00 00 00 00  /@.......@......
  0040: f0 40 00 00 00 00 00 00 00 00 00 00 08 40 00 00  .@...........@..
  0050: 20 40 00 00 00 00 00 00 04 02 00 04 04 00 00 00   @..............
  0060: 5a 00 84 03 00 00 00 00 00 01 7d 7e 32 03 00 00  Z.........}~2...
  0070: 25 00 00 00 01 08 00 00 64 00 00 00 00 00 00 00  %.......d.......
  0080: fe 00 00 00                                      ....

RSDT @ 0x1fff3000
  0000: 52 53 44 54 28 00 00 00 01 56 56 54 38 33 37 31  RSDT(....VVT8371
  0010: 41 57 52 44 41 43 50 49 32 2e 30 30 41 57 52 44  AWRDACPI2.00AWRD
  0020: 00 00 00 00 40 30 ff 1f                          ....@0..

RSD PTR @ 0xf7770
  0000: 52 53 44 20 50 54 52 20 16 56 54 38 33 37 31 00  RSD PTR .VT8371.
  0010: 00 30 ff 1f                                      .0..


As you can see the RSDT only has one table pointer and that points at the
FACP table.

Am I flogging a dead horse with this?

Are there any routes other than ACPI where the IO-APIC might be enabled?

Is this the right list for this question?

Help!!

Roger





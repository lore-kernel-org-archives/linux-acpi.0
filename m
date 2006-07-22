From: Philip Walden <pwaldenlinux@pacbell.net>
Subject: Older PC stands-by only momentarily
Date: Fri, 21 Jul 2006 20:27:40 -0700
Message-ID: <44C19B2C.1030603@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:28083 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751270AbWGVD1n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jul 2006 23:27:43 -0400
Received: from pimout7-ext.prodigy.net (pimout7-int.prodigy.net [207.115.4.147])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id k6M3RcTX017967
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2006 23:27:38 -0400
Received: from [192.168.1.140] (adsl-75-20-221-126.dsl.pltn13.sbcglobal.net [75.20.221.126])
	by pimout7-ext.prodigy.net (8.13.6 out.dk/8.13.6) with ESMTP id k6M3RefV109782
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2006 23:27:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I have an older PC with limited acpi capabilities and 2.6.17-1.2141_FC4
Code:

CPU type : AMD Athlon(tm)
  Processor CPU speed : 856.102 MHz
  Cache size : 512 KB Bogomips : 1714.25
  Processor ID : 0
Bus mastering control : no
Power management : no
Throttling control : no
Limit interface : no
Active C-state : C1
  C-states (incl. C0) : 2


But it does have:

ACPI: (supports S0 S1 S5) and /sys/power/state == "standby disk".

If I do a echo -n "standby" >state, then it appears to suspend for 1-3
seconds, power light blinking, etc. Then comes back to life. I cannot
figure out what is waking it up. acpitool say all wakeup devices are
disabled.


# acpitool -w
  Device Sleep state Status
---------------------------------------
  1. PCI0 1 disabled
  2. KBC 1 disabled
  3. USB0 1 disabled
  4. USB1 1 disabled



Here is the system log. The acpi log has nothing in it.
Code:

Jul 20 16:37:26 walden4 kernel: Stopping tasks: 
================================================== 
================================================== ===|
Jul 20 16:37:26 walden4 kernel: pnp: Device 00:0b disabled.
Jul 20 16:37:26 walden4 kernel: pnp: Device 00:0a disabled.
Jul 20 16:37:26 walden4 kernel: ACPI: PCI interrupt for 
device0000:00:0f.0 disabled
Jul 20 16:37:26 walden4 kernel: ACPI: PCI interrupt for device 
0000:00:04.2 disabled
Jul 20 16:37:26 walden4 kernel: ACPI: PCI Interrupt 0000:00:04.2[D] -> 
Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Jul 20 16:37:26 walden4 kernel: bttv0: reset, reinitialize
Jul 20 16:37:26 walden4 kernel: bttv0: PLL: 28636363 => 35468950 .. ok 
Jul 20 16:37:26 walden4 kernel: ACPI: PCI Interrupt 0000:00:0d.1[A] -> 
Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jul 20 16:37:26 walden4 kernel: ACPI: PCI Interrupt 0000:00:0f.0[A] -> 
Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
Jul 20 16:37:27 walden4 kernel: eth0: link up, 100Mbps, full-duplex, lpa 
0x45E1
Jul 20 16:37:27 walden4 kernel: pnp: Device 00:06 does not support 
activation.
Jul 20 16:37:27 walden4 kernel: pnp: Device 00:07 does not support 
activation.
Jul 20 16:37:27 walden4 kernel: pnp: Device 00:0a activated.
Jul 20 16:37:27 walden4 kernel: pnp: Device 00:0b activated.
Jul 20 16:37:27 walden4 kernel: Restarting tasks... done




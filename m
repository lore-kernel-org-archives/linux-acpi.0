From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Problem with GPRS modem
Date: Thu, 11 Oct 2007 14:13:43 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DEC8FF60@pdsmsx414.ccr.corp.intel.com>
References: <d4596f280710101339n27d7a42oc0a6a211441e0b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51975 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbXJKGOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Oct 2007 02:14:47 -0400
Content-class: urn:content-classes:message
In-Reply-To: <d4596f280710101339n27d7a42oc0a6a211441e0b2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grzeniek <grzeniek@gmail.com>, linux-acpi@vger.kernel.org

Hi, Grzeniek,

Please open a bug in
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
And attach the dmesg and "cat /proc/interrupt" both with and without
"acpi=off" boot parameter. acpidump may be needed as well.

Thanks,
Rui

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Grzeniek
Sent: Thursday, October 11, 2007 4:40 AM
To: linux-acpi@vger.kernel.org
Subject: Problem with GPRS modem

Hi,

I've got a SonyEricsson GC89 GPRS/EDGE pcmcia card (serial), but I
can't get to work it (on my laptop Acer TravelMate 4152LMi).
The problem is that the connection is very, very slow (download rate
about 0,5KB/s) and I've got more then 20% rx errors on ppp0 interface.

The system (I tried FC5, FC7, Ubuntu 6.04, Ubuntu 7.04 and Ubuntu
7.10) can recognize this card, I can make ppp connection to GPRS/EDGE
network. But this connection is really very slow, and I think.

What I found is when I boot system with acpi=off parameter everything
works great, I' ve got transfers about 20-25KB/s with no rx errors on
ppp0 interface.

I'm really not sure if this problem is related to acpi subsystem
(maybe this is pcmcia or pppd problem), but I have to try.

>From dmesg:
pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:03:00.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:03:00.1[A] -> GSI 16 (level, low) -> IRQ 16
0000:03:00.1: ttyS4 at I/O 0xa000 (irq = 16) is a 16550A

lspci -vv:
03:00.1 Serial controller: Broadcom Corporation EDGE/GPRS data and
802.11b/g combo cardbus [GC89] (rev 03) (prog-if 02 [16550])
        Subsystem: Unknown device 18de:0003
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a000 [size=256]

uname -a
Linux localhost 2.6.22-12-generic #1 SMP Sun Sep 23 18:11:30 GMT 2007
i686 GNU/Linux

I really don't know how to make this card working properly, and I need
your help.
If you need more specific info just tell me what do you want.

Grzegorz

PS. Sorry for my English.
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Grzeniek <grzeniek@gmail.com>
Subject: Problem with GPRS modem
Date: Wed, 10 Oct 2007 22:39:50 +0200
Message-ID: <d4596f280710101339n27d7a42oc0a6a211441e0b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:6666 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbXJJUjw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 16:39:52 -0400
Received: by wx-out-0506.google.com with SMTP id h31so332414wxd
        for <linux-acpi@vger.kernel.org>; Wed, 10 Oct 2007 13:39:51 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

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

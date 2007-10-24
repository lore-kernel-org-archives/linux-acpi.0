From: "Andrew" <andrew@nelless.net>
Subject: ACPI Exception triggered by pata_amd driver in 2.6.24,
      is this an ACPI bug?
Date: Wed, 24 Oct 2007 19:00:14 +0100 (BST)
Message-ID: <35314.86.7.220.119.1193248814.squirrel@wmbeta.mxes.net>
Reply-To: "Andrew" <andrew@nelless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from turtle-out.mxes.net ([216.86.168.191]:3004 "EHLO
	turtle-out.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbXJXSjP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 14:39:15 -0400
Received: from mxout-04.mxes.net (mxout-04.mxes.net [216.86.168.179])
	by turtle-in.mxes.net (Postfix) with ESMTP id 3CE57164698
	for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 14:04:15 -0400 (EDT)
Received: from w16.irbs.net (w16.irbs.net [205.237.194.58])
	by smtp.mxes.net (Postfix) with ESMTP id 492F0D05B3
	for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 14:00:14 -0400 (EDT)
Received: from wmbeta.mxes.net (w16.irbs.net [205.237.194.58])
	by w16.irbs.net (Postfix) with ESMTP id 25AC81726CB
	for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 14:00:13 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

This is probably nothing since there seems to be no ill effects
but I thought someone should know because...well it bothers me.

Heres a diff of the kernel boot log between 2.6.23 and 2.6.24:

 scsi4 : pata_amd
 scsi5 : pata_amd
-ata5: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma
0x000000000001ffa0 irq 14
-ata6: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma
0x000000000001ffa8 irq 15
+ata5: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
+ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
+ACPI Exception (exoparg2-0442): AE_AML_PACKAGE_LIMIT, Index (0FFFFFFFF) is beyond end of
object [20070126]
+ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.GTM_] (Node
ffff810002001740), AE_AML_PACKAGE_LIMIT
+ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1._GTM] (Node
ffff810002001620), AE_AML_PACKAGE_LIMIT
+ata6: ACPI get timing mode failed (AE 0x300d)
 ata6.00: ATAPI: HL-DT-ST DVDRAM GSA-4167B, DL13, max UDMA/33
 ata6.00: configured for UDMA/33

...and lspci output:

00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1) (prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device f043:81bc
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR-
FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort-
>SERR- <PERR- INTx-
        Latency: 0 (750ns min, 250ns max)
        Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
        Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
        Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

So, is it a bug?
Please CC as I am not subscribed.

Andrew


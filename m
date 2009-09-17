From: Henric Blomgren <henric@digitalroutes.co.uk>
Subject: ACPI problems with 2.6.31 linux-acpi
Date: Thu, 17 Sep 2009 11:12:58 +0100
Message-ID: <ee1d12670909170312y5a67c6f7le58ef388bb25499f@mail.gmail.com>
References: <ee1d12670909170306s6b9716e2ib45eb6818cb9d7b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:46642 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbZIQKMz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Sep 2009 06:12:55 -0400
Received: by yxe12 with SMTP id 12so360323yxe.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Sep 2009 03:12:59 -0700 (PDT)
In-Reply-To: <ee1d12670909170306s6b9716e2ib45eb6818cb9d7b3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello everyone,

I've got a problem with one of my home debian nodes and I'm lead to
believe it is to do with the acpi system.

When installing 2.6.26 (debian vanilla) the system randomly locks up
with the message:
BUG: soft lockup detected on CPU#0! 61s
While kacpid consumes 100% cpu according to top.

With this being an older kernel I took it upon myself to build 2.6.31
to see if there was any change.
The system does not lock up any more, but kacpid still consumes close
to 100% cpu and I'm getting this in my dmesg:
[45699.978868] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0.LPC_.SMBR] (Node f7812c48), AE_AML_INFINITE_LOOP
[45699.978905] ACPI Error (psparse-0537): Method parse/execution
failed [\_SB_.PCI0.LPC_.INIT] (Node f7812c30), AE_AML_INFINITE_LOOP
[45699.978936] ACPI Error (psparse-0537): Method parse/execution
failed [\_GPE._L00] (Node f78101b0), AE_AML_INFINITE_LOOP
[45699.978970] ACPI Exception: AE_AML_INFINITE_LOOP, while evaluating
GPE method [_L00] 20090521 evgpe-568
(constantly repeating).

The system is an Intel Atom Little-Falls mini itx board with 1gb ram
which I've checked with memtest86.
lspci output:
00:00.0 Host bridge: Intel Corporation 82945G/GZ/P/PL Memory
Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82945G/GZ
Integrated Graphics Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI Controller #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
SATA IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 02)
04:00.0 Mass storage controller: Promise Technology, Inc. PDC20575
(SATAII150 TX2plus) (rev 02)

acpidump output is available at : http://halfbug.com/acpi.txt

Booting with acpi=off fixes the problem, but I thought I would report
this issue since it is happening with the latest kernel.

Sorry if the above information does not include everything you need to
know, if anything is missing please let me know and I'll get the
information.

Regards,
Henric

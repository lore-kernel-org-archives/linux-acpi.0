From: Andreas Saur <saur@acmelabs.de>
Subject: Failed resuming IDE from S3 on Abit NF7 (nForce2)
Date: Thu, 13 Apr 2006 07:28:28 +0200
Message-ID: <443DE17C.5020904@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:31901 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S964798AbWDMF2g
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 01:28:36 -0400
Received: from server.zuhause.xx (p508138F7.dip0.t-ipconnect.de [80.129.56.247])
	(authenticated bits=0)
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k3D5SW4T002086
	for <linux-acpi@vger.kernel.org>; Thu, 13 Apr 2006 07:28:33 +0200 (MEST)
Received: from server.zuhause.xx ([192.168.1.2] helo=[127.0.0.1])
	by server.zuhause.xx with esmtp (Exim 4.50)
	id 1FTuP8-0007PA-5o
	for linux-acpi@vger.kernel.org; Thu, 13 Apr 2006 07:30:09 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Topic: Failed resuming IDE from S3 on Abit NF7 (nForce2)

Hello all,
as already reported on bugzilla 
(http://bugzilla.kernel.org/show_bug.cgi?id=6326) and on this mailing 
list (http://marc.theaimsgroup.com/?l=linux-acpi&m=114461011901806&w=2), 
I've finally made it to get some more or less usefull logs about this 
bug. After a accidentally building a kernel with an initrd(*), I was 
able to resume from S3, but only until the system didn't perform a disk 
access on IDE. But that was enough to make a dmesg with an interesting 
entry:

"pnp: Failed to activate device 00:09.", where 00:09 is IDE!

With the first access to IDE the system was instantly frozen.

The only workaround I've found was here:
    http://lkml.org/lkml/2006/2/21/280
I've applied the mentioned kernel-patch:
    
http://www.xenotime.net/linux/SATA/2.6.16-rc3/libata-rollup-2616-rc3.patch
, but it didn't work for me. In the mail was also said, that there is a 
trivial "4-hooks" patch, that also has to be applied, but reading all 
the mails I couldn't find this patch.

Doest anybody know something about libata concerning ACPI problems? Btw. 
I've got an "sata_nv" mnodule loaded in the single-user-mode, but my 
sata is switched off in BIOS.

Help appreciated! Thanks.

----dmesg---Linux version 2.6.17-rc1-mm2a (root@vulcan) (gcc version 
4.0.3 20060304 ------
PM: Preparing system for mem sleep
Stopping tasks: =========|
[ACPI Debug]  String: [0x15] "==== SST Working ===="
Suspending device 1.0
Suspending device ide1
Suspending device eisa.0
Suspending device serio1
Suspending device serio0
Suspending device i8042
Suspending device serial8250
Suspending device pnp1
Suspending device pcspkr
Suspending device 00:09
Suspending device 00:08
Suspending device 00:07
Suspending device 00:06
Suspending device 00:05
Suspending device 00:04
Suspending device 00:03
Suspending device 00:02
Suspending device 00:01
Suspending device 00:00
Suspending device pnp0
Suspending device 0000:02:00.1
Suspending device 0000:02:00.0
Suspending device 0000:00:1e.0
Suspending device 0000:00:09.0
Suspending device 0000:00:08.0
Suspending device 0000:00:04.0
Suspending device 0000:00:01.1
Suspending device 0000:00:01.0
Suspending device 0000:00:00.5
Suspending device 0000:00:00.4
Suspending device 0000:00:00.3
Suspending device 0000:00:00.2
Suspending device 0000:00:00.1
Suspending device 0000:00:00.0
Suspending device pci0000:00
Suspending device platform
PM: Entering mem sleep
 hwsleep-0285 [11] enter_sleep_state     : Entering sleep state [S3]
Back to C!
PM: Finishing wakeup.
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LMAC] -> GSI 11 (level,
low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:08.0 to 64
pnp: Failed to activate device 00:09.
Restarting tasks... done
[ACPI Debug]  String: [0x15] "==== SST Working ===="
ACPI Error (evevent-0314): No installed handler for fixed event
[00000002] [20060310]
[ACPI Debug]  String: [0x15] "==== SST Working ===="

(*) don't know if initrd is the reason, but I've tried so much, that I 
don't correctly remember anymore.

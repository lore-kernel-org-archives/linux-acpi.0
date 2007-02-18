From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: [Bugme-new] [Bug 8034] New: sata_nv broken by not using nolapic
 and acpi=off
Date: Sun, 18 Feb 2007 11:44:42 -0800
Message-ID: <20070218114442.e809167e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:53048 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbXBRToo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Feb 2007 14:44:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1IJihhB030454
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sun, 18 Feb 2007 11:44:43 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l1IJigin023696
	for <linux-acpi@vger.kernel.org>; Sun, 18 Feb 2007 11:44:42 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Is this an acpi thing?


Begin forwarded message:

Date: Sun, 18 Feb 2007 04:46:28 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 8034] New: sata_nv broken by not using nolapic and acpi=off


http://bugzilla.kernel.org/show_bug.cgi?id=8034

           Summary: sata_nv broken by not using nolapic and acpi=off
    Kernel Version: 2.6.20
            Status: NEW
          Severity: high
             Owner: drivers_other@kernel-bugs.osdl.org
         Submitter: florian.delizy@unfreeze.net


Most recent kernel where this bug did *NOT* occur: 

occur since 2.6.8 and still occurs (2.6.20-git14 still have it...)

Distribution:

Debian (unstable)

Hardware Environment:

nforce4 (mb: Asus K8NE-Deluxe, western digital sata disk WDC WD2500KS-00M)

lspci:

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
...
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
...

Software Environment:

boot time ... kernel.org kernel (with or without nvidia graphics drivers,
anyway, at boot time, nvidia module is not yet loaded).

root=/dev/sda5

Problem Description:

sata_nv needs acpi=off and nolapic to boot correctly, if I boot without
acpi=off, the kernel panics not finding any root partition (it seems that
sata_nv does not get initialized and does not probe anything in the log).

when booting with acpi=off but not nolapic, I get the following messages :

...
sata_nv 0000:00:07.0: version 3.3
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xffffc20000a02480 ctl 0xffffc20000a024a0 bmdma
0x000000000001d800 irq 5
ata2: SATA max UDMA/133 cmd 0xffffc20000a02580 ctl 0xffffc20000a025a0 bmdma
0x000000000001d808 irq 5
scsi0 : sata_nv
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata2.00: ata2: dev 0 multi 1
ata2.00: qc timeout (cmd 0xef)
ata2.00: failed to set xfermode (errmask=0x4)
ata2.00: limiting speed to UDMA100
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata2.00: ata2: dev 0 multi 1
ata2.00: qc timeout (cmd 0xef)
ata2.00: failed to set xfermode (errmask=0x4)
ata2.00: limiting speed to PIO0
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata2.00: ata2: dev 0 multi 1
ata2.00: qc timeout (cmd 0xef)
ata2.00: failed to set xfermode (errmask=0x4)
ata2.00: disabled

then the kernel panics not finding /dev/sda5 root


when booting with both acpi=off and nolapic the system boots, and here is the
corresponding dmesg part :

...
sata_nv 0000:00:07.0: version 3.3
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xffffc20000a02480 ctl 0xffffc20000a024a0 bmdma
0x000000000001d800 irq 5
ata2: SATA max UDMA/133 cmd 0xffffc20000a02580 ctl 0xffffc20000a025a0 bmdma
0x000000000001d808 irq 5
scsi0 : sata_nv
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_nv
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: WDC WD2500KS-00MJB0, 02.01C03, max UDMA/133
ata2.00: 488397168 sectors, multi 1: LBA48
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
ata2: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO
or FUA
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO
or FUA
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
...

Looking carefully at the log, it seems that without nolapic, the WDC drive is
not properly probed, while whitout acpi=off it is not probed at all ... 

I tried with other disks but had similar results (maxtor disk). googling a bit
informed me that wdc drives did not support udma very well, but with nolapic, it
works all fine...

I am not familiar with acpi/lapic/sata_nv code (grepping the code didn't help
that much and the comment on the top of sata_nv.c "No hardware documentation
available outside of NVIDIA." didn't help more ...) but if I can be of any help,
please tell me (btw, I have a null modem cable from that computer to another
witch is accessible by ssh, and I can add the kgdb patch, provided I can find a
suitable version for the 2.6.20, if any want to try to debug it, contact me)

Steps to reproduce:

boot without 'acpi=off nolapic' options... 100% reproductable.

if needed I can add a kgdb patch to my machine, and allow debugging by serial
link from another machine during daytime (or perform the debugging myself with
some hints in the code).

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

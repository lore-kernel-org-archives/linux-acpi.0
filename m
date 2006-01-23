From: Raphael Clifford <raphael@clifford.net>
Subject: 2.6.16-rc1  will not boot on msi rs480m2 when either acpi or apic
 is enabled
Date: Mon, 23 Jan 2006 16:02:55 +0000
Message-ID: <43D4FE2F.5080700@clifford.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dirg.bris.ac.uk ([137.222.10.102]:38560 "EHLO dirg.bris.ac.uk")
	by vger.kernel.org with ESMTP id S932276AbWAWQC7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 11:02:59 -0500
Received: from lunaleka.cs.bris.ac.uk ([137.222.102.100])
	by dirg.bris.ac.uk with esmtp (Exim 4.60)
	(envelope-from <raphael@clifford.net>)
	id 1F149g-0003ZW-1C
	for linux-acpi@vger.kernel.org; Mon, 23 Jan 2006 16:02:58 +0000
Received: from [137.222.102.36] (helo=[137.222.102.36])
	by lunaleka.cs.bris.ac.uk with esmtp (Exim 4.51)
	id 1F149g-0005vB-Si
	for linux-acpi@vger.kernel.org; Mon, 23 Jan 2006 16:02:56 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

MSI rs480m2 system  (AMD64 processor) will not boot when either acpi or apic are
enabled in the boot arguments.  This has been tested in many kernels (gentoo and vanilla) up
to and including 2.6.16-rc1.  


1) When booting with command line root=/dev/ram0 init=/linuxrc ramdisk=8192
real_root=/dev/sda5 udev  report_lost_ticks=100 noapictimer the following is a
screenshot of what happens.

First it pauses at "sata_sil" and then


http://img66.imageshack.us/img66/2489/screenacpismall4my.jpg

2) When booting with commmand line root=/dev/ram0 init=/linuxrc ramdisk=8192
real_root=/dev/sda5 udev  report_lost_ticks=100 acpi=off the following is a
screenshot of what happens.


http://img204.imageshack.us/img204/9753/screenapicsmall5tx.jpg


A litte more investigation shows that the system will in fact boot with

Command line root=/dev/ram0 init=/linuxrc ramdisk=8192 real_root=/dev/sda5 udev
 report_lost_ticks=100 noapictimer acpi=noirq


I reported this problem to 
http://bugzilla.kernel.org/show_bug.cgi?id=5933 which has full debug info.

Although this problem may not seem that important, it appears to (maybe) 
cause a drastic problem with interrupts which manifests itself 
particularly if you try to write a cd for example.  I am hoping that if 
I can boot with ACPI and APIC on then this may fix itself.

Raphael
P.S. Should I report the APIC part of the bug somewhere else separately?

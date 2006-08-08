From: Brannon Barrett Klopfer <bklopfer@stanford.edu>
Subject: hp dv8000t dead on resume from RAM
Date: Tue,  8 Aug 2006 10:15:11 -0700
Message-ID: <1155057311.44d8c69f3f2fc@webmail.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp3.Stanford.EDU ([171.67.20.26]:2962 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S964955AbWHHRPN
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Aug 2006 13:15:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: acpi@linux.intel.com

Howdy,

My hp dv8000t (core duo) is completely dead on resume from RAM (no caps
lock, sysrq, netconsole,
nothing). I've tried a recent (2.6.18-rc4) kernel running almost entirely
naked, so to speak (~990K) -- no support for:

SMP
preempt
modules
networking (+ enet drivers, unless running netconsole)
USB and SATA (not at same time; rootfs is either usb drive or SATA [ext2/3])
FireWire
cpufreq
framebuffer (vga=0)
audio
PCMCIA
IDE (for cdrom)

I've tried both native SATA (ahci) and legacy (ata_piix), but same result
w/both -- completely dead on resume from RAM. Blindly entering commands
does nothing, and running "$suspend ; $shutdown" does nothing either. I've
also tried with and without noapic, and a number of other kernel
paramaters, but nothing seems to work.

Be more than happy to try out patches, etc. to get this thing working.
Additionally, if someone could point me to that "beep on resume" patch,
that'd be great.

Some machine/debugging info (cpuinfo, messages, lspci, etc.) at:

http://www.stanford.edu/~bklopfer/wontsuspend/

Thanks,
Brannon Klopfer

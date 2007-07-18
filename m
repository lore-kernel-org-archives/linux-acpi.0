From: Omari Stephens <xsdg@mit.edu>
Subject: 2.6.21, 2.6.21.6, and 2.6.22.1 lock during boot without "acpi=off"
Date: Wed, 18 Jul 2007 17:25:03 +0000
Message-ID: <469E4CEF.307@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 30-26-160.dynamic.csail.mit.edu ([128.30.26.160]:51141 "EHLO
	whitespace.xsdg.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934683AbXGRS3f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2007 14:29:35 -0400
Received: from localhost ([127.0.0.1])
	by whitespace.xsdg.org with esmtp (Exim 4.63)
	(envelope-from <xsdg@mit.edu>)
	id 1IBDJj-0007P5-Ax
	for linux-acpi@vger.kernel.org; Wed, 18 Jul 2007 17:28:03 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, all.  I'm trying to compile 2.6.21.6 for an Intel SR6850HW4, which 
is a quad dual-core (with hyperthreading) Xeon box, so linux detects 16 
logical processors.

The Debian SID kernels 2.6.18-4-686 and 2.6.21-2-686 boot fine, but only 
pick up 8 of the 16 processors (compiled-in limit) and 2 (not 4?) of the 
16 GB of memory.  On the 2.6.21 kernels I've compiled, however, the 
machine locks after displaying the message "Brought up 16 CPUs".  At 
this point, SysRQ does not evoke a response and I'm forced to 
hard-reboot the machine.

If I boot with acpi=off with any of the kernels I've compiled (2.6.21* 
or 2.6.22.1), the machine boots fine until it can't find the root 
partition (which, I'd guess, is related to it wanting to use ACPI to 
discover the SCSI controller that the root partition is on).  Someone in 
#kernelnewbies suggested acpi=ht, acpi=noirq, pci=noacpi, and noapic, 
none of which prevented the lockup.

In terms of timers, I've tried both with and without tickless; HPET and 
Enhanced RTC are always compiled in.

Also of note, running 2.6.22.1, I encounter the issue mentioned at [1], 
and one of the following two things happens:
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
..MP-BIOS Bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...   failed.
...trying to set up timer as Virtual Wire IRQ... failed.
...trying ot ste up timer as ExtINT IRQ... failed :(.
Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with 
apic=debug and send a report.  Then try booting iwth the 'noapic' option

OR

...
checking TSC synchronization [CPU#0 -> CPU#7]: passed.
checking TSC synchronization [CPU#0 -> CPU#8]:
Measured 117 cycles TSC warp between CPUs, turning off TSC clock.
Marking TSC unstable due to: check_tsc_sync_source failed.
Brought up 16 CPUs
<machine locks up here as with 2.6.21.6>

To be clear, with 2.6.21 and 2.6.21.6, all of the TSC synchronization 
checks pass all of the time.

I'll probably work on moving my configuration toward 2.6.21-2-686's 
configuration (or vice-versa; not sure yet) to try to figure out when it 
breaks/starts working.  However, if anyone has any suggestions, I'd love 
to hear them; I've been banging my head against this for more than a few 
hours now.  Hopefully-useful debug info (including lspci, dmesg, and 
relevant .config's) are at [2]. TIA.

[1] http://marc.info/?l=linux-kernel&m=118401628825056&w=2
[2] http://xsdg.mit.edu/~xsdg/nl/acpi/

--xsdg


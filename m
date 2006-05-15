From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Problem with Dual Core & ACPI
Date: Mon, 15 May 2006 18:43:52 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB675A9F1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7059 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750702AbWEOWn4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2006 18:43:56 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David.Ronis@mcgill.ca, linux-acpi@vger.kernel.org

>I'm trying to get a new dual-core Intel Pentium D box to work, but I'm
>having trouble getting SMP working.
>
>Here's where I am:
>
>1.  With the 2.6.12 kernel from the knoppix disk, things work.  Two
>processors are recognized at boot time.
>
>2.  With 2.6.16.16 things hang at boot time when ACPI is enabled (even
>when passing acip=ht at boot).  I see the following:
>
>Enabling IO-APIC IRQ's
>...TIMER:  vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1

Is this the last thing printed before the hang?
While this line is printed by horrible cruft that should
have been deleted from the kernel years ago, it is
actually nominal output.

Any chance you can capture the console output with "debug"
from the failure case?

>On another pentium 4 hyperthreaded box I see the same followed by:
>.
>.MP-BIOS bug: 8254 timer not connected to IO-APIC
>...trying to set up timer (IRQ0) through the 8259A ...  failed.
>...trying to set up timer as Virtual Wire IRQ... works.
>checking TSC synchronization across 2 CPUs: passed.
>Brought up 2 CPUs
>and the boot succeeds.

This isn't a good model of "working" to follow.
It is in MP mode, MP mode is broken, and a workaround is being invoked.

>3.  Disabling ACPI (yes, ACPI, not APIC) either by passing acpi=off or
>in building the kernel, works; I boot, but only one processor is
>recognized.

if you boot with "apic=off" (yes APIC, not ACPI:-), does the system
come up in ACPI+PIC mode?

how about if you boot with "maxcpus=1", does that come up in ACPI
mode normally?

Please file a bugzilla here where you can attach the dmesg
and /proc/interrupts from these cases.

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

thanks,
-Len

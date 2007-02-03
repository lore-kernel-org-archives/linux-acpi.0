From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320 - Booting on battery power causes softlock
Date: Sat, 03 Feb 2007 15:02:45 +0000
Message-ID: <1170514965.6252.13.camel@localhost>
References: <1169002596.29755.5.camel@localhost>
	 <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:46458 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946468AbXBCPCz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Feb 2007 10:02:55 -0500
In-Reply-To: <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wed, 2007-01-17 at 11:04 +0800, Luming Yu wrote:
> The first thing is to make sure you are running the latest bios, kernel.
> Then, you need to sort out the kernel component/modules/drivers that
> cause the problem.
> If you guess it is ACPI issue, pleas test boot option acpi=off to see
> if the problem goes away. If you guess it is battery issue, please
> remove battery module, etc.
> Please don't forget to enter a bug in bugzilla.kernel.org.
> 
> Thanks,
> Luming

AFAIK, I'm on the current bios.. I updated it when I initially had
problems with CPU Frequency scaling. I'll check.

Kernel.. still debugging with the Ubuntu one, but will try a fresh
vanilla one when I get free time (not needing the machine for work).

I've tried booting with init=/bin/sh to drop me into the initrd of the
system, then grabbed an acpidump when booting on battery. It was the
same as AC.

Manually bootstrapping the root file-system, (not via normal init),
allowed me to play about with what might cause the lockup, and it seems
that it may be related to the Intel wireless driver: ipw3945.

When I loaded it, it failed to find firmware - no crash. (I'd not got
udev running to help hotplug the firmware for it).

I loaded udev, and re-tried loading the wireless. Appologies that this
crash dump is a type-up, I think the key points should be here - no
time-stamps, but a full trace is listed.

[ loading ipw3945 module via modprobe ]
...
[ Detects ]
[ Prints module copyright ]
ACPI: PCI Interrupt 0000:08:00.00[A] -> GSI16 (level,low) -> IRQ 169
ipw3945: Detected .... 3945ABG ....
BUG: Soft lockup ... CPU#0

<c01481cf> softlockup_tick+0x9f/0xf0   <c012bee1> update_process_times
+0x31/0x80

<c0114d13> smp_apic_timer_interrupt+0x53/0x60   <c010413c>
apic_timer_interrupt+0x1c/0x30

<f8a240f7> ipw_bg_alive_start+0x67/0xa0 [ipw3945]   <c0132702>
run_workqueue+0x72/0xf0

<f8a24090> ipw_bg_alive_start+0x0/0xa0 [ipw3945]   <c01331d0>
worker_thread+0x0/0x140

<c0135f8b> kthread+0xab/0xe0   <c0135ee0> ktherad+0x0/0e0

<c0101005> kernel_thread_helper+0x5/0x10


Hope that helps cast some light on the problem..

Regards

Peter Clifton



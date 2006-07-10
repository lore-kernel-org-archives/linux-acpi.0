From: Mike Galbraith <efault@gmx.de>
Subject: Re: [GIT PATCH] ACPI for 2.6.18-rc1
Date: Mon, 10 Jul 2006 09:39:40 +0200
Message-ID: <1152517180.12021.16.camel@Homer.TheSimpsons.net>
References: <200606230437.50845.len.brown@intel.com>
	 <200606300220.39405.len.brown@intel.com>
	 <200607011730.24361.len.brown@intel.com>
	 <200607100301.58861.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.21]:16322 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161353AbWGJHd4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 03:33:56 -0400
In-Reply-To: <200607100301.58861.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 03:01 -0400, Len Brown wrote:
> Hi Linus,
> 
> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

Do you have a plain old patch (scm impaired) lying around?

I'm experiencing some suspend to disk woes with 2.6.18-rc1 that are
starting to look like it _could_ be troubles with ACPI changes.  Looking
at the change log, I don't really see anything that looks likely to help
(making messages debug only ain't gonna do it;), but I'd like to try the
latest before doing the massive revert/poke/prod/oops/panic number.

	-Mike

Freezing cpus ...
CPU 1 is now offline
SMP alternatives: switching to UP code
CPU1 is down
Stopping tasks: ===========================================================================================================|
Shrinking memory...  -done (0 pages freed)
pnp: Device 00:07 disabled.
Device `[USBE]' is not power manageable
Device `[FAN]' is not power manageable
Class driver suspend failed for cpu0
Could not power down device firmware: error -22
Some devices failed to power down, aborting suspend
Device `[FAN]' is not power manageable
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
Device `[USBE]' is not power manageable
PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PM: Writing back config space on device 0000:00:1d.7 at offset f (was 400, writing 403)
PM: Writing back config space on device 0000:00:1d.7 at offset 4 (was 0, writing ea200000)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.5 to 64
bttv0: reset, reinitialize
bttv0: PLL: 28636363 => 35468950 .. ok
eth3: link up, 100Mbps, full-duplex, lpa 0x45E1
pnp: Device 00:07 activated.
pnp: Failed to activate device 00:09.
Restarting tasks...
 Strange, kacpid_notify not stopped
 done
Thawing cpus ...
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=b15b6000 soft=b15ae000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5984.17 BogoMIPS (lpj=2992089)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
CPU1 is up
Loaded prism54 driver, version 1.2
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 19
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[22]  MMIO=[ea004000-ea0047ff]  Max Packet=[2048]  IR/IT contexts=[8/8]



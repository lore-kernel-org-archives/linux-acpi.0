From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [2.6.22] ACPI video problems with T60p laptop
Date: Wed, 25 Jul 2007 09:53:13 +0800
Message-ID: <1185328394.3226.15.camel@hp-nx500.sh.intel.com>
References: <974101.13462.qm@web52908.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43016 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932398AbXGYBa3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jul 2007 21:30:29 -0400
In-Reply-To: <974101.13462.qm@web52908.mail.re2.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-acpi@vger.kernel.org

On Tue, 2007-07-24 at 22:34 +0100, Chris Rankin wrote:
> Hi,
> 
> I have noticed the following problems with the ACPI video functionality on my Thinkpad T60p
> laptop:
> 
> - The kernel is likely to lock up when the video.ko modules loads, if nmi_watchdog=1
> - The VID/ directory appears twice in the /proc/acpi/video/ directory:
> 
> $ ls -alis /proc/acpi/video/
> total 0
> 4026532147 0 dr-xr-xr-x  4 root root 0 2007-07-24 22:17 .
> 4026531915 0 dr-xr-xr-x 12 root root 0 2007-07-24 19:27 ..
> 4026532169 0 dr-xr-xr-x  5 root root 0 2007-07-24 22:17 VID
> 4026532169 0 dr-xr-xr-x  5 root root 0 2007-07-24 22:17 VID
> 
Hmm, duplicated device names show in /proc.
As the ACPI procfs won't be removed in the near future, we need
something else rather than the string from BIOS as the device name.
Another problem is that procfs doesn't care if there are any duplicated
names.

> - Close the laptop lid, wait a bit, open the lid again, and the X server has crashed. (The kernel
> survives, but the screen is a multi-coloured mess. Ctrl-Alt-Backspace still works, though.)

Please open another bug at bugzilla.kernel.org and attach the dmesg,
acpidump and lspci output.

Thanks,
Rui
> ACPI: SSDT 7FEF1D36, 02C4 (r1  PmRef  Cpu0Ist      100 INTL 20050513)
> ACPI: SSDT 7FEF207F, 065A (r1  PmRef  Cpu0Cst      100 INTL 20050513)
> Monitor-Mwait will be used to enter C-1 state
> Monitor-Mwait will be used to enter C-2 state
> Monitor-Mwait will be used to enter C-3 state
> ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
> ACPI: Processor [CPU0] (supports 8 throttling states)
> ACPI: SSDT 7FEF1C6E, 00C8 (r1  PmRef  Cpu1Ist      100 INTL 20050513)
> ACPI: SSDT 7FEF1FFA, 0085 (r1  PmRef  Cpu1Cst      100 INTL 20050513)
> ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
> ACPI: Processor [CPU1] (supports 8 throttling states)
> ACPI: Thermal Zone [THM0] (35 C)
> ACPI: Thermal Zone [THM1] (37 C)
> 
> ...
> 
> ACPI: AC Adapter [AC] (on-line)
> ACPI: Battery Slot [BAT0] (battery present)
> ACPI: ACPI Dock Station Driver 
> ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: found ejectable bay
> ACPI: \_SB_.PCI0.IDE0.PRIM.MSTR: Adding notify handler
> ACPI: Bay [\_SB_.PCI0.IDE0.PRIM.MSTR] Added
> input: Power Button (FF) as /class/input/input3
> ACPI: Power Button (FF) [PWRF]
> input: Lid Switch as /class/input/input4
> ACPI: Lid Switch [LID]
> input: Sleep Button (CM) as /class/input/input5
> ACPI: Sleep Button (CM) [SLPB]
> set_level status: 0
> ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
> set_level status: 0
> ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
> 
> Cheers,
> Chris
> 
> 
> 
> 
>       ___________________________________________________________ 
> Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for
> your free account today http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/5] WMI patches for acpi-test
Date: Sat, 2 Feb 2008 22:44:22 -0500
Message-ID: <200802022244.22917.lenb@kernel.org>
References: <20080202121718.2286.89857.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38739 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756174AbYBCDoo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 22:44:44 -0500
In-Reply-To: <20080202121718.2286.89857.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

Hi Carlos,
Thanks for your persistence.

I've included this patch series to the acpi-test branch.

I think the indication of success of this effort will be
other people writing drivers to do useful things with
the WMI hooks you are exposing.  So we certainly want to
get the base driver out there sooner to support that.

I don't know if it would be better to ship a prototype
sysfs user interface in the hopes it encourages adopters
and get feedback to make it better, or to bake it more
out of tree in the hopes of shipping something more 
final in the first shot.

I'm inclined to ship an EXPERIMENTAL API because
the more eyes on it sooner the better.  One option
would be to have the sysfs I/F be a sub-config option
that is default N -- indeed, you can call it a DEBUGGING
or DEVELOPMENT I/F to scare people away from the the wrong impression:-)
 
> Patch #1: (WMI - driver and in kernel interface) - Minor clean up
> 
> Replace leftover occurences of 'x == NULL' with '!x'
> 
> Len: For you to review and to be applied to acpi-test.
> 

> +config ACPI_WMI
> +	tristate "WMI (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
> +	default m

I deleted the "default m" line when i checked in this patch.
So if you revise/resend this patch in the future, please do the same.

> ====
> 
> Patch #2: (acer-wmi) - New DMI entry, mail LED detection fix, mismatch fix
> 
> * Don't fail if we can't detect a mail LED on AMW0 systems
> * Add an EC quirk for the Acer Aspire 9110
> * Fix section mismatch warnings
> 
> Len: For you to review and to be applied to acpi-test.

acer-wmi needs a MAINTAINER

> 
> Patch #3: (tc1100-wmi) - No Change
> 
> RFC only, needs actual testing on the hardware, and probably very broken.
> Waiting on Matthew Garrett to get some free time to test this.

tc1100-wmi needs a MAINTAINER

> Patch #4: (WMI sysfs interface) - No Change
> 
> RFC only (see patch #5 for reason and discussion). Adds interface under
> /sys/devices/virtual/wmi
> 
> Also adds a function to return the (virtual) device associated with a GUID for
> use by other parts of the kernel that want to set a parent device.
> 
> Len: To review (but not to apply yet, unless you want to apply patch #5 as well)

I don't understand the WMI user/kernel sysfs API.

I guess i had originally expected it to live in /sys/firmware/wmi,
but I see that they put dmi a subset of DMI under /sys/class/dmi,
so i guess there is precident...  I got my main wish, which was
to have not _not_ be under some ACPI specific directory:-)

> Patch #5: (WMI sysfs workaround) - No Change
> 
> Temporary hack, needed to get patch #4 working, due to a limitation on bus_id
> length (Kay Sievers is apparently working on this, ref Greg KH[1]).
> 
> Len:
> 
> Apparently, the necessary fixes _might_ go into 2.6.25 as well, or worst case
> scenario is 2.6.26[2]. So we can either:
> 
> 1) Hold off on patch #4 until the necessary fixes go in (this might be 2.6.25
> if we're lucky, or we end up putting off WMI sysfs support until 2.6.26)
> or
> 
> 2) Apply patch #4, and #5 on top as a temporary hack, and then revert #5 as
> soon as the necessary changes go in. (For bisection purposes, #4 and #5 should
> be merged if we go ahead with this).
> 
> I don't know what would be the best solution here.

#2 is the better route -- move forward using workaround,
and revert the workaround when it is no longer needed.
The risk is if somebody in user-space starts actually
programming to 19-character GUIDS.

> [1] http://lkml.org/lkml/2007/12/4/30
> [2] http://www.nabble.com/Re:-Fix-Firmware-class-name-collision-p14352966.html

I loaded this driver on an HP nx6325 as well as a Lenovo T61.

just for kicks i tried to dump the data attributes,
but on both machines I found that some of them oops
in wmi_data_read like below.

thanks,
-Len

Feb  2 22:05:55 t61 kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
Feb  2 22:05:55 t61 kernel: IP: [<ffffffff8808bcce>] :wmi:wmi_data_read+0xc2/0xe0
Feb  2 22:05:55 t61 kernel: PGD 7bcdc067 PUD 719b9067 PMD 0
Feb  2 22:05:55 t61 kernel: Oops: 0000 [1] SMP
Feb  2 22:05:55 t61 kernel: CPU 0
Feb  2 22:05:55 t61 kernel: Modules linked in: acpi_cpufreq pcmcia yenta_socket rsrc_nonstatic wmi ac battery video thermal iwl4965 mac80211 cfg80211 e1000e thinkpad_acpi backlight nvram
Feb  2 22:05:55 t61 kernel: Pid: 3875, comm: cat Not tainted 2.6.24-06933-g9b85450-dirty #112
Feb  2 22:05:55 t61 kernel: RIP: 0010:[<ffffffff8808bcce>]  [<ffffffff8808bcce>] :wmi:wmi_data_read+0xc2/0xe0
Feb  2 22:05:55 t61 kernel: RSP: 0018:ffff810071851e68  EFLAGS: 00010296
Feb  2 22:05:55 t61 kernel: RAX: 0000000000000000 RBX: ffff81007b4a6118 RCX: 0000000000000010
Feb  2 22:05:55 t61 kernel: RDX: 00000000ffffffcb RSI: ffff810071851d78 RDI: ffff81007b4a6d70
Feb  2 22:05:55 t61 kernel: RBP: ffff810071851ea8 R08: 0000000000001000 R09: ffff81007b83c9b0
Feb  2 22:05:55 t61 kernel: R10: ffff810071851d88 R11: 0000000000000246 R12: 0000000000001000
Feb  2 22:05:55 t61 kernel: R13: ffff81007b4a6128 R14: 0000000000000000 R15: ffffffff8808d7e0
Feb  2 22:05:55 t61 kernel: FS:  00007f7b4130d6f0(0000) GS:ffffffff80777000(0000) knlGS:0000000000000000
Feb  2 22:05:55 t61 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Feb  2 22:05:55 t61 kernel: CR2: 0000000000000000 CR3: 00000000719b0000 CR4: 00000000000006e0
Feb  2 22:05:55 t61 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Feb  2 22:05:55 t61 kernel: DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Feb  2 22:05:55 t61 kernel: Process cat (pid: 3875, threadinfo ffff810071850000, task ffff81007b45a280)
Feb  2 22:05:55 t61 kernel: Stack:  ffffffffffffffff 0000000000000000 0000000000000000 0000000147a52f6e
Feb  2 22:05:55 t61 kernel:  ffff810071851ea8 ffff81007ac61dd0 0000000000001000 00000000ffffffed
Feb  2 22:05:55 t61 kernel:  ffff810071851f08 ffffffff802c8b83 ffff810071851f48 0000000000abf000
Feb  2 22:05:55 t61 kernel: Call Trace:
Feb  2 22:05:55 t61 kernel:  [<ffffffff802c8b83>] read+0xc8/0x137
Feb  2 22:05:55 t61 kernel:  [<ffffffff80287583>] vfs_read+0xab/0x134
Feb  2 22:05:55 t61 kernel:  [<ffffffff80287948>] sys_read+0x47/0x6f
Feb  2 22:05:55 t61 kernel:  [<ffffffff8020b16b>] system_call_after_swapgs+0x7b/0x80
Feb  2 22:05:55 t61 kernel:
Feb  2 22:05:55 t61 kernel:
Feb  2 22:05:55 t61 kernel: Code: c9 4c 89 ef e8 5b fe ff ff 48 c7 c7 50 d8 08 88 e8 47 f9 4e f8 eb 10 48 8d 55 c0 41 0f b6 f4 4c 89 ef e8 f7 fc ff ff 48 8b 45 c8 <8b> 00 83 e8 02 83 f8 02 48 19 c0 48 f7 d0 48 83 e0 fb 48 83 c4
Feb  2 22:05:55 t61 kernel: RIP  [<ffffffff8808bcce>] :wmi:wmi_data_read+0xc2/0xe0
Feb  2 22:05:55 t61 kernel:  RSP <ffff810071851e68>
Feb  2 22:05:55 t61 kernel: CR2: 0000000000000000
Feb  2 22:05:55 t61 kernel: ---[ end trace 0d56088a35d7a80e ]---

From: Marc MERLIN <marc@merlins.org>
Subject: s2disk support: everything works but S4 aborts with no error message
Date: Mon, 21 May 2012 20:25:08 -0700
Message-ID: <20120522032508.GE5612@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:52144 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab2EVDZJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 May 2012 23:25:09 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.77 #2)
	id 1SWfie-0004ef-Cn
	for <linux-acpi@vger.kernel.org>; Mon, 21 May 2012 20:25:08 -0700
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Is there a correct list suspend to disk nowadays? All places I looked at
seem deprecated.

Thanks,
Marc

----- Forwarded message from Marc MERLIN <marc@merlins.org> -----

From: Marc MERLIN <marc@merlins.org>
To: tim@famdijkstra.org, kix@kix.es,
	Pavel Machek <pavel@atrey.karlin.mff.cuni.cz>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Luca Tettamanti <kronos.it@gmail.com>,
	Arkadiusz Miskiewicz <arekm@pld-linux.org>

First, I apologize for Emailing you directly. I just spent 1H going
through uwsuspend pages to try and get the proper support channel, and
all I find is stuff about s2ram not being supported anymore and nothing
for s2disk.
The sourceforge mailing list looks like it's just spam now.

Could
http://suspend.sourceforge.net/index.shtml
and
http://en.opensuse.org/SDB:Suspend_to_disk
be updated?

Now my question: My W500 thinkpad used to suspend to disk fine, ans
suspend to RAM still works fine.

Nowever, now suspend to disk goes through all the motions and then at
the last minute aborts with no error message I can find:

[654238.177362] PM: Allocated 7472832 kbytes in 14.36 seconds (520.39 MB/s)
[654238.177364] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[654238.192429] Suspending console(s) (use no_console_suspend to debug)
[654238.194763] hdaps: setting ec_rate=0, filter_order=1
[654238.416586] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[654238.416623] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[654238.452391] ACPI handle has no context!
[654238.460177] ACPI handle has no context!
[654238.556462] snd_hda_intel 0000:00:1b.0: PCI INT B disabled
[654238.572160] PM: freeze of devices complete after 379.725 msecs
[654238.572996] PM: late freeze of devices complete after 0.831 msecs
[654238.573911] ACPI: Preparing to enter system sleep state S4
[654238.736159] PM: Saving platform NVS memory
[654238.739887] Disabling non-boot CPUs ...
[654238.844093] CPU 1 is now offline
[654238.844823] Extended CMOS year: 2000
[654238.844907] PM: Creating hibernation image:
[654238.848080] PM: Need to copy 175601 pages
[654238.848080] PM: Normal pages needed: 175601 + 1024, available pages: 1894772
[654238.848080] PM: Hibernation image created (175601 pages copied)

It fails here, but I don't know why, and then it resumes.

[654238.848080] Extended CMOS year: 2000
[654238.848080] Enabling non-boot CPUs ...
[654238.853369] Booting Node 0 Processor 1 APIC 0x1
[654238.853372] smpboot cpu 1: start_ip = 99000
[654238.744242] Calibrating delay loop (skipped) already calibrated this CPU
[654238.744242] Disabled fast string operations
[654238.864793] NMI watchdog enabled, takes one hw-pmu counter.
[654238.865083] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for [EmbeddedControl] (20110623/evregion-478)
[654238.865088] ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPC_.EC__.LPMD] (Node ffff88022ec7a790), AE_BAD_PARAMETER (20110623/psparse-536)
[654238.865095] ACPI Error: Method parse/execution failed [\_PR_.CPU0._PPC] (Node ffff88022eca7f60), AE_BAD_PARAMETER (20110623/psparse-536)
[654238.865101] ACPI Error: Method parse/execution failed [\_PR_.CPU1._PPC] (Node ffff88022eca7df8), AE_BAD_PARAMETER (20110623/psparse-536)
[654238.865108] ACPI Exception: AE_BAD_PARAMETER, Evaluating _PPC (20110623/processor_perflib-140)
[654238.872190] CPU1 is up
[654238.875838] ACPI: Waking up from system sleep state S4

Kernel is: 3.2.16-amd64

Any idea how I can debug further?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/

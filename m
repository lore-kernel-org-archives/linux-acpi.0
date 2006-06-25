From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Issues with the ACPI subsystem?
Date: Sun, 25 Jun 2006 14:59:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6D35554@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12435 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932438AbWFYS70 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Jun 2006 14:59:26 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ionic <ionic@root24.de>
Cc: linux-acpi@vger.kernel.org

>I started installing Gentoo Linux 2006.0 with Kernel 2.6.16.x (Vanilla,
>but with vesafb-tng, later also suspend2). With this Kernel, I 
>was never
>able to power off my Notebook properply. After running `shutdown -h
>now', init was called and everything went down without any problems.
>Then, there was written "Power off.". However, the Notebook was never
>powered off anyway. I had to do it myself every time.
>
>Well, this changed with Kernel 2.6.17. I'm using Kernel 2.6.17.1 with
>the ACPI patchset, vesafb-tng, suspend2 and SquashFS3 now.
>My actual problem is, that the Notebook powers down without any
>problems, when I did not start any Desktop Environments.
>But after starting any DE (I tried Fluxbox, GNOME, KDE, XFCE and
>BlackBox so far), the Notebook is not powering down anymore and I have
>to do it manually again. This seems very strange to me. I also disabled
>any ACPI features in the DE (like a battery-applet or something like
>this; Black- and FluxBox doesn't even have such) without any luck.

So the latest kernel powers down properly, but only if you don't start
X?
With older kernels it would not power down even without X?

Sounds like an issue with the video driver/BIOS.

>Well, my question is, whether this could be an ACPI problem? 
>If yes, how
>could it be fixed? I'm using a costum DSDT table already. Not, that
>there were many errors or warnings I found with the INTEL(r) ACPI tool,
>the only warning was about the _WAK function, which I could 
>remove using
>a workaround in the Gentoo Forum
>(http://forums.gentoo.org/viewtopic.php?t=122145).
>Apart from this, the table is clean. The compiler says, that there are
>36 optimizations, but I do not understand this, though. Are that
>optimizations, that can be done while compiling the table to a *.hex
>table? Although I'm running the new, clean table, the IASL says
>everytime something about 36 optimizations.

Actually, I'd prefer that you not modify your DSDT at all.
Verify that you have the latest BIOS from the vendor,
and if Windows can deal with it and Linux can not,
then it is a Linux bug that we need to know about --
not something you want to hide by modifying the firmware.


So check your BIOS.
Check your video driver version, and the version of X in general.

Yes, the issue is probably an interaction with ACPI, but
is quite possibly a firmware or video software platform-specific issue.

-Len

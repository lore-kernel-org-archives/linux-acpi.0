From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [3.4-rc5 -> 3.4-rc6 regression] Asus P5NSLI: lockup on resume
 from suspend
Date: Sun, 8 Jul 2012 02:37:58 -0500
Message-ID: <20120708073758.GC4625@burratino>
References: <op.wg3en6ij6g6bxc@localhost.localdomain>
 <Pine.LNX.4.44L0.1207072208270.508-100000@netrider.rowland.org>
 <20120708025730.GE2961@burratino>
 <op.wg30yabp6g6bxc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51351 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2GHHiD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jul 2012 03:38:03 -0400
Received: by obbuo13 with SMTP id uo13so18379915obb.19
        for <linux-acpi@vger.kernel.org>; Sun, 08 Jul 2012 00:38:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <op.wg30yabp6g6bxc@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Octavio Alvarez <alvarezp@alvarezp.com>
Cc: Bob Moore <robert.moore@intel.com>, 680707@bugs.debian.org, linux-acpi@vger.kernel.org

Hi again,

Octavio Alvarez wrote:

> The problem is a full system lock-up on resume. The HD led stays on.
> The 5-sec power-button cycle isn't enough to get the system back.
> It requires a full mechanical power cycle from the power supply.
>
> I bisected the problem as requested by Alan Stern, and tracked it
> down to the following commit:
[...]
>     ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl registers

Looks similar to https://bugzilla.kernel.org/show_bug.cgi?id=43641

The purpose of commit 2feec47d4c5f was to add support for ACPI 5
registers.  ACPI 5 was published in November, 2011.  Your BIOS is from
2008 and uses a version 3 FADT.

I guess we'll have to sift through

 5 files changed, 475 insertions(+), 679 deletions(-)

for the unintended change.  Hmm.

Could you try the following in order to make the hunt easier?
Please enable ACPI_DEBUG and ACPI_DEBUG_FUNC_TRACE:

	scripts/config --enable ACPI_DEBUG
	scripts/config --enable ACPI_DEBUG_FUNC_TRACE
	make deb-pkg; # maybe with -j4
	reboot

Set debug_layer to ACPI_HARDWARE and debug_level to 0xffffffff:

	echo 2 >/sys/module/acpi/parameters/debug_layer
	echo 0xffffffff >/sys/module/acpi/parameters/debug_level

and get a log of what happens during the suspend and resume that locks
up.  You'll probably need to use a serial console or netconsole to get
the log (boot with no_console_suspend to make sure log output
continues to flow during the suspend process).  [1] and [2] explain
how to set up a serial console or netconsole.

([3] and [4] describe ACPI debugging and no_console_suspend.)

It's possible and even likely that the kernel won't be awake enough to
say anything interesting at the crucial moment, but I figure it's
worth a try (and at least it can say a little about what happened
during suspend).

Thanks for your patience.
Jonathan

[1] Documentation/serial-console.txt
[2] Documentation/networking/netconsole.txt
[3] Documentation/acpi/debug.txt
[4] Documentation/power/basic-pm-debugging.txt

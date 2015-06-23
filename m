From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: Re: Debugging spurious wakeup
Date: Tue, 23 Jun 2015 08:36:12 +0200
Message-ID: <20150623063612.GA27891@sottospazio.it>
References: <20150513065825.GA10680@sottospazio.it>
 <20150620215441.GA32242@rhlx01.hs-esslingen.de>
 <20150622194855.GA16269@sottospazio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m-r2.th.seeweb.it ([5.144.164.171]:36562 "EHLO
	m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbFWGgS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jun 2015 02:36:18 -0400
Content-Disposition: inline
In-Reply-To: <20150622194855.GA16269@sottospazio.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Hello,

Yesterday I took the time to read the document about GPE / PME handling and I
compared the wakeup code of my BIOS with the examples in that document.

I noticed that some vital wakeup code was executed only when a variable (PMSX)
was set. That variable was set by a global NPME() method and that method was
called by _OSC().

And in my logs I had this message:

giu 19 18:31:06 zanac kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI]
giu 19 18:31:06 zanac kernel: \_SB_.PCI0:_OSC invalid UUID
giu 19 18:31:06 zanac kernel: _OSC request data:1 1f 0
giu 19 18:31:06 zanac kernel: acpi PNP0A08:00: _OSC failed (AE_ERROR);
disabling ASPM

A googled a bit and found the following bugzilla entry, that applies to my
situation perfectly: the NEXP variable isn't set anywhere, yet in Windows it
is.

https://bugzilla.kernel.org/show_bug.cgi?id=36932

So I disassembled the DSDT, I removed any test involving the NEXP variable in
the code, I recompiled and replaced the table with GRUB.

And then the _OSC() invocation completed successfully, giving me a working WOL
without spontaneous wakeups!

What puzzles me is that the location of the NEXP variables is marked as ACPI
NVS and the kernel never touches that region of memory. What is Windows doing
differently that makes it work?

However I consider the issue solved now. I leave also the link to the Arch
forum post where I describe in detail what I did for future reference.

https://bbs.archlinux.org/viewtopic.php?pid=1538895#p1538895

The document 074_GPE_Routing.doc proved very useful and I want to thank you for
your hints and the help I got from people in this mailing list.

Gianluca

PS: the PME ReqID marks the source of the latest wakeup and was then a lead of
the device responsible for the wakeup. But the problem was elsewhere...

On Mon, Jun 22, 2015 at 09:48:55PM +0200, Gianluca Anzolin wrote:
> Thank you for sharing your experience, the document about GPE and PME
> seems useful to pinpoint the issue: as explained in another email, I
> found a difference in lspci when the undesired wakeup occurs and it
> involves PME signals:
> 
> -		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
> +		RootSta: PME ReqID 0400, PMEStatus- PMEPending-
> 
> The problem is, these difference is not related to the network PCI
> device but to the PCI bridge behind which the network device sits.
> 
> If I find something useful (unlikely, but never lose the hope) I'll send
> an update :)
> 
> Thank you,
> 
> Gianluca
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in

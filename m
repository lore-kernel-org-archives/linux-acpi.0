From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Support Fujitsu Lifebook S6410 in fujitsu-laptop
Date: Mon, 14 Apr 2008 14:11:43 +0200
Message-ID: <1208175103.1784.72.camel@queen.suse.de>
References: <20080305030147.GA25310@earth.gruber.myown>
	 <1207784442.32532.0.camel@earth.gruber.myown>
	 <1208103760.19605.5.camel@earth.gruber.myown>
	 <1208169984.1784.37.camel@queen.suse.de>
	 <1208171944.888.20.camel@earth.gruber.myown>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:53444 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758569AbYDNMLq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 08:11:46 -0400
In-Reply-To: <1208171944.888.20.camel@earth.gruber.myown>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>

Hi,

Robert/Ming: you might be interested in the broken SSDT table on latest
Fujitsus mentioned at the end of this mail.

On Mon, 2008-04-14 at 13:19 +0200, nokos@gmx.net wrote:
> Am Montag, den 14.04.2008, 12:46 +0200 schrieb Thomas Renninger:
> > On Sun, 2008-04-13 at 18:22 +0200, nokos@gmx.net wrote:
> > > There was an small error in the last patch, here the corrected version.
> > 
> > IMO there should be two fujitsu drivers, one for:
> > ACPI_FUJITSUB1_HID                "FUJ02B1"
> > e.g. acpi_fujitsu_brightness
> > or
> > acpi_fujitsu_02b1
> > and one for:
> > ACPI_FUJITSUE3_HID                "FUJ02E3"
> > e.g. acpi_fujitsu_keys
> > or
> > acpi_fujitsu_02e3
> > not sure what the perfect name could be...
> > 
> > There probably are machines out there which only have one of above
> > devices, then only the relevant driver should be loaded.
> 
> I thought the since there is only a small functionality in each part and
> the module only registers drivers which are started only if an
> appropriate device is present it might be good to integrate it in one
> module. (in the S6410 case there is actually a third device FUJ02E1 but
> I don't know yet what it is for, there are some notifies for that device
> in the DSDT but so far I haven't triggered any of them)

One driver per device is the way to go IMO.
If you know that these devices are always present together..., but even
then it is easier to review/read and makes things more modular, e.g. you
can let the one driver depend on backlight, the other one input or
whatever other needed subsystems and e.g. only compile out brightness
support if you like to (may be convenient for backlight being managed
via video driver at some time), but still make use of the the hotkey
driver.

> The problem is this:
> The brightness adjustment stuff in the DSDT is:
>        Method (_L1C, 0, NotSerialized)
>         {
>             Store (SSF0, Local0)
>             Store (Local0, SSF0)
>             And (Local0, Not (SSM0), Local0)
>             Store (SSF1, Local1)
>             Store (Local1, SSF1)
>             And (Local1, Not (SSM1), Local1)
>             Store (SSF2, Local2)
>             Store (Local2, SSF2)
>             And (Local2, Not (SSM2), Local2)
>             If (And (Local0, 0x01))
>             {
>                 \_SB.PCI0.GFX0.PHTK ()
>                 Store (0x80, BCMD)
>                 Store (Zero, SMIC)
>                 \_SB.PCI0.GFX0.AHTK ()
>                 If (BSWF)
>                 {
>                     If (LGreaterEqual (\_SB.OSTP (), 0x40))
>                     {
>                         \_SB.PCI0.GFX0.LCD.BLNF ()
>                     }
>                     Else
>                     {
>                         Name (BLTS, Zero)
> ...
> the \_SB.OSTP ()is the switch controlled by osi vista (0x40 for windows
> 2006)
> and the _SB.PCI0.GFX0.LCD.BLNF () is in an external table which has
> signature "\0\0\0\0" and hence is not loaded by the linux acpi system.
> Interestingly if you force it to be loaded (eg. by rewriting the
> signature in drivers/acpi/tables/tbinstal.c) the linux acpi system
> detects brightness control via ACPI_VIDEO but doesn't do anything if I
> try to change the brightness ... 
> 
> Also since the additional table has no signature acpidump does not dump
> it ...

Ahhh, this one.
This is related to:
http://bugzilla.kernel.org/show_bug.cgi?id=9919
In fact the bug is about another problem, but also shows this issue.
Instead of mixing things up in this bug, could you open another one and
attach acpidump and the acpidump --addr xy --length yx output of the
broken "visit" table (you can take over the address and length of the
OperationRegion), pls.

Can you then give the other guys in above bug a pointer to the newly
created and add Robert.Moore@intel.com and ming.m.lin@intel.com and me
to the list of CC'ed people. They have to decide how to deal with this
(probably) BIOS bug. I could imagine a solution similar to: The
signature is ignored for tables loaded via "load" ASL table runtime
loading commands in SLACk mode.
There were a lot table loading fixes posted for 2.6.26, but I doubt they
cover this bug.

An already uploaded broken Fujitsu SSDT(but mixed with another bug) can
be found here (comment #15):
http://bugzilla.kernel.org/show_bug.cgi?id=9919#c15

Thanks,

     Thomas


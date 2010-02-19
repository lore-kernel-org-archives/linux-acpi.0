From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI thermal: Check for thermal zone requiremen
Date: Fri, 19 Feb 2010 11:20:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002191108590.4030@localhost.localdomain>
References: <1266357351-20224-1-git-send-email-trenn@suse.de>
 <1266357351-20224-2-git-send-email-trenn@suse.de>
 <alpine.LFD.2.00.1002190138310.24628@localhost.localdomain>
 <201002191220.56517.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:18634 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0BSQUy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 11:20:54 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY300161K40AAO3@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Feb 2010 10:21:37 -0600 (CST)
In-reply-to: <201002191220.56517.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

> > What good things happen after this patch that didn't happen before it?
> 
> The guy sees a valid temperature, in /proc-/sys and also in the
> corresponding X-apps (which his original complaints were).
>
> The thermal zone has a valid passive trip point (95 C), which now is 
> active again.

I understand the 1st patch to not disqualify a TZ if it has
a bogus _CRT.  That would make a TZ show up rather than
get discarded.  If that patch compiled cleanly, I'd apply it...

I don't understand this patch to scan a TZ for trip points
and print out a kernel warning about a firmware bug
for TZ's which have none, and disqualify those TZ's.
That isn't going to make temperature available when it
was not already available.  That is going to add an additional
kernel message about a firmware bug we can't fix, and could
actually delete a thermal zone with a working temperature
that used to be present, no?

> He reported this as a regression, let me double check:
> 
> Oh dear..., _CRT doesn't return anything for Windows 2006
> (or newer, not defined Windowses) -> broken trip point.
> 
> There is a Linux workaround (which does not work anymore,
> this probably was the reason for the regression -> OSI!=Linux),
> which make _CRT return a valid trip point like on old Windowses.
> 
> So this makes the behavior more "latest Windows OS" like.
> Hmm, depends whether Windows still takes the thermal zone into
> account if _CRT is not available or invalid.
> The fact that a valid _HOT trip point is only exported on latest
> Windowses, hardens the guess that Windows also serves this
> thermal zone with an invalid critical trip point.
> It looks like the (TPOS == 0x40) thermal workarounds wants to avoid
> thermal shutdowns (critical) in case 100 C are reached and change it
> into a (debug?) message (_HOT) on latest Windowses.


> Related ASL output:
> 
> 
> If (_OSI ("Linux"))
>                 {
>                     Store (One, LINX)
>                     Store (0x80, OSTB)
>                     Store (0x80, TPOS)
>                 }
> If (_OSI ("Windows 2006"))
>                 {
>                     Store (0x40, OSTB)
>                     Store (0x40, TPOS)
>                 }
> 
> ...
> Name (TPC, 0x64)
> Method (_HOT, 0, Serialized)
> {
>     If (LEqual (TPOS, 0x40))
>     {
>         Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
>     }
> }
> 
> Method (_CRT, 0, Serialized)
> {
>     If (LNotEqual (TPOS, 0x40))
>     {
>         Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
>     }
> }

It appears that if acpi_osi=Linux were set (or TPOS were
anything other than Windows 2006), then you
would not get a _HOT or _CRT in this TZ.
I don't understand how that is related to this issue,
as acpi_osi=Linux is not set, right?

acpi_osi="Windows 2006", on the other hand, should be set.
In that case the AML will return a valid trip point for
both _HOT and _CRT, yes?  So what is the problem?

-Len


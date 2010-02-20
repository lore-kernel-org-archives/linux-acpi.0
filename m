From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI thermal: Check for thermal zone requiremen
Date: Fri, 19 Feb 2010 23:57:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002192353591.4030@localhost.localdomain>
References: <1266357351-20224-1-git-send-email-trenn@suse.de>
 <201002191220.56517.trenn@suse.de>
 <alpine.LFD.2.00.1002191108590.4030@localhost.localdomain>
 <201002191737.49957.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:47855 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0BTE5f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 23:57:35 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY400K9XJ3W1D84@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 19 Feb 2010 22:57:32 -0600 (CST)
In-reply-to: <201002191737.49957.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org


On Fri, 19 Feb 2010, Thomas Renninger wrote:

> On Friday 19 February 2010 17:20:51 Len Brown wrote:
> > > > What good things happen after this patch that didn't happen before it?
> > > 
> > > The guy sees a valid temperature, in /proc-/sys and also in the
> > > corresponding X-apps (which his original complaints were).
> > >
> > > The thermal zone has a valid passive trip point (95 C), which now is 
> > > active again.
> > 
> > I understand the 1st patch to not disqualify a TZ if it has
> > a bogus _CRT.  That would make a TZ show up rather than
> > get discarded.  If that patch compiled cleanly, I'd apply it...
> > 
> > I don't understand this patch to scan a TZ for trip points
> > and print out a kernel warning about a firmware bug
> > for TZ's which have none, and disqualify those TZ's.
> > That isn't going to make temperature available when it
> > was not already available.  That is going to add an additional
> > kernel message about a firmware bug we can't fix,
> Hmm, Firmware bugs which we can't fix and can't even work around always
> should at least end up in a firmware bug/warning message.
> 
> > and could actually delete a thermal zone with a working temperature
> > that used to be present, no?

> Not really. At least not worse than before.
> Before my previous patch every thermal zone without a valid critical
> trip point was discarded with an error message.

i agree with the 1st patch,
as I said, if it built cleanly (hint hint) I'd apply it.

> Now you need at least one.
> 
> My patch sticks to the spec and only discards the thermal zone if there
> is no trip point at all. In this case you want to throw a (firmware bug)
> message as something is obviously wrong.

This is the non-obvious part.
Yes, a thermal zone that has no trip point doesn't follow the spec.
I don't know if any exist or not, but I don't see any harm if they do.
I think it would be dandy for linuxfirmware test kit to look
for this BIOS issue, but I don't see how the user is helped
if the kernel looks for it.  All the get is an additional
kernel message and perhaps the loss of the ability to
tell the temperature when perhaps they could before.
That doesn't sound like a step forward.

thanks,
Len Brown, Intel Open Source Technology Center


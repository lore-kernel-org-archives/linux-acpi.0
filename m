From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI battery driver emits POWER_SUPPLY_STATUS_FULL when
 power lead plugged in (resend)
Date: Sat, 07 Feb 2009 22:59:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902072258330.6197@localhost.localdomain>
References: <1232729843.3504.6.camel@hughsie-work.lan>
 <497A13C0.5020604@suse.de> <20090123220243.GB26701@khazad-dum.debian.net>
 <1232753981.3504.10.camel@hughsie-work.lan> <497A5D49.6070706@suse.de>
 <20090124124158.GC5325@khazad-dum.debian.net> <497B43D3.80703@suse.de>
 <1232879297.3518.26.camel@hughsie-work.lan>
 <20090125134203.GA12776@khazad-dum.debian.net>
 <1233148811.4231.0.camel@hughsie-work.lan>
 <20090130140702.GA14714@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:30807 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZBHEAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 23:00:12 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEQ005YKB2I2KO2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 21:59:07 -0600 (CST)
In-reply-to: <20090130140702.GA14714@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Richard Hughes <hughsient@gmail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi <linux-acpi@vger.kernel.org>, mjg <mjg@redhat.com>, Matthias Clasen <mclasen@redhat.com>


On Fri, 30 Jan 2009, Henrique de Moraes Holschuh wrote:

> On Wed, 28 Jan 2009, Richard Hughes wrote:
> > The attached patch checks the last full and design charge, as this seems
> > to work in all cases I have here. In the case of broken batteries or
> > broken hardware, we just return UNKNOWN in this "settling" state, which
> > is much better for userspace than falling back to full.
> > 
> > With the attached patch userspace gets the right states. In the future,
> > maybe we can do some sort of metric over time (watching to see if the
> > present charge changes) but for the most part the patch fixes things up
> > for userspace.
> 
> I am ok with this patch, but it does have *one* corner case.
> 
> Brand new good batteries will be reported as full while still charging, when
> they're near 100% (they will be above the design capacity).
> 
> That isn't enough for me to complain about the patch, and the patch makes it
> MUCH better than the current broken behaviour.
> 
> So you can have my Acked-by if you want it, for whatever little it is worth.

Applied to acpi-test.

thanks,
Len Brown, Intel Open Source Technology Center

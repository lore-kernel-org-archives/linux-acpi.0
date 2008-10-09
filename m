From: Len Brown <lenb@kernel.org>
Subject: Re: Buggy BIOS on the HP TX2500-series
Date: Wed, 08 Oct 2008 22:04:55 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810082203280.8572@localhost.localdomain>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com>
 <20081008192641.GA1932@srcf.ucam.org> <1223513955.2735.28.camel@rzhang-dt>
 <20081009011150.GA7496@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:37790 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbYJICFI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 22:05:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K8G0010F8G8FG47@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 08 Oct 2008 21:04:57 -0500 (CDT)
In-reply-to: <20081009011150.GA7496@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>



On Thu, 9 Oct 2008, Matthew Garrett wrote:

> On Thu, Oct 09, 2008 at 08:59:15AM +0800, Zhang Rui wrote:
> > On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> > > A patch went into the kernel earlier this year to ignore critical trip
> > > points that were below 0.
> > well, I think this patch is wrong.
> > a critical trip point below 0 Celsius doesn't mean it's invalid.
> 
> I think it's pretty clear that a critical trip point below 0 celsius 
> means that the critical trip point is invalid, though I agree that 
> ignoring the entire thermal zone as a result is somewhat unfortunate.
> 
> > windows can work well on this laptop.
> > please look at:
> > http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
> > IMO, we need to fix the ACPICA code first of all.
> > 
> > Ming, what do you think of the patch in comment #15 and #16?
> 
> We could quibble over the technical correctness of this approach, but it 
> seems to behave in exactly the same way - ie, Linux will ignore the 
> thermal zone? The existing code seems fine, other than the fact that a 
> bad _CRT will result everything failing. I think we'd be better off just 
> losing the return -ENODEV there and try to use as much of the thermal 
> information as we can.

right, when we put in the workaround we observed that a bad _CRT
would delete an entire thermal zone, and that could be a big
problem on a box with active cooling on that thermal zone.

of course if we are successful on the implicit return front,
this becomes unnecessary.

-Len


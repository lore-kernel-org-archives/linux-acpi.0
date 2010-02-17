From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Tue, 16 Feb 2010 21:49:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
 <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
 <20100216154053.GA31195@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:38703 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933633Ab0BQCtS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 21:49:18 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXY00AWBT5X8TKK@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 20:49:14 -0600 (CST)
In-reply-to: <20100216154053.GA31195@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl

> > un-applied.
> > 
> > Even if deleting the blacklist entries were correct,
> > which it more or less may be, the bug at hand is that
> > "acpi=ht" is now broken -- whether invoked via DMI
> > or cmdline; and this patch doesn't fix that.
> 
> Indeed it doesn't. But the report also noted that the system worked fine 
> with acpi=force, so this is something that we should clean up regardless 
> of the original bug.

I fixed the acpi=ht option, and also removed the
system at hand from the blacklist.  This is what
2.6.33 and 2.6.32.stable need.

In the future, I'll consider deleting the "acpi=ht"
option all together, and the blacklist with it,
but such changes are always harder than expected.

On a related topic, we should probably consider bringing
back the "noht" option.  However we would do so by
checking the APIC-id topology rather than assuming
any consistency in how the BIOS enumerates the processors.

thanks,
-Len Brown, Intel Open Source Technology Center


From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/7] acpi: remove old blacklist entries
Date: Fri, 19 Feb 2010 00:44:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002190028510.17638@localhost.localdomain>
References: <201002022238.o12Mbx54018702@imap1.linux-foundation.org>
 <alpine.LFD.2.00.1002160253470.21595@localhost.localdomain>
 <alpine.LFD.2.00.1002160317570.21595@localhost.localdomain>
 <20100216154053.GA31195@srcf.ucam.org>
 <alpine.LFD.2.00.1002161553420.3995@localhost.localdomain>
 <20100217143245.GA18411@srcf.ucam.org>
 <alpine.LFD.2.00.1002171122140.4135@localhost.localdomain>
 <20100217183108.GA23189@srcf.ucam.org>
 <alpine.LFD.2.00.1002171618210.4135@localhost.localdomain>
 <20100217212851.GA27092@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:32227 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab0BSFoi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 00:44:38 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY2007KZQMBBS42@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 23:44:35 -0600 (CST)
In-reply-to: <20100217212851.GA27092@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, arekm@maven.pl, feng.tang@intel.com, flinco@libero.it, mad_soft@inbox.ru, rjw@sisk.pl


> So the APM idle loop won't have been used?

APM -- by definition -- is not present on SMP motherboards,
and thus is a non-factor on motherboards where acpi=ht
would be used.

> I was under the impression 
> that C1 was preferable to just calling hlt, but I'll admit to having no 
> idea if that's true for the PIII.

C1 and HLT are synonymous on P-III, and also many other systems.

MWAIT hints for use in the idle loop were added after Pentium III.

The power savings of MWAIT for C1 is the same as HLT, but
the wakeup mechanism is lower overhead, especially on systems
with lots of processors.

Today, MWAIT extension "hints" are used to get into deep C-states,
but that was not the case for PIII.

> I'd also have expected there to be at 
> least S1, so ACPI would be a functional improvement.

Apparently nobody has complained about lacking that feature
on this motherboard during the last 6 years, so I wouldn't
recommend losing any sleep over it.

> > > At least one of them covers a single submodel in a range, despite them 
> > > all running the same BIOS. I'd really lean towards them being bogus at 
> > > this stage of the game.
> > 
> > While I too vote for consistency and less cruft is better,
> > I'd like to keep the acpi_ht issue at hand apart from the
> > inconsistency in old thinkpad BIOS DMI list issue; as they
> > are logically independent.
> 
> They're similar in that we have absolutely no idea why these entries are 
> present, potentially resulting in us reducing the functionality of 
> machines that would otherwise work happily.

I know for a fact that some of the entries on that list are valid.
I'm delited to clean up the ones that are cruft, and I thank you for
noticing that a cleanup is necessary, but deleting them en-masse
would be folly.

thanks,
-Len Brown, Intel Open Source Technology Center



From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [regression] v2.6.24-rc1-497-gb1d08ac: kde battery icon gone
Date: Sun, 11 Nov 2007 21:42:29 +0100
Message-ID: <20071111204229.GA17289@elte.hu>
References: <472B5C01.7090508@m3y3r.de> <20071103110452.GA8658@elte.hu> <200711041015.24689.arvidjaar@mail.ru> <200711041413.52876.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:50655 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698AbXKKUnB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Nov 2007 15:43:01 -0500
Content-Disposition: inline
In-Reply-To: <200711041413.52876.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Thomas Meyer <thomas@m3y3r.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > See this commit:
> > 
> > commit fb804714560463534ebcb538a3b0a3c687a830ec
> > Author: Len Brown <len.brown@intel.com>
> > Date:   Tue Jul 24 01:50:46 2007 -0400
> > 
> >     ACPI: Kconfig: CONFIG_ACPI_PROCFS now defaults to N
> > 
> >     delete "default y" from CONFIG_ACPI_PROCFS
> >     (effectively making the default 'N')
> > 
> >     List exactly what /proc files this option controls,
> >     and clarify that it doesn't change non-deprecated files.
> > 
> >     Signed-off-by: Len Brown <len.brown@intel.com>
> > 
> > So at least battery change should have added /proc/acpi/battery to this list.
> 
> IMHO, the source of the problem is the battery change that has 
> introduced the dependency on ACPI_PROCFS _although_ it's unset by 
> default and that is a regression (ie. confuses users with older user 
> space).

"older user space" meaning just about every Linux box that is out there 
at the moment. So this is a regression, the user does not care why it 
happened, and needs fixing.

> > May be we need separate ACPI_PROCFS_xxx for every subsystem.
> 
> Well, I'm not sure.  I think that documenting the dependency should be 
> sufficient.

No. We never remove a bit of relied-on API from the kernel like that. At 
minimum it must go through a long deprecation cycle before it's turned 
off by default. Really, is this some sort of weird "how can we piss off 
and lose as many beta testers as possible in the shortest amount of 
time" contest? Will people search for a few new lines of documentation 
(out of the 1 million lines of kernel code that 2.6.24 changes) when 
'make oldconfig' breaks their laptop setup - or will they just go over 
to a more tester-friendly project? Compatibility is our utmost priority 
(and your regressions list is a very good tool for us to keep 
compatibility), especially in an incredibly easy case like this where 
the fix is 1 changed byte with no harm done to anyone.

	Ingo

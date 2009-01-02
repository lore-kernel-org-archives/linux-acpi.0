From: Len Brown <lenb@kernel.org>
Subject: Re: [incremental-PATCH-for-Sam's-Review] ACPI: use ccflags-y instead
 of EXTRA_CFLAGS
Date: Fri, 02 Jan 2009 17:17:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901021709480.3590@localhost.localdomain>
References: <1230720725-9376-1-git-send-email-lenb@kernel.org>
 <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
 <20081231133901.GB2388@uranus.ravnborg.org> <87bpusv31n.fsf@basil.nowhere.org>
 <20081231153441.GA3475@uranus.ravnborg.org>
 <alpine.LFD.2.00.0901021636050.3590@localhost.localdomain>
 <20090102215208.GA8494@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:37615 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbZABWSD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2009 17:18:03 -0500
In-reply-to: <20090102215208.GA8494@uranus.ravnborg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



> > --- a/drivers/acpi/Makefile
...
> > +ccflags-y			:= -Os

> The conversion from ACPI_CFLAGS to ccflags-y is fine.
> And if acpi really require -Os then this part is also OK -
> I just did not get *why* acpi needs -Os

ACPI does not "need" -Os.

However, ACPI in Linux has been built with -Os since 2.4
on the assumption that since ACPI should never be performance critical,
that it was best to simply have it consume as little space as possible.

It appears that the entire kernel is now built with -Os by default,
so it looks like this is now redundant in the default case and will
have an effect only when somebody disables CONFIG_CC_OPTIMIZE_FOR_SIZE
to build with -O2.

So I'm willing to delete -Os from the ACPI Makefile
in the interest of simplicity.

thanks,
Len Brown, Intel Open Source Technology Center

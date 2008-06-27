From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 04/10] acpi: adjust _acpi_{module,function}_namedefinitions
Date: Thu, 26 Jun 2008 22:20:26 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806262210520.2988@localhost.localdomain>
References: <200805010952.m419q3Jc031806@imap1.linux-foundation.org>
 <1209722812.22514.28.camel@linux-2bdv.site>
 <20080502054113.4e5839d9.akpm@linux-foundation.org>
 <1209737075.22514.79.camel@linux-2bdv.site>
 <9D39833986E69849A2A8E74C1078B6B3446FBD@orsmsx415.amr.corp.intel.com>
 <20080623124523.76f38d90.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:39427 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYF0CUj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2008 22:20:39 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3300B9SNU4Q8I7@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 26 Jun 2008 21:20:29 -0500 (CDT)
In-reply-to: <20080623124523.76f38d90.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, trenn@suse.de, linux-acpi@vger.kernel.org, jbeulich@novell.com



> > >But in future, such patches should definitely be based against ACPICA
> > >code. Len will probably announce here where to find the very latest
> > >sources, soon. Currently the latest official release linked to on
> > >http://lesswatts.org is still from 2006. AFAIK things will get better
> > >here, soon.
> > >
> > >   Thomas
> > 
> > 
> > The latest ACPICA source can be found at the acpica.org website. In
> > fact, we have converted our source repository from CVS to git, and the
> > actual working git repository is now publicly available at
> > 
> > http://www.acpica.org/repos/acpica.git/
> > 
> > The acpica.org website was created at the end of 2007, and is now the
> > home of the acpica project.
> > 
> 
> OK, I'm now peeved.

please, don't be.

> I've sent this patch ten damned times now and only once was there any
> comment and it was this vague indecisive wafflefest from which I now
> discover I was removed from Cc.

it appears that the cc: list was trimmed when a discussion
about the ACPCIA git tree URL was sent.

Unfortunately on May 6th when bob e-mailed that he'd pulled the patch 
into ACPICA, he replied to that branch of the thread and not the 
original.

If I pulled from Bob instantaneously, you'd have got a reject
when creating -mm on that day.  As it turns out, we had more
urgent fish to fry that day, so it came out the end of
the ACPICA->Linux pipe later.

> Well someone has now merged something else which wrecked this patch
> whcih I've been maintaining (for you guys!) for over two months. 
> 
> I'll drop it.  Please try harder.

Please do drop it, because it is already in linux-acpi.
It probably didn't reject cleanly because Lindent is too.

In the future, please simply do not accept
patches to drivers/acpi/*/* (the ACPICA files) into -mm.

Instead, bounce them to the Linux/ACPI maintainer,
who will bounce them to the ACPICA maintainer --
which is the head of the stream for these sub-directories.

Yes, I could have and should have asked you to drop these
ACPICA cleanups back when I bounced them to Bob.
I certainly don't want to create more work for you.

thanks,
-Len

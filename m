From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/15] ACPICA: move common private headers under
 kernel/acpi/acpica/
Date: Thu, 08 Jan 2009 23:34:49 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901082328160.4091@localhost.localdomain>
References: <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
 <c6b6f68232ab6da57e764c64b23b4649c4e7c463.1230719801.git.len.brown@intel.com>
 <20090102191451.GB14249@elte.hu>
 <alpine.LFD.2.00.0901021438060.3590@localhost.localdomain>
 <20090107221017.GD17917@elte.hu> <20090108160304.GA30619@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:40064 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbZAIEfJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 23:35:09 -0500
In-reply-to: <20090108160304.GA30619@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>



> On Wed, Jan 07, 2009 at 11:10:17PM +0100, Ingo Molnar wrote:
> > i still tend to regard kernel/* as the core Linux kernel, as code that can 
> > be improved infinitely (only subject to the laws of physics), without 
> > having to worry about how the ACPI spec wants certain things done.

I want to move the Linux-ACPI code and the ACPICA core
out of drivers/ simply because they are not drivers,
and never will be.

The actual ACPI drivers, OTOH, would remain in drivers/acpi/.

So looking around...

arch/ doesn't make sense for something shared by x86 and ia64

firmware/ seems to be about software that doesn't run on the CPU.

kernel/ is evidently sacred ground.                 
 
So I suggest "platform/acpi/" or if we can't imagine any
other cross architecture platform code code that isn't device drivers,
then simply "acpi/"  Would you find that less offensive?

thanks,
Len Brown, Intel Open Source Technology Center


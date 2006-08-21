From: Andi Kleen <ak@suse.de>
Subject: Re: Freeing ACPI tables after parsing
Date: Tue, 22 Aug 2006 00:06:47 +0200
Message-ID: <20060822000647.2b117f6c.ak@suse.de>
References: <200608211146.53379.ak@suse.de>
	<200608211752.16616.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:11999 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751238AbWHUWG5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Aug 2006 18:06:57 -0400
In-Reply-To: <200608211752.16616.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Natalie.Protasevich@unisys.com

On Mon, 21 Aug 2006 17:52:16 -0400
Len Brown <len.brown@intel.com> wrote:


> > During SLES10 testing we had some problems with the ACPI 
> > tables on some Unisys systems being in a area where the kexec kernel
> > wanted to be loaded too. 
> 
> Why does the kexec kernel care what physical memory it is loaded into,

At least the one in SLES10 was linked to a fixed address (64MB@64MB)
In the future it will be relocatable, but still there will be defaults
passed in advance.

Unisys ended up fixing it with a new BIOS, but I can well see this
happening again.

> and how can it be guaranteed that address is not reserved by the platform firmware?

I don't think there is a fool proof method right now, just heuristics
However freeing ACPI would avoid some of the potential problems.

> > Also on other systems the ACPI tables are not 
> > exactly at the end but in the middle of the memory map and for some applications
> > it might be better to have a lot of physical continuous memory.
> > 
> > So are there any plans to free the BIOS supplied ACPI tables after parsing
> > or is there some obstacle to that that I'm missing?
> 
> As Alexey wrote, he and Bob have already deleted the kernel's new copy
> of the tables in favor of using them 'in place'.
> 
> I guess I'm not clear on the requirement here.
> If we were to alter that plan to make a kernel copy -- and release the original BIOS memory --
> assuming it is marked such that we can release it -- how do we know that
> we are not dropping the new copy someplace that kexec doesn't want it?

There are other allocations anyways and the allocators tend to cluster, so one would
assume it ends up being ok. If there are conflicts they can be handled in
one single place in Linux. But Linux can't affect the BIOS' choice of table
placement.

Also I suspect the kernel can store it more efficiently in memory. When the tables
are reserved in memory they will be always rounded up/down to page boundaries,
while a kernel allocation can fit it better. At least for some of them (like fadt)
the kernel seems to use globals already too, so the original mapping wouldn't be 
needed.

-Andi
 

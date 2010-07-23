From: Andi Kleen <ak@linux.intel.com>
Subject: Re: swiotlb detection should be memory hotplug aware ?
Date: Fri, 23 Jul 2010 17:23:33 +0200
Message-ID: <4C49B3F5.3030904@linux.intel.com>
References: <20100721135750Z.fujita.tomonori@lab.ntt.co.jp> <1279732414.10874.6.camel@ank32.eng.vmware.com> <20100722084413I.fujita.tomonori@lab.ntt.co.jp> <20100722090329O.fujita.tomonori@lab.ntt.co.jp> <1279823680.31733.20.camel@ank32.eng.vmware.com> <20100723142208.GA4008@phenom.dumpdata.com> <4C49A83C.8070203@linux.intel.com> <20100723145945.GA31857@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27515 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758360Ab0GWPXh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jul 2010 11:23:37 -0400
In-Reply-To: <20100723145945.GA31857@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Alok Kataria <akataria@vmware.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, "lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Vandrovec <petr@vmware.com>


> I was thinking about this at some point. I think the first step is to
> make SWIOTLB use the debugfs to actually print out how much of its
> buffers are used - and see if the 64MB is a good fit.

swiotlb is near always wrongly sized. For most system it's far too much, 
but for some
not enough. I have some systemtap scripts around to instrument it.

Also it depends on the IO load, so if you size it reasonable you
risk overflow on large IO (however these days this very rarely happens 
because
all "serious" IO devices don't need swiotlb anymore)

The other problem is that using only  two bits for the needed address 
space is also extremly
inefficient (4GB and 16MB on x86). Really want masks everywhere and 
optimize for the
actual requirements.

> The shrinking part scares me - I think it might be more prudent to first
> explore on how to grow it. The big problem looks to allocate a physical
> contiguity set of pages. And I guess SWIOTLB would need to change from
> using one big region to something of a pool system?
>

Shrinking: you define a movable zone, so with some delay it can be 
always freed.

The problem with swiotlb is however it still cannot block, but it can 
adapt to load.

The real fix would be blockable swiotlb, but the way drivers are set up 
this is difficult
(at least in kernels using spinlocks)

>> allocator patchkit,
>> unfortunately that didn't go forward.
> I wasn't present at that time so I don't know what the issues were - you
> wouldn't have a link to LKML for this?


There wasn't all that much opposition, but I ran out of time because 
fixing the infrastructure
(e.g. getting rid of all of GFP_DMA) is a lot of work. In a sense it's a 
big tree sweep project like
getting rid of BKL.

The old patch kit is at ftp://firstfloor.org/pub/ak/dma/
"intro" has the rationale.

I have a slightly newer version of the SCSI & misc drivers patchkit 
somewhere.

-Andi


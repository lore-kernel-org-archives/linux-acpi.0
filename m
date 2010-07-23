From: Andi Kleen <ak@linux.intel.com>
Subject: Re: swiotlb detection should be memory hotplug aware ?
Date: Fri, 23 Jul 2010 16:33:32 +0200
Message-ID: <4C49A83C.8070203@linux.intel.com>
References: <20100721135750Z.fujita.tomonori@lab.ntt.co.jp> <1279732414.10874.6.camel@ank32.eng.vmware.com> <20100722084413I.fujita.tomonori@lab.ntt.co.jp> <20100722090329O.fujita.tomonori@lab.ntt.co.jp> <1279823680.31733.20.camel@ank32.eng.vmware.com> <20100723142208.GA4008@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39214 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab0GWOdi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jul 2010 10:33:38 -0400
In-Reply-To: <20100723142208.GA4008@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Alok Kataria <akataria@vmware.com>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, "lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Vandrovec <petr@vmware.com>


> I thought SRAT has NUMA affinity information - so for example my AMD
> desktop box has that, but it does not support hotplug capability.
>
> I think first your 'hotplug_possible' code needs to be more specific -
> not just check if SRAT exists, but also if there are swaths of memory
> that are non-populated. It would also help if there was some indication
> of whether the box truly does a hardware hotplug - is there a way to do
> this?

The SRAT declares hotplug memory ranges in advance. And Linux already 
uses this
information in the SRAT parser (just the code for doing this is a bit 
dumb, I have a rewrite
somewhere)

The only drawback is that some older systems claimed to have large 
hotplug memory ranges
when they didn't actually support it. So it's better to not do anything 
with a lot
of overhead.

So yes it would be reasonable to let swiotlb (and possibly other code 
sizing itself
based on memory) call into the SRAT parser and check the hotplug ranges too.

BTW longer term swiotlb should be really more dynamic anyways and grow
and shrink on demand. I attempted this some time ago with my DMA 
allocator patchkit,
unfortunately that didn't go forward.

-Andi


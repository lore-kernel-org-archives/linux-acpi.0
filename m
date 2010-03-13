From: Andi Kleen <ak@linux.intel.com>
Subject: Re: swiotlb detection should be memory hotplug aware ?
Date: Fri, 12 Mar 2010 19:09:41 -0800
Message-ID: <4B9B01F5.3000807@linux.intel.com>
References: <1268446032.13691.69.camel@ank32>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21365 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757945Ab0CMDJn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2010 22:09:43 -0500
In-Reply-To: <1268446032.13691.69.camel@ank32>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akataria@vmware.com
Cc: Len Brown <lenb@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Petr Vandrovec <petr@vmware.com>

, Alok Kataria wrote:

Hi Alok,

> Hi,
>
> Looking at the current code swiotlb is initialized for 64bit kernels
> only when the max_pfn value is greater than 4G (MAX_DMA32_PFN value).
> So in cases when the initial memory is less than 4GB the kernel boots
> without enabling swiotlb, when we hotadd memory to such a kernel and go
> beyond the 4G limit, swiotlb is still disabled. As a result when any
> 32bit devices start using this newly added memory beyond 4G, the kernel
> starts spitting error messages like below or in some cases it causes
> kernel panics.

Yes seems like a real problem.

>
> 1. Enable swiotlb for all 64bit kernels which have memory hot-add
> support.

I don't think that's a good idea. It would enable it everywhere on
distributions which compile with hotadd. Need (2)

> 2. Instead of checking the max_pfn value in pci_swiotlb_detect, check
> for max_hotpluggable_pfn (or some such) value. Though I don't see such a
> value readily available. I could parse the SRAT and get hotplug memory
> information but that will make swiotlb detection logic a little too
> complex. A quick look around srat_xx.c files and the acpi_memhotplug
> module didn't find any useful API that could be used directly either.
> So was wondering if any of you are aware of an easy way to get such
> information ?

I have a patchkit to revamp the SRAT parsing to store the hotadd information
more efficiently (the current way is pretty dumb)  I need to repost that.

With that it would be relatively easy to do I think.

-Andi

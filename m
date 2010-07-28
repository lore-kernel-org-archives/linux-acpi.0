From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: swiotlb detection should be memory hotplug aware ?
Date: Wed, 28 Jul 2010 19:10:19 +0900
Message-ID: <20100728190939D.fujita.tomonori@lab.ntt.co.jp>
References: <4C49A83C.8070203@linux.intel.com>
	<20100723145945.GA31857@phenom.dumpdata.com>
	<4C49B3F5.3030904@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:55619 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab0G1KKh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jul 2010 06:10:37 -0400
In-Reply-To: <4C49B3F5.3030904@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: konrad.wilk@oracle.com, akataria@vmware.com, fujita.tomonori@lab.ntt.co.jp, lenb@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, petr@vmware.com

On Fri, 23 Jul 2010 17:23:33 +0200
Andi Kleen <ak@linux.intel.com> wrote:

> 
> > I was thinking about this at some point. I think the first step is to
> > make SWIOTLB use the debugfs to actually print out how much of its
> > buffers are used - and see if the 64MB is a good fit.
> 
> swiotlb is near always wrongly sized. For most system it's far too much, 
> but for some
> not enough. I have some systemtap scripts around to instrument it.

True, it's impossible to preallocate the best iotlb size statically.

 
> Also it depends on the IO load, so if you size it reasonable you
> risk overflow on large IO (however these days this very rarely happens 
> because
> all "serious" IO devices don't need swiotlb anymore)

Yeah, nowadays it's pointless to try to get the good performance with
swiotlb.


> The other problem is that using only  two bits for the needed address 
> space is also extremly
> inefficient (4GB and 16MB on x86). Really want masks everywhere and 
> optimize for the
> actual requirements.

swiotlb doesn't allocate GFP_DMA memory. It handles only GFP_DMA32.

swiotlb doesn't work for drivers with some odd dma mask (non 32bit)
but we have been lived with it so I don't think that it's a big issue.


I think, supporting expanding swiotlb dynamically is enough. The
default swiotlb size, 64MB is too large for majority.

I have a half-baked patch for it. I'll send it later.

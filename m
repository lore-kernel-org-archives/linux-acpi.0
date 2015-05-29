From: Ross Zwisler <zwisler@gmail.com>
Subject: Re: [PATCH 3/6] x86, pmem: add PMEM API for persistent memory
Date: Fri, 29 May 2015 06:07:57 -0600
Message-ID: <1432901277.4282.22.camel@gmail.com>
References: <1432852553-24865-1-git-send-email-ross.zwisler@linux.intel.com>
	 <1432852553-24865-4-git-send-email-ross.zwisler@linux.intel.com>
	 <5567A2C4.3040407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34377 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbbE2MH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2015 08:07:59 -0400
In-Reply-To: <5567A2C4.3040407@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-nvdimm@ml01.01.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, 2015-05-28 at 16:20 -0700, H. Peter Anvin wrote:
> On 05/28/2015 03:35 PM, Ross Zwisler wrote:
> > Add a new PMEM API to x86, and allow for architectures that do not
> > implement this API.  Architectures that implement the PMEM API 
> > should
> > define ARCH_HAS_PMEM_API in their kernel configuration and must 
> > provide
> > implementations for persistent_copy(), persistent_flush() and
> > persistent_sync().
> 
> >  
> >  void clflush_cache_range(void *addr, unsigned int size);
> >  
> 
> No, no, no, no, no.  Include the proper header file.

I'm confused - I did inlcude <asm/cacheflush.h> in pmem.h?  The line
you're quoting above was an unmodified line from asm/cacheflush.h - I
didn't redefine the prototype for clflush_cache_range() anywhere.

Or does this comment mean that you think we shouldn't have an
architecture agnostic PMEM API, and that you think the PMEM and ND_BLK
drivers should just directly include asm/cacheflush.h and use the x86
APIs directly?

> > +static inline void arch_persistent_flush(void *vaddr, size_t size)
> > +{
> > +   clflush_cache_range(vaddr, size);
> > +}
> 
> Shouldn't this really be using clwb() -- we really need a
> clwb_cache_range() I guess?

I think we will need a clwb_cache_range() for DAX, for when it responds
to a msync() or fsync() call and needs to rip through a bunch of
memory, writing it back to the DIMMs.  I just didn't add it yet because
I didn't have a consumer.

It turns out that for the block aperture I/O case we really do need a
flush instead of a writeback, though, so clflush_cache_range() is
perfect.  Here's the flow, which is a read from a block window
aperture:

1) The nd_blk driver gets a read request, and selects a block window to
use.  It's entirely possible that this block window's aperture has
clean cache lines associated with it in the processor cache hierarchy. 
 It shouldn't be possible that it has dirty cache lines - we either
just did a read, or we did a write and would have used NT stores.

2) Write a new address into the block window control register.  The
memory backing the aperture moves to the new address.  Any clean lines
held in the processor cache are now out of sync.

3) Flush the cache lines associated with the aperture.  The lines are
guaranteed to be clean, so the flush will just discard them and no
writebacks will occur.

4) Read the contents of the block aperture, servicing the read.

This is the read flow outlined it the "driver writer's guide":

http://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf  

> Incidentally, clflush_cache_range() seems to have the same flaw as 
> the
> proposed use case for clwb() had... if the buffer is aligned it will
> needlessly flush the last line twice.  It should really look 
> something
> like this (which would be a good standalone patch):
> 
> void clflush_cache_range(void *vaddr, unsigned int size)
> {
>         void *vend = vaddr + size - 1;
> 
>         mb();
> 
>       vaddr = (void *)
>               ((unsigned long)vaddr
>                & ~(boot_cpu_data.x86_clflush_size - 1));
> 
>         for (; vaddr < vend; vaddr += boot_cpu_data.x86_clflush_size)
>                 clflushopt(vaddr);
> 
>         mb();
> }
> EXPORT_SYMBOL_GPL(clflush_cache_range);

Ah, yep, I saw the same thing and already submitted patches to fix.  I
think this change should be in the TIP tree:

https://lkml.org/lkml/2015/5/11/336


> I also note that with your implementation we have a wmb() in
> arch_persistent_sync() and an mb() in arch_persistent_flush()... 
> surely one is redundant?

Actually, the way that we need to use arch_persistent_flush() for our
block window read case, the fencing works out so that nothing is
redundant.  We never actually use both a persistent_sync() call and a
persistent_flush() call during the same I/O.  Reads use
persistent_flush() to invalidate obsolete lines in the cache before
reading real data from the aperture of ete DIMM, and writes use a bunch
of NT stores followed by a persistent_sync().

The PMEM driver doesn't use persistent_flush() at all - this API is
only needed for the block window read case.

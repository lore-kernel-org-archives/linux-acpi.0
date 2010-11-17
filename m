From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -v4 1/2] lib, Make gen_pool memory allocator lockless
Date: Tue, 16 Nov 2010 18:35:06 -0800
Message-ID: <20101116183506.41e77e1a.akpm@linux-foundation.org>
References: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
	<1289868791-16658-2-git-send-email-ying.huang@intel.com>
	<20101116135038.fcaa90ca.akpm@linux-foundation.org>
	<1289960281.8719.1218.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45416 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754468Ab0KQCj0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Nov 2010 21:39:26 -0500
In-Reply-To: <1289960281.8719.1218.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Peter Zijlstra <peterz@infradead.org>

On Wed, 17 Nov 2010 10:18:01 +0800 Huang Ying <ying.huang@intel.com> wrote:

> On Wed, 2010-11-17 at 05:50 +0800, Andrew Morton wrote:
> > On Tue, 16 Nov 2010 08:53:10 +0800
> > Huang Ying <ying.huang@intel.com> wrote:
> > 
> > > This version of the gen_pool memory allocator supports lockless
> > > operation.
> > > 
> > > This makes it safe to use in NMI handlers and other special
> > > unblockable contexts that could otherwise deadlock on locks.  This is
> > > implemented by using atomic operations and retries on any conflicts.
> > > The disadvantage is that there may be livelocks in extreme cases.  For
> > > better scalability, one gen_pool allocator can be used for each CPU.
> > > 
> > > The lockless operation only works if there is enough memory available.
> > > If new memory is added to the pool a lock has to be still taken.  So
> > > any user relying on locklessness has to ensure that sufficient memory
> > > is preallocated.
> > > 
> > > The basic atomic operation of this allocator is cmpxchg on long.  On
> > > architectures that don't support cmpxchg natively a fallback is used.
> > > If the fallback uses locks it may not be safe to use it in NMI
> > > contexts on these architectures.
> > 
> > The code assumes that cmpxchg is atomic wrt NMI.  That would be news to
> > me - at present an architecture can legitimately implement cmpxchg()
> > with, say, spin_lock_irqsave() on a hashed spinlock.  I don't know
> > whether any architectures _do_ do anything like that.  If so then
> > that's a problem.  If not, it's an additional requirement on future
> > architecture ports.
> 
> cmpxchg has been used in that way by ftrace and perf for a long time. So
> I agree to make it a requirement on future architecture ports.

All I was really doing was inviting you to check your assumptions for
the known architecture ports.  Seems that I must do it myself.


dude, take a look at include/asm-generic/cmpxchg-local.h.  Not NMI-safe!

arch/arm/include/asm/atomic.h's atomic_cmpxchg() isn't NMi-safe.

arch/arm/include/asm/system.h uses include/asm-generic/cmpxchg-local.h.

as does avr32

and blackfin

Now go take a look at cris.

h8300 atomic_cmpxchg() isn't NMI-safe.

m32r isn't NMI-safe

go look at m68k, see if you can work it out.

microblaze?  Dunno.

mn10300 uniprocessor isn't NMI-safe

score isn't NMI-safe

I stopped looking there.


From: Andi Kleen <ak@suse.de>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: 27 Sep 2006 21:38:56 +0200
Message-ID: <p73fyedje0f.fsf@verdi.suse.de>
References: <200609271424.47824.eike-kernel@sf-tec.de>
	<pan.2006.09.27.17.56.13.80913@automagically.de>
	<20060927184037.GA3306@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:32434 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030682AbWI0Ti7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 15:38:59 -0400
In-Reply-To: <20060927184037.GA3306@athena.road.mcmartin.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org

Kyle McMartin <kyle@parisc-linux.org> writes:

> On Wed, Sep 27, 2006 at 07:56:13PM +0200, Markus Dahms wrote:
> > > I get this on my machine. SMP kernel, linus git from this morning. .config
> > > and test available on request.
> > 
> 
> I saw this as well.
> 
> Reverting,
> >       i386: Remove lock section support in semaphore.h
> 
> Fixes it for me (and apparently akpm too from Message-Id:
> <20060926224114.5ca873ec.akpm@osdl.org>)
> 
> Linus, please revert 01215ad8d83e18321d99e9b5750a6f21cac243a2 for now...

I expect this patch to fix it.

-Andi


i386: Use early clobbers for semaphores now

The new code does clobber the result early, so make sure to tell
gcc to not put it into the same register as a input argument

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-i386/semaphore.h
===================================================================
--- linux.orig/include/asm-i386/semaphore.h
+++ linux/include/asm-i386/semaphore.h
@@ -126,7 +126,7 @@ static inline int down_interruptible(str
 		"lea %1,%%eax\n\t"
 		"call __down_failed_interruptible\n"
 		"2:"
-		:"=a" (result), "+m" (sem->count)
+		:"=&a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;
@@ -148,7 +148,7 @@ static inline int down_trylock(struct se
 		"lea %1,%%eax\n\t"
 		"call __down_failed_trylock\n\t"
 		"2:\n"
-		:"=a" (result), "+m" (sem->count)
+		:"=&a" (result), "+m" (sem->count)
 		:
 		:"memory");
 	return result;

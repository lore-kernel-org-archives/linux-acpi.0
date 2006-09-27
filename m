From: Andi Kleen <ak@suse.de>
Subject: Re: [BUG] Oops on boot (probably ACPI related)
Date: 27 Sep 2006 21:38:03 +0200
Message-ID: <p73k63pje1w.fsf@verdi.suse.de>
References: <200609271424.47824.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:26546 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030704AbWI0TiJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 15:38:09 -0400
In-Reply-To: <200609271424.47824.eike-kernel@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org

Rolf Eike Beer <eike-kernel@sf-tec.de> writes:

> I get this on my machine. SMP kernel, linus git from this morning. .config and 
> test available on request.

What gcc do you use?

Anyways, does this patch fix it? This might have been Andrew's vaio problem too.

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

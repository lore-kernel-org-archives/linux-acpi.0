From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/4] acpi: add real mutex function calls
Date: Fri, 15 Aug 2008 21:11:09 -0700
Message-ID: <1218859870.6166.154.camel@dhcp32.mvista.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-2-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-3-git-send-email-dwalker@mvista.com>
	 <48A6002F.6070706@linux.intel.com>
	 <1218841806.6166.96.camel@dhcp32.mvista.com>
	 <48A6389A.5020604@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:59772 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbYHPPFH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Aug 2008 11:05:07 -0400
In-Reply-To: <48A6389A.5020604@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

On Sat, 2008-08-16 at 04:16 +0200, Andi Kleen wrote:
> > "To prevent deadlocks, wherever more than one synchronization object
> > must be owned, the synchronization
> > objects must always be released in the order opposite the order in which
> > they were acquired."
> > 
> > I think the ASL compiler should (does?) validate that. 
> 
> Bob should comment, but before we could rely on that it would also
> need to be ensured that _all_ AML compilers do that, including
> the one from Microsoft.

I think it would be great if they all did the _mandated_ checking, but
if they don't all do it, then it's not the end of the world.

> > With all that, and the fact that I don't see much of a reason to have
> > deep synchronization inside these AML's ,
> 
> I'm sure BIOS writers come up with things we never thought about.

True.

> > I think it's going to be a
> > very rare occasion that we find a lockdep warning inside the AML ..Even
> > if we did find a problem, that's something we would want to know about
> > and/or try to get fixed I would think.
> 
> I don't see a clear path to fix those if they happen. And just
> processing them would already tie up precious bughandling resources.
> It borders towards Steinbach's rule.

Your assuming this will be a huge problem, which it won't .. I would be
surprised if we even find one real problem.

> Now one possibility would be to figure out how to disable lockdep
> for them (perhaps optional with default to off).

It's possible .. You could also contact the authors , who should fix a
bona fide defect in their code. AML can also be de-compiled, and
modified, recompiled, then used in a modified state.

> But on the other hand your patch is non trivial amount of code.
> 
> Without the checking (which would seem more like a disadvantage in this case)
> the only advantage I can see of the mutexes would be PI handling in RT
> kernels, but that's clearly an out of tree usage right now (and also
> since AML is not executed in normal operation it's unlikely
> that PI for those is really critical for anyone)

Andi your saying you don't want to see the defects .. Maybe defects
exist, but you don't want to see them.. You don't know what's there, and
you don't want to know ?

We could simply revert the code if the defects are overwhelming..

> Any other reasons right now we would want that in tree?
> 

The checking is an advantage (contrary to your claim) .. I think it's
also a benefit to use the right API for what is needed, in fact ACPI is
not doing that. By using a mutex you are confined to a strict set of
rules which makes it much easier for outsiders to understand what the
code is doing. That also makes it easier to maintain.

Daniel


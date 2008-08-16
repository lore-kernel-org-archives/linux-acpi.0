From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/4] acpi: add real mutex function calls
Date: Sat, 16 Aug 2008 04:16:58 +0200
Message-ID: <48A6389A.5020604@linux.intel.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com>	 <1218831242-27618-2-git-send-email-dwalker@mvista.com>	 <1218831242-27618-3-git-send-email-dwalker@mvista.com>	 <48A6002F.6070706@linux.intel.com> <1218841806.6166.96.camel@dhcp32.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:2531 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751857AbYHPCQy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 22:16:54 -0400
In-Reply-To: <1218841806.6166.96.camel@dhcp32.mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>


> "To prevent deadlocks, wherever more than one synchronization object
> must be owned, the synchronization
> objects must always be released in the order opposite the order in which
> they were acquired."
> 
> I think the ASL compiler should (does?) validate that. 

Bob should comment, but before we could rely on that it would also
need to be ensured that _all_ AML compilers do that, including
the one from Microsoft.

> With all that, and the fact that I don't see much of a reason to have
> deep synchronization inside these AML's ,

I'm sure BIOS writers come up with things we never thought about.

> I think it's going to be a
> very rare occasion that we find a lockdep warning inside the AML ..Even
> if we did find a problem, that's something we would want to know about
> and/or try to get fixed I would think.

I don't see a clear path to fix those if they happen. And just
processing them would already tie up precious bughandling resources.
It borders towards Steinbach's rule.

Now one possibility would be to figure out how to disable lockdep
for them (perhaps optional with default to off).

But on the other hand your patch is non trivial amount of code.

Without the checking (which would seem more like a disadvantage in this case)
the only advantage I can see of the mutexes would be PI handling in RT
kernels, but that's clearly an out of tree usage right now (and also
since AML is not executed in normal operation it's unlikely
that PI for those is really critical for anyone)

Any other reasons right now we would want that in tree?

-Andi


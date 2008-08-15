From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/4] acpi: add real mutex function calls
Date: Fri, 15 Aug 2008 16:10:06 -0700
Message-ID: <1218841806.6166.96.camel@dhcp32.mvista.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-2-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-3-git-send-email-dwalker@mvista.com>
	 <48A6002F.6070706@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:8744 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbYHOXKK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 19:10:10 -0400
In-Reply-To: <48A6002F.6070706@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

On Sat, 2008-08-16 at 00:16 +0200, Andi Kleen wrote:
> Daniel Walker wrote:
> > Instead of re-using semaphores for the mutex operation, I've
> > added usage of the kernel mutex for the acpi os mutex
> > implementation.
> 
> This still implies that we'll get lockdep warnings if the AML
> does something dodgy with mutexes, right?

Right .. When I was first writing these changes, I got pretty freaked
out when I realized this .. However, I started reading about the Mutex
operations in the ACPI spec, "17.5.79 Mutex (Declare
Synchronization/Mutex Object)"

It says,

"To prevent deadlocks, wherever more than one synchronization object
must be owned, the synchronization
objects must always be released in the order opposite the order in which
they were acquired."

I think the ASL compiler should (does?) validate that. It also uses
something called a "synclevel" during mutex declaration which, I think,
is used to force a clear distinction between a mutex acquired at the
outer most level , and one which is nested X levels down.

Then the mutex release from "17.5.99 Release (Release a Mutex
Synchronization Object)" says when you release a mutex,

"If the mutex object is owned by the current invocation, ownership for
the Mutex is released once. It is fatal to release ownership on a Mutex
unless it is currently owned. A Mutex must be totally released before an
invocation completes."

With all that, and the fact that I don't see much of a reason to have
deep synchronization inside these AML's , I think it's going to be a
very rare occasion that we find a lockdep warning inside the AML ..Even
if we did find a problem, that's something we would want to know about
and/or try to get fixed I would think.

Daniel


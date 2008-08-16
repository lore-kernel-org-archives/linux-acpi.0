From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 4/4] acpi: semaphore removal
Date: Fri, 15 Aug 2008 21:15:18 -0700
Message-ID: <1218860118.6166.159.camel@dhcp32.mvista.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-2-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-3-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-4-git-send-email-dwalker@mvista.com>
	 <1218831242-27618-5-git-send-email-dwalker@mvista.com>
	 <48A6008A.8080104@linux.intel.com>
	 <1218845935.6166.116.camel@dhcp32.mvista.com>
	 <48A63609.4020403@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:59779 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbYHPPFH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Aug 2008 11:05:07 -0400
In-Reply-To: <48A63609.4020403@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

On Sat, 2008-08-16 at 04:06 +0200, Andi Kleen wrote:
> Daniel Walker wrote:
> > On Sat, 2008-08-16 at 00:17 +0200, Andi Kleen wrote:
> >> Daniel Walker wrote:
> >>> The semaphore usage in ACPI is more like completions. The ASL
> >>> functions getting implemented here are signals which follow a
> >>> "wait for", signaled, or reset format.
> >>>
> >>> This implements the ACPI signaling methods with the Linux
> >>> completion API, instead of using semaphores.
> >> NACK. I don't see the point of emulating semaphores when
> >> there are already perfectly fine semaphores available.
> > 
> > 
> > With semaphores as a super set, under that you have mutexes and
> > completions, and other un-classified usages.. Mutex usage is obviously
> > for mutual exclusion (semaphore initialized to 1), completions are used
> > for signaling (semaphore initialized to 0).
> 
> Let's put it differently: I just don't see how your change improves
> the code. Replacing one locking primitive with another has no value
> in itself that I can see unless it fixes something.
> 
> And when there is the choice I think it's cleaner and less confusing to use
> semaphores when the ACPICA asks for semaphores instead of something else.

Semaphore are very far from the right solution to any problem. They are
too broad, and they are _harder_ to understand.. They have so many
usages that who knows what ACPI is really doing unless you commit to a
specific sub-set of semaphores.

I think ACPI "asks" for semaphores because it's multi-OS, that's not an
excuse to keep using semaphores when they aren't needed. We have other
API's that will satisfy ACPI which are less broad, and ultimately
better.

Daniel


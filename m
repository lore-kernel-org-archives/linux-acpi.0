From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4] acpi: semaphore removal
Date: Sat, 16 Aug 2008 04:06:01 +0200
Message-ID: <48A63609.4020403@linux.intel.com>
References: <1218831242-27618-1-git-send-email-dwalker@mvista.com>	 <1218831242-27618-2-git-send-email-dwalker@mvista.com>	 <1218831242-27618-3-git-send-email-dwalker@mvista.com>	 <1218831242-27618-4-git-send-email-dwalker@mvista.com>	 <1218831242-27618-5-git-send-email-dwalker@mvista.com>	 <48A6008A.8080104@linux.intel.com> <1218845935.6166.116.camel@dhcp32.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:26417 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751168AbYHPCGH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 22:06:07 -0400
In-Reply-To: <1218845935.6166.116.camel@dhcp32.mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Robert Moore <robert.moore@intel.com>

Daniel Walker wrote:
> On Sat, 2008-08-16 at 00:17 +0200, Andi Kleen wrote:
>> Daniel Walker wrote:
>>> The semaphore usage in ACPI is more like completions. The ASL
>>> functions getting implemented here are signals which follow a
>>> "wait for", signaled, or reset format.
>>>
>>> This implements the ACPI signaling methods with the Linux
>>> completion API, instead of using semaphores.
>> NACK. I don't see the point of emulating semaphores when
>> there are already perfectly fine semaphores available.
> 
> 
> With semaphores as a super set, under that you have mutexes and
> completions, and other un-classified usages.. Mutex usage is obviously
> for mutual exclusion (semaphore initialized to 1), completions are used
> for signaling (semaphore initialized to 0).

Let's put it differently: I just don't see how your change improves
the code. Replacing one locking primitive with another has no value
in itself that I can see unless it fixes something.

And when there is the choice I think it's cleaner and less confusing to use
semaphores when the ACPICA asks for semaphores instead of something else.

-Andi


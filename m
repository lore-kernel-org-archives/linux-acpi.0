From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 5/9] HWPoison: add memory_failure_queue()
Date: Tue, 24 May 2011 11:07:57 +0800
Message-ID: <4DDB210D.6060202@intel.com>
References: <20110517092620.GI22093@elte.hu> <4DD31C78.6000209@intel.com> <20110520115614.GH14745@elte.hu> <BANLkTi=5Y0fqsmhsoPm8si=nQBc-tCwtrw@mail.gmail.com> <20110522100021.GA28177@elte.hu> <BANLkTi=VDQMOfWe5tP7nXSv2AEsiUUEteg@mail.gmail.com> <20110522132515.GA13078@elte.hu> <4DD9C8B9.5070004@intel.com> <20110523110151.GD24674@elte.hu> <4DDB1396.7050205@intel.com> <20110524024848.GA25230@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28877 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987Ab1EXDIA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 May 2011 23:08:00 -0400
In-Reply-To: <20110524024848.GA25230@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: huang ying <huang.ying.caritas@gmail.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>

On 05/24/2011 10:48 AM, Ingo Molnar wrote:
> 
> * Huang Ying <ying.huang@intel.com> wrote:
> 
>>>> - How to deal with ring-buffer overflow?  For example, there is full of 
>>>>   corrected memory error in ring-buffer, and now a recoverable memory error 
>>>>   occurs but it can not be put into perf ring buffer because of ring-buffer 
>>>>   overflow, how to deal with the recoverable memory error?
>>>
>>> The solution is to make it large enough. With *every* queueing solution there 
>>> will be some sort of queue size limit.
>>
>> Another solution could be:
>>
>> Create two ring-buffer. One is for logging and will be read by RAS
>> daemon; the other is for recovering, the event record will be removed
>> from the ring-buffer after all 'active filters' have been run on it.
>> Even RAS daemon being restarted or hang, recoverable error can be taken
>> cared of.
> 
> Well, filters will always be executed since they execute when the event is 
> inserted - not when it's extracted.

For filters executed in NMI context, they can be executed when the event
is inserted, no need for buffering.  But for filters executed in
deferred IRQ context, they need to be executed when event's extracted.

> So if you worry about losing *filter* executions (and dependent policy action) 
> - there should be no loss there, ever.
> 
> But yes, the scheme you outline would work as well: a counting-only event with 
> a filter specified - this will do no buffering at all.
> 
> So ... to get the ball rolling in this area one of you guys active in RAS 
> should really try a first approximation for the active filter approach: add a 
> test-TRACE_EVENT() for the errors you are interested in and define a convenient 
> way to register policy action with post-filter events. This should work even 
> without having the 'active' portion defined at the ABI and filter-string level.

Best Regards,
Huang Ying

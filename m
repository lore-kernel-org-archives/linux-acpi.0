From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 5/9] HWPoison: add memory_failure_queue()
Date: Tue, 24 May 2011 10:10:30 +0800
Message-ID: <4DDB1396.7050205@intel.com>
References: <20110517084622.GE22093@elte.hu> <4DD23750.3030606@intel.com> <20110517092620.GI22093@elte.hu> <4DD31C78.6000209@intel.com> <20110520115614.GH14745@elte.hu> <BANLkTi=5Y0fqsmhsoPm8si=nQBc-tCwtrw@mail.gmail.com> <20110522100021.GA28177@elte.hu> <BANLkTi=VDQMOfWe5tP7nXSv2AEsiUUEteg@mail.gmail.com> <20110522132515.GA13078@elte.hu> <4DD9C8B9.5070004@intel.com> <20110523110151.GD24674@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110523110151.GD24674@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: huang ying <huang.ying.caritas@gmail.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>
List-Id: linux-acpi@vger.kernel.org

On 05/23/2011 07:01 PM, Ingo Molnar wrote:
>> If my understanding as above is correct, I think this is a general and 
>> complex solution.  It is a little hard for user to understand which 'active 
>> filters' are in effect.  He may need some runtime assistant to understand the 
>> code (maybe /sys/events/active_filters, which list all filters in effect 
>> now), because that is hard only by reading the source code.  Anyway, this is 
>> a design style choice.
> 
> I don't think it's complex: the built-in rules are in plain sight (can be in 
> the source code or can even be explicitly registered callbacks), the 
> configuration/tooling installed rules will be as complex as the admin or tool 
> wants them to be.
> 
>> There are still some issues, I don't know how to solve in above framework.
>>
>> - If there are two processes request the same type of hardware error
>>   events.  One hardware error event will be copied to two ring buffers (each 
>>   for one process), but the 'active filters' should be run only once for each 
>>   hardware error event.
> 
> With persistent events 'active filters' should only be attached to the central 
> persistent event.

OK. I see.

>> - How to deal with ring-buffer overflow?  For example, there is full of 
>>   corrected memory error in ring-buffer, and now a recoverable memory error 
>>   occurs but it can not be put into perf ring buffer because of ring-buffer 
>>   overflow, how to deal with the recoverable memory error?
> 
> The solution is to make it large enough. With *every* queueing solution there 
> will be some sort of queue size limit.

Another solution could be:

Create two ring-buffer. One is for logging and will be read by RAS
daemon; the other is for recovering, the event record will be removed
from the ring-buffer after all 'active filters' have been run on it.
Even RAS daemon being restarted or hang, recoverable error can be taken
cared of.

Best Regards,
Huang Ying

From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] acpi: add real mutex function calls
Date: Mon, 21 Jul 2008 22:00:49 +0200
Message-ID: <4884EAF1.4050901@linux.intel.com>
References: <1216491411-24080-1-git-send-email-dwalker@mvista.com>	 <1216491411-24080-2-git-send-email-dwalker@mvista.com>	 <1216605078.4135.23.camel@yakui_zhao.sh.intel.com>	 <1216631698.7257.29.camel@twins>  <48845425.9000607@linux.intel.com>	 <1216632297.7257.31.camel@twins>  <4884E063.8080908@linux.intel.com> <1216668835.7257.91.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:5976 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754196AbYGUUAu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jul 2008 16:00:50 -0400
In-Reply-To: <1216668835.7257.91.camel@twins>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Daniel Walker <dwalker@mvista.com>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, len.brown@intel.com, Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>

Peter Zijlstra wrote:
> On Mon, 2008-07-21 at 21:15 +0200, Andi Kleen wrote:
>> Peter Zijlstra wrote:
>>> On Mon, 2008-07-21 at 11:17 +0200, Andi Kleen wrote:
>>>> Peter Zijlstra wrote:
>>>>> On Mon, 2008-07-21 at 09:51 +0800, Zhao Yakui wrote:
>>>>>> On Sat, 2008-07-19 at 11:16 -0700, Daniel Walker wrote:
>>>>>>> Instead of re-using semaphores for the mutex operation, I've
>>>>>>> added usage of the kernel mutex for the os mutex implementation.
>>>>>>>
>>>>>> What is the advantage that the kernel mutex is used for the ACPI mutex
>>>>>> implementation instead of using semaphore?
>>>>>> And it seems that too much ACPICA source code is touched.
>>>>> You get help from lockdep, and also our goal is to fully eradicate
>>>>> semaphore usage.
>>>> Issue is that ACPICA is shared with other OS source code and to replace 
>>>> a major interface like this would mean replacing it for everyone. It 
>>>> might end up with ACPICA just reimplementing a semaphore like wrapper if 
>>>> semaphores really go away, but I don't really see that coming anyways.
>>> Andi, you know better than that.
>> Know better than what?
> 
> Know better than to say we need ugly code in Linux because
> $SOME_OTHER_OS.

What ugly code do you refer to?

Ok ACPICA has its dark corners (I won't deny that), but at least willy's 
new semaphore code cannot really be described as "ugly".

>> My understanding was that there are a few areas
>> in the kernel who really use true semaphore semantics and I don't see it 
>> as particularly useful to force them to use something else that doesn't 
>> fit them as well.  And there are areas like ACPICA where semaphores are 
>> an useful abstraction because of other consideration (in ACPICA's case 
>> due to portability).
> 
> Does ACPICA use counting semaphores? If so, you could have used real
> arguments against his patches, instead of this other-os bull.

It is how ACPICA is maintained. You can yell at that as much as you want
and call it "bull", but that won't change it.

> Also, what is the justification for using counting semaphores? Are we
> counting hardware slots or is it just generic ACPI braindamage?

ACPICA is portable code and that needs a reasonably wide spread locking
abstraction. Happens to be semaphores for various reasons.

Now if mutexes were possible (AFAIK that's not possible in the general
case) then that would work too. But using "completions" as the low
level API doesn't make sense to me because it'll just lead to higher
level locking code being reinvented and also because it's unlikely
anything else has those with these semantics.

I think what would make sense is to identify the locks in ACPICA
which only have mutex semantics and convert them to a new osl mutex 
abstraction. Then at least some of the locks could get lockdep
checking.

On the other hand to be honest I'm not looking forward to handle
the usual 90+% false positives that you get out of lockdep ...

> Clearly this all wasn't extremely clear from the code - otherwise Daniel
> wouldn't even have done these patches.
> 
>> Especially now that semaphores are not duplicated per architecture 
>> anymore so actually keeping them around is not that costly.
> 
> Having them around might give people the idea its a good idea to use
> them. Not having them around is a good way to discourage that.

Code reviewers will take care of that.

-Andi

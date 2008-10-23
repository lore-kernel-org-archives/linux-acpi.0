From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] i7300_idle driver v1.55
Date: Thu, 23 Oct 2008 03:11:04 +0200
Message-ID: <48FFCF28.3070604@linux.intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com> <e8b529091b2ab65f5a4783e292c2b472e309116e.1223706853.git.len.brown@intel.com> <20081011083347.GA31918@elte.hu> <alpine.LFD.1.10.0810161805360.3026@localhost.localdomain> <48FE07AE.4010203@linux.intel.com> <7E82351C108FA840AB1866AC776AEC4637CD27F3@orsmsx505.amr.corp.intel.com> <48FED3FA.6040703@linux.intel.com> <20081022234006.GB28775@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:53352 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751969AbYJWBKz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Oct 2008 21:10:55 -0400
In-Reply-To: <20081022234006.GB28775@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Henroid, Andrew D" <andrew.d.henroid@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, paulmck@us.ibm.com

Venki Pallipadi wrote:
> On Wed, Oct 22, 2008 at 12:19:22AM -0700, Andi Kleen wrote:
>> Pallipadi, Venkatesh wrote:
>>> udelay may be more power efficient than polling.
>> Isn't that function a one off anyways?
> 
> Which function is one off?

The one with the udelays, as in being init code. Or maybe I misread
the code.

>>>> ;
>>>>> +static void __exit i7300_idle_exit(void)
>>>>> +{
>>>>> +     idle_notifier_unregister(&i7300_idle_nb);
>>>> I still think this needs some kind of idle synchronization.
>>> This unregister uses atomic_notifier_chain_unregister() which
>>> uses RCU and handles the race conditions that way.
>> I didn't do a full analysis, but I didn't think RCU protects
>> against the idle handler itself.  At least not standard RCU.
>> You would need to go through at least two quiescent periods,
>> not one as standard code.
>>
>> There used to be an older
>> idle synchronization interface for this case (which was removed
>> at some point), perhaps it needs to be readded.
>>
>> Or just use stop_machine(). That protects against idle too
>> and while it's a big hammer for unloading it should be ok.
>>
> 
> stop_machine() for unregistering idle callback will deadlock due to RCU.
> 
> I am not sure why we need two cycles. RCU in the unregister makes
> sure that no CPU is executing the callback handler 
> and only then unregister
> returns. So, that will mean no one can be in the callback rountine and we are
> safe to remove the module. Correct?

Perhaps I'm confused, but I thought with noidlehz the RCU code
got changed to take out idle CPUs out of the rcu masks. This makes
normally sense because you don't want to delay the grace period
for potentially very long sleeping CPUs.

But it means it won't work for code inside the idle loop. Ok maybe
if you're very careful with the ordering, but I'm not sure that's
the case currently.

Yes two cycles won't work either, sorry was confused earlier,
because even the second cycle wouldn't force the CPU out of idle.

The old idle sync code was more a thread that just cycled through
all the CPus. That would work.

cc Paul

-Andi


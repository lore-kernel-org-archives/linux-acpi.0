From: Mark Lord <lkml@rtr.ca>
Subject: Re: + restore-missing-sysfs-max_cstate-attr.patch added to -mm tree
Date: Sat, 05 Jan 2008 11:27:21 -0500
Message-ID: <477FAFE9.6090809@rtr.ca>
References: <20071130142058.816d1693.akpm@linux-foundation.org> <924EFEDD5F540B4284297C4DC59F3DEE2FAEAF@orsmsx423.amr.corp.intel.com> <4750CC78.9070105@rtr.ca> <20071130190227.1976e682@laptopd505.fenrus.org> <4750D180.6080001@rtr.ca> <20071130191816.3e744205@laptopd505.fenrus.org> <4750D585.1030200@rtr.ca> <477C2143.8090406@rtr.ca> <924EFEDD5F540B4284297C4DC59F3DEE4FC485@orsmsx423.amr.corp.intel.com> <477C622F.6010304@rtr.ca> <20080104021619.GA15409@linux-os.sc.intel.com> <477DA529.4000500@rtr.ca> <477EAAB0.1000101@rtr.ca> <924EFEDD5F540B4284297C4DC59F3DEE4FCC51@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1203 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907AbYAEQ1Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Jan 2008 11:27:24 -0500
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE4FCC51@orsmsx423.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, abelay@novell.com, lenb@kernel.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl

Pallipadi, Venkatesh wrote:
>> -----Original Message-----
>> From: Mark Lord [mailto:lkml@rtr.ca] 
..
>> Okay, with !CONFIG_CPU_IDLE, this works fine -- same as 2.6.23 
>> and earlier.
>>
> 
> Good to know. Atleast we do not have a regression for 2.6.24 now.
..

Agreed.  We're happy here, for now.

>>> Meanwhile, can you give a short summary of how behaviour differs
>>> between CONFIG_CPU_IDLE and !CONFIG_CPU_IDLE  ??
>>>
>>> I'm not at all clear on how this really affects things.
> 
> With CPU_IDLE, the C-state policy is removed from acpi driver. Ideally
> policy should have nothing to do with ACPI, as ACPI only provides the
> C-state mechanisms. So, with CPU_IDLE, it is not easy to control this
> variable through a acpi driver module at run time. Also, the latency
> interface that was mentioned before is to serve the same purpose in a
> more clear manner (based on the wakeup latency) instead of a C-state
> number which may not mean much from the end user point of view.
> 
> I will look at why latency does not work on a single core system
> soon(Was that with UP kernel or SMP kernel?). That way we will have a
> proper cover for this with CPU_IDLE in future.
..

That was with a UP kernel on a UP box.

The latency thingie really seemed to have little or no effect,
whereas setting max_cstate=1 has a quite noticeable positive impact.

Things seemed okay (with the latency thingie) on the SMP machine,
but with two cores it is probably simply more forgiving.  

cheers

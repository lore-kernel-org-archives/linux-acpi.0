From: Xiaotian Feng <dfeng@redhat.com>
Subject: Re: [PATCH -V2] acpi: don't cond_resched if irq is disabled
Date: Mon, 28 Dec 2009 14:02:30 +0800
Message-ID: <4B3849F6.1080403@redhat.com>
References: <20091210100907.GA2446@ucw.cz> <1260446205-16868-1-git-send-email-dfeng@redhat.com> <4B20E7B2.1010208@suse.de> <1260510373.10543.17.camel@minggr.sh.intel.com> <4B223185.80202@suse.de> <20091211161549.GA15760@elf.ucw.cz> <4B227275.5010201@gmail.com> <20091211173424.GC15760@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbZL1GDR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Dec 2009 01:03:17 -0500
In-Reply-To: <20091211173424.GC15760@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Lin Ming <ming.m.lin@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On 12/12/2009 01:34 AM, Pavel Machek wrote:
>
>>>> If there are none, fine.
>>>>
>>>>> #ifdef CONFIG_PREEMPT
>>>>> # define preemptible()  (preempt_count() == 0&&  !irqs_disabled())
>>>>> # define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
>>>>> #else
>>>>> # define preemptible()  0
>>>>> # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
>>>>> #endif
>>>>>
>>>
>>> Well, normally we want low latency even for !CONFIG_PREEMPT kernels.
>>>
>>> Actually, explicit preemption points are NOPs for CONFIG_PREEMPT
>>> kernels, right?
>
>> Right. Do you have code?
>
> I'd prefer to spend my time with patches to areas that actually do
> take cleanup patches.

What's the status of this now? We can still see the sleeping function 
call warning or enable irq at resume stage.
If acpi wants low latency even for !CONFIG_PREEMPT kernels, what's wrong 
with V2 patch?

We should not set any preemption points in irq or atomic. Since we have 
a simple fix, and it did fix bugs, why should
we make things more complex?

> 									Pavel


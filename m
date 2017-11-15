From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 15 Nov 2017 18:14:05 +0000
Message-ID: <f45c6d49-a22d-9ef2-fa2a-b8dc1009549d@arm.com>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
 <0569bb96-bd27-6c01-eb3c-5e4e1d868b2a@arm.com>
 <CAOZdJXXK62Sx75F8Ef62hjS-NBNh9Am_RBXjOzLbjvoQPGMUJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758043AbdKOSOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Nov 2017 13:14:09 -0500
In-Reply-To: <CAOZdJXXK62Sx75F8Ef62hjS-NBNh9Am_RBXjOzLbjvoQPGMUJg@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Len Brown <lenb@kernel.org>



On 15/11/17 15:33, Timur Tabi wrote:
> On Wed, Nov 8, 2017 at 8:18 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> I still prefer this as debugfs and not as sysfs ABI. We already have
>> issues with multiple interfaces for the same thing. E.g. cpufreq on x86.
>> I don't want this to end up in the same way after few years. CPUIdle
>> sysfs should be only sysfs ABI for these, adding an alternative is
>> inviting troubles for future especially if some user-space starts using
>> it and we will be stuck with that. Moreover with more h/w controlled
>> idle we may not provide accurate data sooner.
>>
>> Sorry for the noise, I will shup up now ;). Since this may be last
>> chance to make some noise, I am trying it. I completely understand that
>> this is just my opinion and am fine if others thinks it's good to make
>> this sysfs ABI.
> 
> Unfortunately, I think Prashanth really needs a specific requirement
> rather than opinions. 

I completely understand that. So for I haven't got a solid reason as
why debugfs is not sufficient? If it becomes so popular in future, we
can discuss and then make it sysfs ABI with more thoughts/discussions.

> This patch has been languishing for over a month, and we still have
> no idea whether it will make 4.15 or if Prashanth is *required* to
> make any more changes.
> 

It's sysfs ABI which we need to support for very long time(not in months
but in years), so waiting/discussing for couple of months is much safer
than spending more time to keep it the sysfs ABI unbroken.

Also I assume(was explicitly mentioned IIRC) that it's purely used
for debug and tuning purposes and hence I see *no need* to be part of
*sysfs ABI*. Let me know if the circumstances have changed.

-- 
Regards,
Sudeep

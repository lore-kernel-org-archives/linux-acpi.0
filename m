From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 15 Nov 2017 13:21:36 -0700
Message-ID: <dc8893cd-c90c-c7ca-0198-e462c4db2235@codeaurora.org>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
 <0569bb96-bd27-6c01-eb3c-5e4e1d868b2a@arm.com>
 <CAOZdJXXK62Sx75F8Ef62hjS-NBNh9Am_RBXjOzLbjvoQPGMUJg@mail.gmail.com>
 <f45c6d49-a22d-9ef2-fa2a-b8dc1009549d@arm.com>
 <CAJZ5v0hhtu=6-sKxykjUo7vjT9D6=E+oOQWh_AdNLOPoeQGcFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933624AbdKOUVi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Nov 2017 15:21:38 -0500
In-Reply-To: <CAJZ5v0hhtu=6-sKxykjUo7vjT9D6=E+oOQWh_AdNLOPoeQGcFw@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Timur Tabi <timur@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Len Brown <lenb@kernel.org>


On 11/15/2017 11:37 AM, Rafael J. Wysocki wrote:
> On Wed, Nov 15, 2017 at 7:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>> On 15/11/17 15:33, Timur Tabi wrote:
>>> On Wed, Nov 8, 2017 at 8:18 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>> I still prefer this as debugfs and not as sysfs ABI. We already have
>>>> issues with multiple interfaces for the same thing. E.g. cpufreq on x86.
>>>> I don't want this to end up in the same way after few years. CPUIdle
>>>> sysfs should be only sysfs ABI for these, adding an alternative is
>>>> inviting troubles for future especially if some user-space starts using
>>>> it and we will be stuck with that. Moreover with more h/w controlled
>>>> idle we may not provide accurate data sooner.
>>>>
>>>> Sorry for the noise, I will shup up now ;). Since this may be last
>>>> chance to make some noise, I am trying it. I completely understand that
>>>> this is just my opinion and am fine if others thinks it's good to make
>>>> this sysfs ABI.
>>> Unfortunately, I think Prashanth really needs a specific requirement
>>> rather than opinions.
>> I completely understand that. So for I haven't got a solid reason as
>> why debugfs is not sufficient? If it becomes so popular in future, we
>> can discuss and then make it sysfs ABI with more thoughts/discussions.
> Well, the recent discussions regarding tracepoints indicate that the
> ABI rule is not really about where the stuff is located in the
> directory structure. :-)
>
> The main question to me is whether or not the information exposed is
> more suitable for debugfs or for sysfs, considering all of the
> limitations (like one value per file rule in sysfs etc).
>
> Of course, debugfs means that the users of, say, Android will not be
> able to access this information, but should that really influence
> decisions at the technical level?
>
>>> This patch has been languishing for over a month, and we still have
>>> no idea whether it will make 4.15 or if Prashanth is *required* to
>>> make any more changes.
>>>
>> It's sysfs ABI which we need to support for very long time(not in months
>> but in years), so waiting/discussing for couple of months is much safer
>> than spending more time to keep it the sysfs ABI unbroken.
> In either case we need to be sure that the information is exposed the
> way everybody (who cares) likes and there won't be future attempts to
> tweak it to some needs that were not expressed at the outset.
>
> IOW, I'd like more people to look at this and let me know what they think.
>
>> Also I assume(was explicitly mentioned IIRC) that it's purely used
>> for debug and tuning purposes and hence I see *no need* to be part of
>> *sysfs ABI*. Let me know if the circumstances have changed.
> And that is a good argument for putting it into debugs.

Thanks Rafael and Sudeep!

I will take a look at moving this to debugfs.

--
Thanks,
Prashanth


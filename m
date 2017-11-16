From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Thu, 16 Nov 2017 10:50:51 -0700
Message-ID: <c45d5fc9-e613-bafd-cc06-60ccccd03019@codeaurora.org>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
 <0569bb96-bd27-6c01-eb3c-5e4e1d868b2a@arm.com>
 <CAOZdJXXK62Sx75F8Ef62hjS-NBNh9Am_RBXjOzLbjvoQPGMUJg@mail.gmail.com>
 <f45c6d49-a22d-9ef2-fa2a-b8dc1009549d@arm.com>
 <CAJZ5v0hhtu=6-sKxykjUo7vjT9D6=E+oOQWh_AdNLOPoeQGcFw@mail.gmail.com>
 <7bfe82ba-0063-0b58-de06-ac534eef36e9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965652AbdKPRuy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Nov 2017 12:50:54 -0500
In-Reply-To: <7bfe82ba-0063-0b58-de06-ac534eef36e9@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Timur Tabi <timur@codeaurora.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Len Brown <lenb@kernel.org>

Hey Sudeep,

On 11/16/2017 7:52 AM, Sudeep Holla wrote:
>
> On 15/11/17 18:37, Rafael J. Wysocki wrote:
>> On Wed, Nov 15, 2017 at 7:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On 15/11/17 15:33, Timur Tabi wrote:
>>>> On Wed, Nov 8, 2017 at 8:18 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>>> I still prefer this as debugfs and not as sysfs ABI. We already have
>>>>> issues with multiple interfaces for the same thing. E.g. cpufreq on x86.
>>>>> I don't want this to end up in the same way after few years. CPUIdle
>>>>> sysfs should be only sysfs ABI for these, adding an alternative is
>>>>> inviting troubles for future especially if some user-space starts using
>>>>> it and we will be stuck with that. Moreover with more h/w controlled
>>>>> idle we may not provide accurate data sooner.
>>>>>
>>>>> Sorry for the noise, I will shup up now ;). Since this may be last
>>>>> chance to make some noise, I am trying it. I completely understand that
>>>>> this is just my opinion and am fine if others thinks it's good to make
>>>>> this sysfs ABI.
>>>> Unfortunately, I think Prashanth really needs a specific requirement
>>>> rather than opinions.
>>> I completely understand that. So for I haven't got a solid reason as
>>> why debugfs is not sufficient? If it becomes so popular in future, we
>>> can discuss and then make it sysfs ABI with more thoughts/discussions.
>> Well, the recent discussions regarding tracepoints indicate that the
>> ABI rule is not really about where the stuff is located in the
>> directory structure. :-)
>>
> Agreed.
>
>> The main question to me is whether or not the information exposed is
>> more suitable for debugfs or for sysfs, considering all of the
>> limitations (like one value per file rule in sysfs etc).
>>
> I was thinking of keeping it simple and just one file for all the stats
> like we have /sys/kernel/debug/clk/clk_summary
>
> It looks somethings like below:
>    clock       enable_cnt  prepare_cnt    rate   accuracy   phase
> ----------------------------------------------------------------------
>  juno:uartclk         1            2     7273800       0      0
> ...
>
>
>> Of course, debugfs means that the users of, say, Android will not be
>> able to access this information, but should that really influence
>> decisions at the technical level?
>>
> That's the idea. IIUC, this is basically useful in the initial days of
> development to tune your idle parameters and for idle characterization.
> I am not sure(and hope) that this will be consumed by some application
> and acted upon dynamically. It's more like collect data, analyze, tune,
> repeat and rinse until happy with the tuning.
>
> Prashanth/Timur, please correct me if that's not the case. Understanding
> how the data is used is essential here.

One of the use case is definitely initial idle characterization. With the whole
hierarchy it does open up some additional use cases even after the initial
characterization depending on how high/deep the hierarchy is.

It is sometimes interesting to see how higher level idle states are getting utilized
for different workloads and tweaking some thread-placement may help make
a workload run more efficiently w.r.t power. Similarly how autopromotable states
are used with different workloads.

For the above use cases, the hierarchical view is very important, so we need a
way to represent the dependency b/w CPU, cluster and any other higher levels.
That's why the existing ACPI sysfs hierarchy was so nice. I haven't though about a
lot about how to represent  the above on a single debugfs file yet.

--
Thanks,
Prashanth

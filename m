From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] ACPI / Processor: add sysfs support for low power idle
Date: Thu, 31 Aug 2017 11:30:03 -0600
Message-ID: <ad5df545-23e6-c872-cf41-481ac094bce3@codeaurora.org>
References: <1499968082-7753-1-git-send-email-pprakash@codeaurora.org>
 <e0a869c1-704f-3fdd-0bcd-be954c2795b9@arm.com>
 <4ee02b4a-e287-34c3-0d61-a1c5a145c846@codeaurora.org>
 <2118329.renevTSach@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36220 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdHaRaF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Aug 2017 13:30:05 -0400
In-Reply-To: <2118329.renevTSach@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, lenb@kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org

On 8/28/2017 5:56 PM, Rafael J. Wysocki wrote:
> On Wednesday, August 23, 2017 6:04:42 PM CEST Prakash, Prashanth wrote:
>> Hi Rafael,
>>
>> On 8/1/2017 11:34 AM, Sudeep Holla wrote:
>>> On 01/08/17 18:15, Prakash, Prashanth wrote:
>>>> On 8/1/2017 3:18 AM, Sudeep Holla wrote:
>>>>> On 31/07/17 19:18, Prakash, Prashanth wrote:
>>>>>> Hi Sudeep,
>>>>>>
>>>>>> On 7/31/2017 10:25 AM, Sudeep Holla wrote:
>>>>>>> Sorry for the delay, I initial thought having this ABI under testing is
>>>>>>> fine as I really don't want any *real* user space programs to depend on
>>>>>>> this for various reasons stated in earlier threads, e.g. h/w auto
>>>>>>> promotable states, accuracy of the stats, ..etc
>>>>>> <sorry for repeating this part>
>>>>>> These fields are optional, so if there is no reliable way to keep track of  stats, platform
>>>>>> can choose not to expose it. If a platform is exposing inaccurate stats via this ACPI
>>>>>> interface, it is breaking the spec.
>>>>> Fair enough.
>>>>>
>>>>>>> But from Documentation/ABI/README, I see
>>>>>>>
>>>>>>> testing/
>>>>>>> 	This directory documents interfaces that are felt to be stable,
>>>>>>> 	as the main development of this interface has been completed.
>>>>>>> 	The interface can be changed to add new features, but the
>>>>>>> 	current interface will not break by doing this, unless grave
>>>>>>> 	errors or security problems are found in them. User space
>>>>>>> 	programs can start to rely on these interfaces,...
>>>>>>>
>>>>>>> which makes me worry. Since the use for this is purely for debug or
>>>>>>> optimization purposes, I still prefer simple single file debugfs entry.
>>>>>>> I still can't digest the fact that reading single file is time consuming
>>>>>>> as we are not using this interface at runtime IIUC. i.e. statistic are
>>>>>>> collected and analyzed offline.>> These fields has the same utility/use-cases as the usage & time
>>>>> fields in cpuidle sysfs,
>>>>>> but provides more granularity - idle stats for different levels hierarchy and accurate
>>>>>> idle stats for states that require platform co-ordination.
>>>>>>
>>>>> I completely agree with that and that's not the argument.
>>>>>
>>>>>> The argument for having a single sysfs file per node was that reading individual
>>>>>> files might get expensive to get a snapshot(not the other way around). But, that
>>>>>> argument was weak as we typically read these only in debug settings and not that
>>>>>> often during runtime. So, the summary_stats file was removed and went with one
>>>>>> value per file.
>>>>>>
>>>>> You are contradicting yourself above :). You say the argument you made
>>>>> is weak :) but still went ahead and dropped single debugfs file vs the
>>>>> standard per entry sysfs file which is an ABI.
>>>> To clarify, the first RFC patch had a sysfs entry called summary_stats which
>>>> provided all the stats for a specific node in hierarchy via a single file. The
>>>> argument for having such a single file was weak. :)  There was never a
>>>> debugfs file to be dropped in first place.
>>>>
>>> You are right, it was me who keep suggesting debugfs file as a
>>> replacement for your summary_stats sysfs file. Sorry for the confusion
>>> but I still insist debugfs :)
>>>
>>>>> Since we already have CPUIdle sysfs which is an ABI, I am really not
>>>>> sure if we need another set of ABI files which are used only for debug
>>>>> and optimization purposes. Why is single debugfs file not sufficient ?
>>>>>
>>>> The consumers for this data are not all kernel developers. We will have other
>>>> engineers looking at this data for power/performance optimizations and
>>>> would be nice to give them a consistent interface.
>>> Yes that's the case with any sysfs file users and that's why we can't
>>> break ABI once we expose.
>>>
>>>>> As hardware evolves, most of the platforms can't provide these
>>>>> information accurately. So if we are trying to address a problem which
>>>>> is short-lived and on very small class of platforms, I would avoid
>>>>> creating a new ABI for it. That's my main argument against this
>>>>> interface instead go with debugfs entry. That's my opinion though.
>>>> I would like to think of it in terms of ACPI spec rather than a subset of platforms.
>>>> If it is part of spec there should be no reason to speculate on which platform
>>>> may or may not implement it. We implement to the spec and ideally platform
>>>> designers should ideally do the same. >
>>>> Since sysfs vs debugfs is quite debatable :) , I will wait for Rafael's inputs.
>> Any inputs on this?
> Sorry for the slow response, but I'm still unconvinced about this.
>
> I generally don't like residency ("time" in your terminology, which is quite
> confusing BTW) / usage information in sysfs under ACPI device nodes, as it
> belongs to cpuidle rather.
>
> I know that it is easy to expose it this way, but can't we do better?
Last time I went though the code, I didn't find a good way to expose this outside
the ACPI hierarchy primarily because i couldn't find a good substitute to represent
the processor hierarchy.

I will take a look at it again.
> Also, I'd use file names following the spec language.  min_residency is fine,
> but "latency" would better be called "wakeup_latency" and why use "desc"
> rather than "state_name"?  Plust exposing "Enabled Parent State" might be
> useful.
I will switch the names to spec language on next version of this patch.

Thanks for your feedback!

--
Regards,
Prashanth

